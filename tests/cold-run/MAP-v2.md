<!-- MAP-v2. DERIVED, not a transcript.
     Base: the map produced cold in run 02 (tests/cold-run/produced-map-run02.md), unchanged
     except for the edits listed under "What changed in v2" at the foot of this file.
     Those edits are FIX-08 and FIX-11 in tests/fix-log.md and nothing else: no card was written,
     no claim was corrected, no wording was improved. The point of the pair is that the only
     variable between run 03 and run 05 is how the map handles its own gaps. -->

# Map of `territory/` — production QA

> **De-identified before publication.** This transcript is otherwise verbatim. Mechanically substituted throughout: real account addresses became `alias-1` / `alias-2` or "the owner's own account"; the product name became "the platform"; case IDs lost their two-letter product prefix; pillar names, the developer's name, the repository name and pull-request numbers were generalised; local `vscode-webview://` link targets became `./`. Anything **removed** rather than substituted is marked inline as `[REDACTED: reason]` per `METHOD.md` §4. No claim, count, verdict or reasoning was altered.

**Made 2026-08-22.** I could not pin a commit: this folder is **not a git repository**, so `walk-order.md`'s "pin the commit" rule cannot be satisfied. Pinned by date instead — files dated 2026-08-21, latest dated content _inside_ them **2026-08-18** ([handoffs/INDEX.md](./territory/handoffs/INDEX.md)). Anything below is four days old at best.

**Where a card and the file disagree, the file wins and the card is wrong.**

## Where you start, and why

**The catalog below, then card 1, then stop.** Not [README.md](./territory/README.md), and specifically **not the newest-looking file in `handoffs/`**.

Why that order: the catalog is ranked by what a mistake _costs_, not by topic. The top entry is the only kind of noun whose failure mode is **invisible success** — you can get it wrong, watch every case pass, and have silently voided an entire phase. Nothing on screen corrects you. Everything else in this engagement announces itself when you get it wrong.

**Before any card, read [QA-TERMS.md](./territory/QA-TERMS.md)** — the territory's own jargon buster — and `cartographer/reference/collisions.md`. In this engagement `Pass` does not mean "nothing found", `archived` does not mean "fixed", `dark` means built and hidden on purpose so _finding_ it is the bug, and a Network panel reading `0 / 221 requests` captured 221 things. (`collisions.md` is pinned to commit `3d5edab6`, which I cannot check against; the two files agreed everywhere I compared them.)

**This engagement has been wrong about itself repeatedly, and it writes the corrections down rather than tidying them away.** OBS-005 concluded analytics was dark; it was live and collecting, and OBS-012 supersedes it — the superseded entry is kept as the record of the error. OBS-072 was graded S1 for an hour and corrected down. OBS-024 was re-diagnosed after its "fix". A whole test case (`SEND-029`) was withdrawn because its premise was invented, and the tester was right to refuse to run it. `+`-addressing was proposed twice more after the tester reported three times that it did not work, and the lesson recorded is _"when the tester reports a constraint, that is an observation"_. **Pushing back on an instruction that does not add up is the normal, expected, highest-value thing you can do here**, and there is a track record of it being welcomed. Corrections live in [OBSERVATIONS-REGISTER.md](./territory/OBSERVATIONS-REGISTER.md) and in the RESPONSE files under [handoffs/](./territory/handoffs/).

## The catalog

|#|Noun|Type|Mark|Card|The question it answers|
|---|---|---|---|---|---|
|1|**The test accounts**|Identity|live|**written**|Which account do I run this case as, and why does that change the result?|
|2|**The comped PRO persona**|Identity|**ghost**|**not written — ask**|Why can I not run the eight P14 entitlement cases?|
|3|**The build under test**|Subject|live|**not written — ask**|Am I testing a build that contains the fix I am retesting?|
|4|**The test suite workbook**|Instrument|live|**not written — ask**|Where do I record a result, and which cells survive a rebuild?|
|5|**The handoff packets + `INDEX.md`**|Boundary|live|**not written — ask**|What is actually owed right now, and what does "archived" mean?|
|6|**The observations register**|Record|live|**not written — ask**|What is already known, and what must a finding contain?|
|7|**The generator + `scripts/cases/*.mjs`**|Instrument|live|**not written — ask**|Where is a test case actually edited?|
|8|**The dark-feature sweep**|Instrument|live|**not written — ask**|What does a clean sweep prove, and when do I re-run it?|
|9|**The evidence trail**|Record|**unknown**|**not written — ask**|Where does a screenshot go, and how do I know it arrived?|

