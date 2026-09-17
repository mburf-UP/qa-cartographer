# check-map.ps1 - checks the map against the territory it claims to describe.
#
# The map makes two kinds of claim a machine can settle, and this script settles both:
#
#   1. PRESENCE. Every source a card cites is really there: at the path, at the line, under the
#      section heading, and where the card quotes the source, the quoted words are on the line
#      it points at.
#   2. ABSENCE. Every noun marked `ghost` is really absent. A ghost is the mark that costs a
#      newcomer the most (rules.md 4), and it is the only mark that asserts a negative, which is
#      the hardest thing in the map to be right about and the easiest to leave unchecked.
#
# WHY A SCRIPT AND NOT A PROMISE. This map has already shipped two defects of exactly these kinds,
# and a cold reader caught both rather than the person who wrote them: a stale commit pin in
# reference/collisions.md (FIX-05), and a ghost claim that overstated its own evidence (FIX-09).
# Neither needed judgement to catch. Both needed somebody to look, once, at every claim rather
# than at the claims they happened to remember. That is what this is for.
#
# THE INVERSION THAT MATTERS. A card marked `ghost` carrying no machine-checkable absence
# assertion is a FAIL, not a skip. Otherwise the cheapest way to pass is to assert nothing, and
# the mark that needs the most evidence would be the one carrying the least.
#
#   pwsh -NoProfile -File ./check-map.ps1
#
# Exit 0 = every claim checked out. Exit 1 = at least one claim is wrong, and so is the map.
#
# SAFETY. Strictly read-only against the territory. It opens files, lists directories, and runs
# `git rev-parse HEAD`. It never writes, never moves, never deletes, and never executes anything
# inside the territory. See ..\BRIEF.md, the hard rules.

# THE TERRITORY IS NOT IN THIS REPOSITORY AND ITS LOCATION IS NOT PUBLISHED. It is a third party's
# private commercial system, mapped with permission. Point the script at your own copy:
#
#   -Territory <path>            or    $env:QA_TERRITORY = '<path>'
#
# With neither, it looks for a `territory` folder beside the map and says so if it is not there.
# The map cites paths under `qa/`, so the territory root is the folder that CONTAINS `qa/`.

param(
    [string]$Territory,
    [string]$Map       = $PSScriptRoot,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($Territory)) {
    if ($env:QA_TERRITORY) {
        $Territory = $env:QA_TERRITORY
    } else {
        $Territory = Join-Path $PSScriptRoot 'territory'
    }
}

# Non-ASCII lives in the map (middle dot, section sign, ellipsis) but must never live in this file:
# check-map.ps1 has no BOM, so PowerShell 5.1 reads its source as ANSI and would silently mangle a
# literal. Each one is a regex escape instead. Same reason repo-guard.ps1 escapes its BOM.
$SECTION  = '\u00A7'      # section sign
$ELLIPSIS = '\u2026'      # horizontal ellipsis

$fails  = New-Object System.Collections.ArrayList
$warns  = New-Object System.Collections.ArrayList
$counts = @{ cards = 0; citations = 0; sections = 0; quotes = 0; ghosts = 0; assertions = 0 }

function Add-Fail($where, $msg) { [void]$fails.Add([pscustomobject]@{ Where = $where; Msg = $msg }) }
function Add-Warn($where, $msg) { [void]$warns.Add([pscustomobject]@{ Where = $where; Msg = $msg }) }
function Say($msg) { if (-not $Quiet) { Write-Host $msg } }

if (-not (Test-Path $Territory)) {
    Write-Host "FAIL  no territory at: $Territory"
    Write-Host "      Pass -Territory <path>, or set `$env:QA_TERRITORY. The territory root is the"
    Write-Host "      folder that contains qa/. It is not part of this repository."
    exit 1
}
if (-not (Test-Path $Map))       { Write-Host "FAIL  map not found at $Map"; exit 1 }

# Resolve both, or a relative -Map makes every reported path a truncated substring of itself.
$Territory = (Resolve-Path $Territory).Path
$Map       = (Resolve-Path $Map).Path

# ---------------------------------------------------------------------------
# Collect the cards.
#
# A card is a block headed `## Card ...` carrying the contract line from reference/card-types.md.
# Cards live in two places by design: examples.md holds the catalog and the three worked cards,
# map/ holds the rest. Material under tests/ is evidence ABOUT the map and is never a card, so it
# is not walked - including the verbatim run transcripts, which must not be validated against
# anything at all (METHOD.md 4, the preservation rule).
# ---------------------------------------------------------------------------

