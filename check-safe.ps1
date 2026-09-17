# check-safe.ps1 - refuses to let this repository ship anything that identifies the live system.
#
# THE PROBLEM THIS EXISTS FOR. This map describes a QA engagement against somebody else's
# production platform, and it gets published to a public repository linked from an open chat. The
# map's value is the SHAPE of the engagement - the traps, the marks, the hits and does-not-hits.
# None of that value needs a real account name, a real domain, a real person, or a real security
# property of a running system. But a cold reader writing a transcript has every reason to paste
# exactly those things in, because they make the answer concrete and the reader has no idea the
# transcript is about to be published.
#
# So the risk is not carelessness. It is that the useful instinct and the dangerous one are the
# same instinct, and it recurs every single time a new run is recorded.
#
#   pwsh -NoProfile -File check-safe.ps1
#
# Exit 0 = nothing identifying found. Exit 1 = something is, and it does not ship until it is
# redacted or, for a REVIEW rule only, allow-listed with a stated reason in safe-allow.txt.
#
# TWO CLASSES, AND THE DIFFERENCE MATTERS.
#
#   BLOCK   Identifiers. An address, a domain, a person, a repository, an internal symbol. These
#           are mechanical, unambiguous, and CANNOT be allow-listed. There is no version of this
#           entry that needs them.
#   REVIEW  Security-shaped statements - an authentication behaviour, an administrative route, a
#           privilege that cannot be revoked. These need judgement: the abstract pattern is the
#           whole point of the map and must survive, while the specific instance must not. A
#           REVIEW hit fails until a human writes down why the abstract form is safe.
#
# Redactions in a run transcript follow tests/METHOD.md 4: mark them inline as
# [REDACTED: reason] and change nothing else on the line. A visible redaction is evidence; a
# silent edit is indistinguishable from never having tested.
#
# THIS FILE IS NOT SCANNED. It necessarily contains every pattern it looks for. That is a known
# hole and it is stated rather than hidden: do not put content in here.