### If your question lands on a row marked "not written — ask"

**Stop there. Do not answer it from `territory/`.**

That is not a formality and it is worth one paragraph, because the instinct to press on is a good one and it is wrong here. If you go to the source files you will probably get the right answer — and you will hand it back in the same voice, with the same confidence, as an answer this map actually checked. **The person reading your reply cannot tell the two apart.** A map whose covered and uncovered answers are indistinguishable is not a map; it is a search tool with a table of contents, and it is more dangerous than no map at all because it feels like coverage.

So: name the row, say the card does not exist, and **ask the tester who made this map for it**. If they are not available, the row names the object that owns your question — ask for that object by name. Answering the covered part of a question and stopping at the uncovered part is the correct outcome, not a partial one.

Two entries you would reasonably start from and should not:

- **[handoffs/PRE-SESSION-2026-08-17.md](./territory/handoffs/PRE-SESSION-2026-08-17.md) is a leftover.** It reads _"Next up: P07 continues at `SEND-021`. Thirteen cases left"_ — that session ran the same day and finished. [M3-send-and-sign.md](./territory/handoffs/M3-send-and-sign.md) reports **33 of 33 executed, nothing blocked**. It sits loose in `handoffs/`, whose own rule is _"if it's in this folder it needs someone"_. Nothing on it says it is spent.
- **The front of the work as at 2026-08-18** is the six-case retest at the bottom of [M3-RESPONSE.md](./territory/handoffs/M3-RESPONSE.md) — and it is **build-gated**: `3e589bd` does **not** contain the fix pull request, so running it against the last-observed build reads "not fixed" and puts a false defect back in the register. Card 3 is that noun. P08 the planning pillar is next in phase order.

## Card 1 — The test accounts

**Type** Identity · **Mark** live · **Source** [OBSERVATIONS-REGISTER.md](./territory/OBSERVATIONS-REGISTER.md) §"Test account design (decided 2026-08-08)"; [TEST-PLAN.md](./territory/TEST-PLAN.md) §4.3 and §2.6; corroborated in use at [M3-send-and-sign.md](./territory/handoffs/M3-send-and-sign.md) §1 · no commit available, see the header

Seven personas the plan needs; the accounts behind them are not interchangeable, and which one you signed up as decides whether a result means anything.

Shaped this way because the product keys an account on the **email string**, not on a mailbox — so aliases on one Microsoft 365 mailbox become genuinely separate the platform users with their own organisations. That is the fact that makes a one-person engagement possible at all.

> **Looks like** an ordinary set of test logins, with the owner's own the owner's own account the natural one to reach for. **Is actually** the least representative account on the platform: an account with **platform-wide administrative rights** sitting in a **comped demo org holding a full bundle**. **Nothing tells you** — the screen is identical.

> **Looks like** signing up with the single-sign-on button is the same as signing up with email and password. **Is actually** the opposite: on this platform the two signup routes do not reliably produce the same identity, so one of them can sign you in as the privileged account while the screen shows a fresh, empty account. **Nothing tells you.** [REDACTED: the mechanism, being an authentication behaviour of a live system]

One smaller mismatch: several documents — including [evidence/screenshots/README.md](./territory/evidence/screenshots/README.md) and the archived M0/M1 packets — write these accounts as the plus-form spelling. **The accounts are `alias-1` and `alias-2`, with hyphens.** `+` does not work here and that was settled 2026-08-09.

This card is first because the failure is invisible. A locked-rail test **cannot fail** for that account, so a Pass proves nothing and a Fail is correct behaviour misread as a defect. The privilege is one-way [REDACTED: security-audit finding about a live system]  so "test as a basic user, upgrade afterwards" runs backwards.

**Hits** — the eight P14 entitlement cases, whose expected result is defined by plan state; `ADM-001/002/003`, which exist to prove the administrative area is invisible to a non-admin and cannot be run by an account that is both sides of the test; the four S1 tenant-isolation cases (`SEND-028`, `PM-011`, `MKT-013`, `DARK-005`), which need `alias-2` as a genuinely separate organisation — **M3 §1 records alias-1 and alias-2 as confirmed separate orgs**, so this is no longer the blocker the 08-17 pre-session still describes it as; and the `Test Accounts` sheet, from which `EXIT-004` builds its cleanup list, so an account created and not written down becomes an untracked artefact on production.