$cardFiles = @()
$ex = Join-Path $Map 'examples.md'
if (Test-Path $ex) { $cardFiles += (Get-Item $ex) }
$mapDir = Join-Path $Map 'map'
if (Test-Path $mapDir) {
    $cardFiles += @(Get-ChildItem -Path $mapDir -Filter '*.md' -File | Sort-Object Name)
}

if ($cardFiles.Count -eq 0) { Write-Host "FAIL  no card files found under $Map"; exit 1 }

$cards = New-Object System.Collections.ArrayList

foreach ($f in $cardFiles) {
    # -Encoding UTF8 is not optional: these files have no BOM, and without it PS 5.1 reads them as
    # ANSI, so every section sign and ellipsis in a Source line arrives mangled.
    $lines = @(Get-Content -Path $f.FullName -Encoding UTF8)

    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -notmatch '^##\s+Card\s') { continue }

        $title = $lines[$i].TrimStart('#', ' ').Trim()

        # Body runs to the next heading of the same or higher level, or to end of file.
        $end = $lines.Count - 1
        for ($j = $i + 1; $j -lt $lines.Count; $j++) {
            if ($lines[$j] -match '^#{1,2}\s') { $end = $j - 1; break }
        }
        $body = $lines[($i + 1)..$end]

        $typeLine = $null
        foreach ($b in $body) {
            if ($b -match '^\*\*Type\*\*') { $typeLine = $b; break }
        }

        [void]$cards.Add([pscustomobject]@{
            Title    = $title
            File     = $f.FullName
            Rel      = $f.FullName.Substring($Map.Length).TrimStart('\', '/')
            Line     = $i + 1
            TypeLine = $typeLine
            Body     = $body
        })
        $i = $end
    }
}

$counts.cards = $cards.Count

# ---------------------------------------------------------------------------
# Resolve one cited path against the territory.
#
# Four citation shapes appear in the cards and each means something different:
#   qa/TEST-PLAN.md              a file, which must exist
#   qa/scripts/                  a directory, which must exist and hold something
#   qa/scripts/cases/*.mjs       a glob, which must match at least one file
#   qa/handoffs/INDEX.md:132     a file plus a line, which must be in range
# ---------------------------------------------------------------------------

function Resolve-Citation($cite) {
    $lineNo = $null
    $path   = $cite

    if ($cite -match '^(.*?):(\d+)$') { $path = $Matches[1]; $lineNo = [int]$Matches[2] }

    $full = Join-Path $Territory ($path -replace '/', '\')
    $r = [pscustomobject]@{ Cite = $cite; Path = $path; Line = $lineNo; Ok = $false; Why = ''; Full = $full }

    if ($path -match '[\*\?]') {
        $parent = Split-Path $full -Parent
        $leaf   = Split-Path $full -Leaf
        if (-not (Test-Path $parent)) {
            $r.Why = "the directory does not exist: $(Split-Path $path -Parent)"
            return $r
        }
        $hits = @(Get-ChildItem -Path $parent -Filter $leaf -File -ErrorAction SilentlyContinue)
        if ($hits.Count -eq 0) { $r.Why = 'the glob matches nothing'; return $r }
        $r.Ok = $true; $r.Why = "$($hits.Count) file(s)"; return $r
    }

    if (-not (Test-Path $full)) { $r.Why = 'it does not exist'; return $r }

    if ($cite -match '/$') {
        if (-not (Test-Path $full -PathType Container)) {
            $r.Why = 'cited as a directory, but it is a file'
            return $r
        }
        $n = @(Get-ChildItem -Path $full -ErrorAction SilentlyContinue).Count
        if ($n -eq 0) { $r.Why = 'the directory is empty'; return $r }
        $r.Ok = $true; $r.Why = "$n entries"; return $r
    }

    if (Test-Path $full -PathType Container) { $r.Ok = $true; $r.Why = 'directory'; return $r }

    if ($null -ne $lineNo) {
        $n = @(Get-Content -Path $full -Encoding UTF8).Count
        if ($lineNo -lt 1 -or $lineNo -gt $n) {
            $r.Why = "line $lineNo is out of range; the file has $n lines"
            return $r
        }
        $r.Ok = $true; $r.Why = "line $lineNo of $n"; return $r
    }

    $r.Ok = $true; $r.Why = 'file'
    return $r
}

# ---------------------------------------------------------------------------
# CHECK 1 - every card has a Source, and every commit pin agrees.
#
# card-types.md: "A card with no source is not a card." walk-order.md requires the map to pin the
# commit it was made from. Two files pinning different commits is the FIX-05 defect, which shipped
# and which a cold reader caught rather than its author.
# ---------------------------------------------------------------------------

$pins = @{}

function Add-Pin($pin, $who) {
    if (-not $pins.ContainsKey($pin)) { $pins[$pin] = New-Object System.Collections.ArrayList }
    [void]$pins[$pin].Add($who)
}

foreach ($c in $cards) {
    if ($null -eq $c.TypeLine) {
        Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): no contract line (**Type** / **Mark** / **Source**)"
        continue
    }
    if ($c.TypeLine -notmatch '\*\*Source\*\*') {
        Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): the contract line has no **Source** field"
    }
    if ($c.TypeLine -match 'commit\s+.([0-9a-f]{7,40}).') {
        Add-Pin $Matches[1] $c.Title
    } else {
        Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): the Source names no commit"
    }
}