param(
    [string]$Root = $PSScriptRoot,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

$AllowFile = Join-Path $Root 'safe-allow.txt'
$SelfNames = @('check-safe.ps1', 'safe-allow.txt')

# ---------------------------------------------------------------------------
# The rules.
#
# Each is id / class / pattern / what it would tell an outsider. The last column is not decoration:
# a rule whose harm nobody can state is a rule nobody will maintain, and it will be suppressed the
# first time it is inconvenient.
# ---------------------------------------------------------------------------

$rules = @(
    @{ id = 'email';       class = 'BLOCK';  re = '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'; why = 'a real address is half a credential and names a real person' }
    @{ id = 'account';     class = 'BLOCK';  re = '\bmb[-+]?qa\d*@?|\bmb@';                          why = 'a login identifier on a live platform' }
    @{ id = 'product';     class = 'BLOCK';  re = 'urban[\s-]?pulse';                                why = 'names the live system every other detail then attaches to' }
    @{ id = 'domain';      class = 'BLOCK';  re = '\.com\.au\b|\bM365\b|\bStripe\b';                 why = 'identifies the domain, mail tenant or payment provider' }
    @{ id = 'repo';        class = 'BLOCK';  re = 'GenesisMatrix\w*|github\.com/\S+';                why = 'identifies the private repository and its owning organisation' }
    @{ id = 'person';      class = 'BLOCK';  re = '\bGuy\b|\bJake\b';                                why = 'names a real third party and a real team' }
    @{ id = 'pr';          class = 'BLOCK';  re = 'PR\s*#\d+|\bPR #\d+';                             why = 'a pull request number ties the text to a specific private repo' }
    @{ id = 'symbol';      class = 'BLOCK';  re = 'grant_org_entitlement|SECURITY DEFINER';          why = 'names the entitlement write path - a signpost to the billing-bypass surface' }
    @{ id = 'caseid';      class = 'BLOCK';  re = '\bUP-[A-Z]{2,}-?\d*';                             why = 'case ID prefixes encode the product pillars' }
    @{ id = 'guid';        class = 'BLOCK';  re = 'vscode-webview://[A-Za-z0-9]+';                   why = 'a leaked local session identifier, and it is simply noise' }
    @{ id = 'localpath';   class = 'BLOCK';  re = '[A-Za-z]:\\(?:HaMakor|GenesisMatrix)\S*';         why = 'absolute local paths expose the operator machine layout' }

    @{ id = 'privilege';   class = 'REVIEW'; re = 'superadmin|super-admin';                          why = 'a named privilege level on a running platform' }
    @{ id = 'revocation';  class = 'REVIEW'; re = 'cannot be revoked|not be revoked';                why = 'an unremediated finding from a security audit' }
    @{ id = 'authbypass';  class = 'REVIEW'; re = 'primary identity behind|SSO resolves|SSO returns'; why = 'describes a live authentication weakness precisely enough to reproduce' }
    @{ id = 'adminroute';  class = 'REVIEW'; re = '/admin\b';                                        why = 'names an administrative route meant to be invisible' }
    @{ id = 'hidden';      class = 'REVIEW'; re = 'dark[\s-]feature|dark feature';                   why = 'tells an outsider there is hidden functionality to hunt for' }
    @{ id = 'purge';       class = 'REVIEW'; re = 'purge tool|staff-domain';                         why = 'describes how account classification can be defeated' }
    @{ id = 'ratelimit';   class = 'REVIEW'; re = 'bucket that refills|refilling bucket';            why = 'describes the rate limiter precisely enough to pace around it' }
)

# ---------------------------------------------------------------------------
# Allow-list. REVIEW rules only; a BLOCK can never be allow-listed.
# Format, one per line:   <rule-id> | <path relative to root> | <reason>
# ---------------------------------------------------------------------------

$allow = @()
if (Test-Path $AllowFile) {
    foreach ($ln in (Get-Content -Path $AllowFile -Encoding UTF8)) {
        $t = $ln.Trim()
        if ($t.Length -eq 0 -or $t.StartsWith('#')) { continue }
        $p = $t -split '\s*\|\s*'
        if ($p.Count -lt 3) { continue }
        $allow += ,[pscustomobject]@{ Id = $p[0].Trim(); Path = $p[1].Trim(); Reason = $p[2].Trim() }
    }
}

# Each allow entry records whether it actually fired. An entry that matches nothing is dead and gets
# reported, because a stale exemption reads exactly like a live one and nobody re-reads a file that
# is passing.
foreach ($a in $allow) { $a | Add-Member -NotePropertyName Used -NotePropertyValue 0 -Force }

function Test-Allowed($id, $rel) {
    foreach ($a in $allow) {
        if ($a.Id -ne $id) { continue }
        if ($a.Path -eq '*' -or $a.Path -eq $rel) { $a.Used++; return $true }
    }
    return $false
}

# ---------------------------------------------------------------------------
# Scan.
# ---------------------------------------------------------------------------

# .git is excluded explicitly rather than left to the hidden attribute, which is a filesystem
# accident and not a rule. It holds no shipped content, and its config carries the remote URL, so
# scanning a fresh clone would otherwise report the repository's own address as a leak.
$sep = [System.IO.Path]::DirectorySeparatorChar
$files = @(Get-ChildItem -Path $Root -Recurse -File -Force |
           Where-Object { $_.FullName.Split($sep) -notcontains '.git' } |
           Where-Object { $SelfNames -notcontains $_.Name } |
           Sort-Object FullName)

$blocked    = New-Object System.Collections.ArrayList
$suppressed = New-Object System.Collections.ArrayList
$review    = New-Object System.Collections.ArrayList
$allowed   = 0
$scanned   = 0

foreach ($f in $files) {
    $rel = $f.FullName.Substring($Root.Length).TrimStart('\', '/') -replace '\\', '/'
    $scanned++

    $lines = @(Get-Content -Path $f.FullName -Encoding UTF8 -ErrorAction SilentlyContinue)
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $ln = $lines[$i]
        if ([string]::IsNullOrWhiteSpace($ln)) { continue }

        foreach ($r in $rules) {
            $m = [regex]::Match($ln, $r.re, 'IgnoreCase')
            if (-not $m.Success) { continue }

            if ($r.class -eq 'REVIEW' -and (Test-Allowed $r.id $rel)) {
                $allowed++
                [void]$suppressed.Add([pscustomobject]@{ Rel = $rel; Line = $i + 1; Id = $r.id; Text = $m.Value })
                continue
            }

            $hit = [pscustomobject]@{
                Rel  = $rel
                Line = $i + 1
                Id   = $r.id
                Why  = $r.why
                Text = $m.Value
            }
            if ($r.class -eq 'BLOCK') { [void]$blocked.Add($hit) } else { [void]$review.Add($hit) }
        }
    }
}

# ---------------------------------------------------------------------------
# Report.
# ---------------------------------------------------------------------------

function Say($m) { if (-not $Quiet) { Write-Host $m } }

Say ''
Say ('  scanned    {0} files under {1}' -f $scanned, $Root)
Say ('  rules      {0} block, {1} review; {2} allow-listed hit(s)' -f `
        (@($rules | Where-Object { $_.class -eq 'BLOCK' })).Count,
        (@($rules | Where-Object { $_.class -eq 'REVIEW' })).Count,
        $allowed)
Say ''

# EVERY SUPPRESSION IS PRINTED, on a pass as well as a failure.
#
# This is here because the allow-list lied and nothing noticed. Two entries claimed a security
# mechanism had been "reduced to the abstract form" when the full, reproducible text was still
# sitting in the file. The scan passed. It printed "11 allow-listed hit(s)" and moved on, and the
# claim went unread for as long as the count looked normal.
#
# A count is not a control. An exemption that cannot be seen is indistinguishable from an exemption
# that is doing its job, so the exemptions are shown - with the text they excuse - every time.
if ($suppressed.Count -gt 0) {
    Say 'SUPPRESSED  allow-listed by safe-allow.txt. Read these; do not skim them.'
    foreach ($h in $suppressed) {
        $reason = ''
        foreach ($a in $allow) {
            if ($a.Id -eq $h.Id -and ($a.Path -eq '*' -or $a.Path -eq $h.Rel)) { $reason = $a.Reason; break }
        }
        Say ('  {0}:{1}  [{2}]  "{3}"' -f $h.Rel, $h.Line, $h.Id, $h.Text)
        Say ('       claimed: {0}' -f $reason)
    }
    Say ''
}

# A dead allow entry is reported too. It reads exactly like a live one, and nobody re-reads a file
# that is passing.
$stale = @($allow | Where-Object { $_.Used -eq 0 })
if ($stale.Count -gt 0) {
    foreach ($a in $stale) {
        Write-Host ('STALE  safe-allow.txt: "{0} | {1}" matches nothing and should be deleted.' -f $a.Id, $a.Path)
    }
    Say ''
}

foreach ($h in $blocked) {
    Write-Host ('BLOCK  {0}:{1}  [{2}]  "{3}"' -f $h.Rel, $h.Line, $h.Id, $h.Text)
    Write-Host ('       {0}' -f $h.Why)
}
foreach ($h in $review) {
    Write-Host ('REVIEW {0}:{1}  [{2}]  "{3}"' -f $h.Rel, $h.Line, $h.Id, $h.Text)
    Write-Host ('       {0}' -f $h.Why)
}

$total = $blocked.Count + $review.Count
if ($total -gt 0) {
    Write-Host ''
    Write-Host ('FAIL  {0} identifying item(s): {1} blocked, {2} for review.' -f $total, $blocked.Count, $review.Count)
    Write-Host '      BLOCK items are redacted, never allow-listed.'
    Write-Host '      REVIEW items are redacted, or allow-listed in safe-allow.txt with a stated reason.'
    Write-Host '      In a run transcript, redact per tests/METHOD.md 4: [REDACTED: reason], nothing else on the line changes.'
    exit 1
}

Write-Host ('PASS  nothing identifying in {0} files: no address, domain, person, repository, product name, case ID or security property of a running system.' -f $scanned)
exit 0