**Does not hit** — **your email login.** The obvious next move on learning "never use the primary address" is to stop using it everywhere, and that is wrong: `alias-1` and `alias-2` are the mail provider _aliases_ with no login of their own. You sign in to **email** as the primary address to read the verification message, and complete signup in the product **as the alias**. Conflating the two is a recorded mistake in this engagement, corrected by the tester. Separately, it does not hit the `RECIP` flow, which is no account at all and is reached by token link only; nor does it retroactively taint functional results that do not turn on plan state — an over-privileged account destroys the plan-state cases specifically.

**If you are unsure** — check which address you signed up with **before** recording anything, not after; cleanup is manual and late, so a mistake is not tidied away for you. The credentials live on the workbook's `Test Accounts` sheet, which is **not in this folder** — if you cannot see it, that is the first thing to ask for. Card 2 is the other end of this same failure — one identity has too much, one has nothing, and both destroy the same phase. **Card 2 does not exist.** If you are heading for P14, that is the card to ask for by name before you start, not one to reconstruct.

---

**Stop here.** Load a second card when you have a second question, not before.

## Gaps — what I could not read, so it gets no card

Recorded rather than dropped (`rules.md` §1), because a missing card sends you to ask and a silent omission does not.

- **`the QA test-suite workbook` is not in this folder.** It is the prime instrument — Test Cases, Session Log, Defect Log, Test Accounts, Dashboard — and every document cites it. Card 4 would rest on the generator source rather than on the sheet. **To write it properly I need the workbook itself.**
- **`evidence/sweep-results.csv` is not on disk**, while [.gitignore](./territory/.gitignore) says the sweep's CSV and summary _are_ committed. [scripts/build-workbook.mjs:1838](./territory/scripts/build-workbook.mjs#L1838) fills the Sweep Results sheet from that file **on every build**, and writes _"No sweep has been run yet"_ when it is absent — it degrades silently rather than failing. A rebuild from this folder would blank that sheet.
- **`evidence/screenshots/` contains no screenshots**, only its README — while the register cites at least seven by filename (`SEND-028-other-org-id-404.png` among them) and [ANALYSIS-METHOD.md](./territory/ANALYSIS-METHOD.md) §4.5 makes opening cited evidence mandatory before analysis. I cannot tell from here whether this folder is a partial copy or the evidence is genuinely missing. `node scripts/evidence-manifest.mjs` is the check that settles it, and it needs the workbook.
- **Read only in part:** `OBSERVATIONS-REGISTER.md` (4,168 lines — structure and the account/summary sections), `TEST-PLAN.md`, `M3-send-and-sign.md`, `M3-RESPONSE.md`. **Not opened at all:** `scripts/dark-feature-sweep.mjs`, `scripts/cases/*.mjs`, `ANALYSIS-METHOD.md` and `QA-TERMS.md` bodies, `TOOLING-agent-browser-assessment.md`, `evidence/ChatGPT-Public-Pages-Grammar-Check.md`, and six of the twelve handoff packets. **Only card 1 of the nine is written.** Cards 2 to 9 are named and marked in the catalog and none of them exists; each is flagged in its own catalog row rather than counted here, because a count in a footer goes stale silently and a mark on a row has nothing to keep in sync.

One correction to the territory's own front page, since you will read it early: [README.md](./territory/README.md) states _"Latest baseline — 2026-08-08 … the first fully clean run."_ The sweep output on disk is dated **2026-08-16T04:13:10Z** (77 pass, 0 fail, 0 dark). The README asserts its own currency and the artifact disagrees; the artifact wins.

---

## What changed in v2

Derived from run 02's map. Three changes, all of them about how the map handles its own gaps, and **nothing else**:

1. **The catalog carries a `Card` column.** Every entry says on its own row whether the card exists. Previously a reader learned this from a Gaps section further down, or not at all.
2. **The stopping rule is in the map**, addressed to whoever opens it, with the reason and with who to ask. Previously that rule existed only in `rules.md`, which binds the cartographer and which the map's reader has by definition never seen.
3. **The gap count is corrected.** The footer said "Cards 5–9 are named and marked but not written" when only card 1 of nine was written (`FIX-11`).

No card was written. No claim was corrected. No wording was improved. Run 03 and run 05 are asked the identical question against maps differing only in the above, so anything that changes between them is attributable to the fix and to nothing else.