# Reference files pin the commit too, and disagreement between them is the same defect.
$refDir = Join-Path $Map 'reference'
foreach ($rf in @(Get-ChildItem -Path $refDir -Filter '*.md' -File -ErrorAction SilentlyContinue)) {
    $txt = (Get-Content -Path $rf.FullName -Encoding UTF8) -join "`n"
    foreach ($m in [regex]::Matches($txt, 'commit\s+.([0-9a-f]{7,40}).')) {
        Add-Pin $m.Groups[1].Value "reference/$($rf.Name)"
    }
}

if ($pins.Keys.Count -gt 1) {
    $detail = ($pins.Keys | ForEach-Object { "$_ ($($pins[$_] -join ', '))" }) -join ' vs '
    Add-Fail 'map' "the map pins more than one commit: $detail"
}

# Compare the pin against the territory's actual HEAD. A staged read-only snapshot is not a git
# repository, so this degrades to a warning rather than a failure - the same fallback run 02 made,
# and said it was making, recorded in tests/fix-log.md.
# A territory that merely SITS INSIDE some other repository has no commit of its own. Asking git
# for HEAD there answers about the enclosing repository, which is a different body of work, and
# comparing the map's pin against it would fail for a reason that has nothing to do with the map.
# So the pin is only checked when the territory is itself the repository root.
$head = $null
if (Test-Path (Join-Path $Territory '.git')) {
    Push-Location $Territory
    try {
        $out = (& git rev-parse HEAD)
        if ($LASTEXITCODE -eq 0) { $head = "$out".Trim() }
    } catch {
        $head = $null
    } finally {
        Pop-Location
    }
}

if ([string]::IsNullOrWhiteSpace($head)) {
    $head = $null
    Add-Warn 'map' 'the territory is not a git repository in its own right, so the commit pin could not be checked against HEAD'
} else {
    foreach ($pin in $pins.Keys) {
        if (-not $head.StartsWith($pin)) {
            Add-Fail 'map' ("pinned to $pin but the territory is at " + $head.Substring(0, 8) + '; the map describes a commit that is not checked out')
        }
    }
}

# ---------------------------------------------------------------------------
# CHECK 2 - every cited source exists, at the line and under the section cited.
#
# Body citations count, not only the Source field. A broken path in the middle of a card sends a
# reader to nothing just as surely as a broken one in the header does.
# ---------------------------------------------------------------------------

foreach ($c in $cards) {
    $raw = ($c.Body) -join "`n"

    # Everything below reads the card's PROSE, so the ghost-check comments come out first. They are
    # instructions to this script, not claims to a reader, and leaving them in made the quote check
    # try to verify a ghost-check's own symbol name against the source - a false positive that
    # passed here only by coincidence, because the symbol happened to appear on a cited line.
    $text = [regex]::Replace($raw, '(?s)<!--.*?-->', '')
    $seen = @{}

    foreach ($m in [regex]::Matches($text, '.(qa/[^`\s]*).')) {
        $cite = $m.Groups[1].Value
        if ($seen.ContainsKey($cite)) { continue }
        $seen[$cite] = $true
        $counts.citations++

        $r = Resolve-Citation $cite
        if (-not $r.Ok) {
            Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): cites $cite - $($r.Why)"
        }
    }

    # A section reference immediately after a citation must be a real heading in that file.
    $secPattern = '.(qa/[^`\s]*\.md).\s*' + $SECTION + '\s*([\d]+(?:\.[\d]+)*)'
    foreach ($m in [regex]::Matches($text, $secPattern)) {
        $cite = $m.Groups[1].Value
        $sec  = $m.Groups[2].Value
        $counts.sections++

        $r = Resolve-Citation $cite
        if (-not $r.Ok) { continue }   # already reported as a broken path

        $src = @(Get-Content -Path $r.Full -Encoding UTF8)
        $hit = @($src | Where-Object { $_ -match ('^#{1,6}\s+' + [regex]::Escape($sec) + '(\s|$)') })
        if ($hit.Count -eq 0) {
            Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): cites $cite section $sec, which is not a heading in that file"
        }
    }

    # Where the card quotes the source, the quoted words must be on one of the lines it cites.
    # rules.md 8 allows one short quote "only when the exact wording is the point" - which is
    # exactly when it is worth confirming the wording is the source's and not the cartographer's.
    $citedLines = New-Object System.Collections.ArrayList
    foreach ($m in [regex]::Matches($text, '.(qa/[^`\s]*:\d+).')) {
        $r = Resolve-Citation $m.Groups[1].Value
        if ($r.Ok) {
            $src = @(Get-Content -Path $r.Full -Encoding UTF8)
            [void]$citedLines.Add($src[$r.Line - 1])
        }
    }

    if ($citedLines.Count -gt 0) {
        foreach ($m in [regex]::Matches($text, '"([^"]{12,})"')) {
            $quote = $m.Groups[1].Value
            $counts.quotes++

            # An elided quote is checked fragment by fragment: the ellipsis stands for text the
            # card left out, so each surviving run of words must still appear on the cited line.
            $frags = @([regex]::Split($quote, ($ELLIPSIS + '|\.\.\.')) |
                       ForEach-Object { $_.Trim() } |
                       Where-Object { $_.Length -ge 6 })

            if ($frags.Count -eq 0) { continue }

            $matched = $false
            foreach ($ln in $citedLines) {
                $norm = ($ln -replace '\s+', ' ')
                $all  = $true
                foreach ($fr in $frags) {
                    $fn = ($fr -replace '\s+', ' ')
                    if ($norm -notmatch [regex]::Escape($fn)) { $all = $false; break }
                }
                if ($all) { $matched = $true; break }
            }
            if (-not $matched) {
                Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): quotes '$quote' but those words are not on any line it cites"
            }
        }
    }
}

# ---------------------------------------------------------------------------
# CHECK 3 - every ghost is genuinely absent.
#
# A ghost card must carry at least one assertion a machine can settle, written beside the claim as
# an HTML comment so it renders invisibly and cannot drift away from the sentence it backs:
#
#   <!-- ghost-check: path qa/scripts/append-defect.mjs absent -->
#   <!-- ghost-check: symbol "someFunction" absent-from apps -->
#   <!-- ghost-check: unverifiable <reason it cannot be settled here> -->
#
# Paths are relative to the territory root, not to qa/.
#
# SCOPE IS THE SUBSTANCE. An absence claim with no scope is either unfalsifiable or false, which is
# exactly what produced FIX-09: a card said a function "exists and nothing calls it" when the
# engagement's own notes said nothing in the PRODUCT calls it. Two words lost in paraphrase, and a
# careful claim became a wrong one. So "absent" alone is not accepted; every symbol assertion names
# the scope its absence holds in.
#
# AND SOMETIMES THE SCOPE CANNOT BE PUBLISHED. This repository describes a third party's live
# system and does not publish its internals, so one real ghost here cannot be settled in public at
# all. That case gets `unverifiable` plus a reason, and it is reported as a WARN on every run -
# including a passing one. It is a declaration, not an exemption: the reader is told which ghost
# rests on documents rather than on a check.
#
# EVERY ASSERTION IS SETTLED WHEREVER IT APPEARS, not only on ghost-marked cards. A live noun can
# contain a dead name - `qa/scripts/` is live and advertises two helper scripts that do not exist -
# and that ghost is exactly as expensive to a newcomer as one filling a whole card. The mark
# governs what a card MUST carry; it does not govern what gets checked.
# ---------------------------------------------------------------------------

foreach ($c in $cards) {
    if ($null -eq $c.TypeLine) { continue }
    if ($c.TypeLine -notmatch '\*\*Mark\*\*\s+\*{0,2}(live|leftover|ghost|unknown)\*{0,2}') {
        Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): the Mark is missing, or is not one of live / leftover / ghost / unknown"
        continue
    }
    $isGhost = ($Matches[1] -eq 'ghost')
    if ($isGhost) { $counts.ghosts++ }

    $text    = ($c.Body) -join "`n"
    $asserts = @([regex]::Matches($text, '<!--\s*ghost-check:\s*(.+?)\s*-->'))

    if ($asserts.Count -eq 0) {
        if ($isGhost) {
            Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): marked ghost and asserts nothing checkable. A ghost claims a negative and must say which negative, or the mark needing the most evidence carries the least"
        }
        continue
    }

    foreach ($a in $asserts) {
        $claim = $a.Groups[1].Value
        $counts.assertions++

        if ($claim -match '^unverifiable\s+(.+)$') {
            # A ghost whose absence cannot be settled mechanically. This exists because one real
            # ghost here can only be proved by naming internals of a third party's production
            # system, which this repository does not publish. The declaration is not a way out:
            # it demands a stated reason, and it prints on every run, including a passing one, so
            # an unproved ghost can never become invisible through habit.
            Add-Warn "$($c.Rel):$($c.Line)" "$($c.Title): ghost declared unverifiable - $($Matches[1])"
            continue
        }
        elseif ($claim -match '^path\s+(\S+)\s+absent$') {
            $rel  = $Matches[1]
            $full = Join-Path $Territory ($rel -replace '/', '\')
            if (Test-Path $full) {
                Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): asserts $rel is absent, but it exists. The ghost has resolved - record that, do not delete it (tests/ghost-resolved.md)"
            }
        }
        elseif ($claim -match '^symbol\s+"([^"]+)"\s+absent-from\s+(\S+)$') {
            $sym   = $Matches[1]
            $scope = $Matches[2]
            $full  = Join-Path $Territory ($scope -replace '/', '\')

            if (-not (Test-Path $full)) {
                Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): asserts '$sym' is absent from $scope, but $scope does not exist. An absence proved against nothing proves nothing"
                continue
            }

            $hits = @(Get-ChildItem -Path $full -Recurse -File -ErrorAction SilentlyContinue |
                      Select-String -Pattern $sym -SimpleMatch -List -ErrorAction SilentlyContinue)

            if ($hits.Count -gt 0) {
                $where = ($hits | Select-Object -First 3 |
                          ForEach-Object { $_.Path.Substring($Territory.Length).TrimStart('\') }) -join ', '
                Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): asserts '$sym' is absent from $scope, but it appears in $($hits.Count) file(s): $where"
            }
        }
        else {
            Add-Fail "$($c.Rel):$($c.Line)" "$($c.Title): ghost-check not understood: '$claim'. Use: path <rel> absent | symbol <text> absent-from <rel>"
        }
    }
}

# ---------------------------------------------------------------------------
# Report. Counts first, so a pass says what it actually checked rather than only saying pass.
# ---------------------------------------------------------------------------

$at = ' (not a git repository)'
if ($head) { $at = ' at ' + $head.Substring(0, 8) }

Say ''
Say ('  territory  ' + $Territory + $at)
Say ('  map        ' + $Map)
Say ('  checked    {0} cards, {1} citations, {2} section refs, {3} quotes, {4} ghost(s) carrying {5} assertion(s)' -f `
        $counts.cards, $counts.citations, $counts.sections, $counts.quotes, $counts.ghosts, $counts.assertions)
Say ''

foreach ($w in $warns) { Say ('WARN  {0}{1}      {2}' -f $w.Where, [Environment]::NewLine, $w.Msg) }
if ($warns.Count -gt 0) { Say '' }

if ($fails.Count -gt 0) {
    foreach ($f in $fails) {
        Write-Host ('FAIL  {0}{1}      {2}' -f $f.Where, [Environment]::NewLine, $f.Msg)
    }
    Write-Host ''
    Write-Host ('FAIL  {0} claim(s) in this map are not true of the territory.' -f $fails.Count)
    Write-Host '      Where a card and the source disagree, the source wins and the card is wrong (rules.md 8).'
    exit 1
}

Write-Host ('PASS  every cited source resolves and every ghost is absent where it claims to be ({0} cards, {1} citations, {2} ghost assertion(s)).' -f `
    $counts.cards, $counts.citations, $counts.assertions)
exit 0
