# A worked map

Territory: a production QA engagement. A 267-case suite across 19 phases and 93 findings, run by one tester who does not build the product and hands findings to the developer who does.

**Made at commit `fb01f602`.** Where a card and the source disagree, the source wins.

**All eight objects have cards.** Three are written out here as the worked example — the two that cost most to get wrong, and the ghost. The remaining five are in `map/`, one file each. No card appears twice; the catalog says where each one lives.

---

## The catalog

Ordered by what getting it wrong costs, highest first. Identity first regardless (`card-types.md`).

| # | Noun | Type | Mark | Card is | The question it answers |
|---|---|---|---|---|---|
| 1 | **The test accounts** | Identity | live | [below](#card-1--the-test-accounts) | Which account do I run this case as, and why does it matter? |
| 2 | **The test suite workbook** | Instrument | live | [below](#card-2--the-test-suite-workbook) | Where do I record a result, and which cells are mine? |
| 3 | **The build under test** | Subject | live | [`map/card-03`](map/card-03-build-under-test.md) | Am I still testing the same product I was an hour ago? |
| 4 | **The observations register** | Record | live | [`map/card-04`](map/card-04-observations-register.md) | What is already known, and what does a finding have to contain? |
| 5 | **The handoff packet** | Boundary | live | [`map/card-05`](map/card-05-handoff-packet.md) | How does a finding reach the developer, and what does "archived" mean? |
| 6 | **The generator and its case files** | Instrument | live | [`map/card-06`](map/card-06-generator-and-cases.md) | Where are cases actually edited, and what can I run? |
| 7 | **The evidence trail** | Record | live | [`map/card-07`](map/card-07-evidence-trail.md) | Where does a screenshot go, and how do I know it arrived? |
| 8 | **The comped PRO persona** | Identity | **ghost** | [below](#card-8--the-comped-pro-persona) | Why can I not run the eight paid-plan cases? |

**Every row has a card.** Three are written out below — the two that cost most to get wrong, and the ghost — because a worked example is what this file is for. The other five are one file each in [`map/`](map/), same contract, same format.

**If your question is not on a row at all, ask — do not improvise from the source files.** You would probably get it right, and the person reading your answer could not tell it from one this map had checked. The cold runs in `tests/cold-run/runs/` are the evidence that the rule is needed.

**Before any card, read `reference/collisions.md`.** In this territory `Pass` does not mean "nothing found", `archived` does not mean "fixed", and a panel reading `0 / 221` captured 221 things.

**This engagement has been wrong about itself 17 times in 93 findings.** Those corrections are recorded, most were caught by the tester pushing back on an instruction that did not make sense, and card 4 says where they are. **When something here does not add up, that is the expected case and querying it is the highest-value thing you can do.**

---

## Card 1 — The test accounts

**Type** Identity · **Mark** live · **Source** `qa/TEST-PLAN.md` §4.3, `qa/OBSERVATIONS-REGISTER.md` · commit `fb01f602`

Six personas the plan needs; five have accounts and one does not. Which account you run a case as changes whether the result means anything.

Shaped this way because the product keys an account on the email string, so aliases on one mailbox become genuinely separate users. That is what makes a one-person engagement possible.

> **Looks like** an ordinary set of test logins, with the owner's own account the natural one to use. **Is actually** a set where the owner's account is the *least* representative on the platform: an account with platform-wide administrative rights sitting in a comped organisation holding a full bundle. **Nothing tells you** — the screen is identical.

This is why the card is first. A locked-feature test **cannot fail** for that account, so a Pass proves nothing and a Fail is correct behaviour misread as a defect. Eight entitlement cases go silently worthless and every one looks like success. **Eight, not nine:** P14 holds `ENT-001` to `009`, and `ENT-007` carries the `PRO` persona, which has never been runnable (card 8). Every document in the territory says "eight" and means the eight `FREE` ones, without saying so. The privilege is one-way, so "test as basic, upgrade later" runs backwards.

> **Looks like** signing up with a single sign-on button is the same as signing up with a password. **Is actually** the opposite: on this platform the two routes do not produce the same identity, so one of them can sign you in as the privileged account while the screen shows a fresh, empty one. **Nothing tells you.** Signup must be email and password, every time.

**Hits** — every result recorded in the workbook while signed in as the wrong identity; the entitlement phase entirely; the tenant-isolation cases, which need the second organisation and cannot run without it.

**Does not hit** — **the findings recorded outside the entitlement phase.** The moment you realise you used the wrong account, the next thought is that the whole session is tainted. It is not. Entitlement cases are the ones whose expected result is defined by plan state, so an over-privileged account destroys those specifically; a functional case that does not turn on plan state is unaffected. Separately, the recipient flow is not an account at all and is reached by token link only, so none of this applies to it.

**If you are unsure** — check which address you signed up with before recording anything, not after. Cleanup of these accounts is manual and happens late, so a mistake here is not tidied away for you.

---

## Card 2 — The test suite workbook

**Type** Instrument · **Mark** live · **Source** `qa/*.xlsx`; ownership defined in `qa/scripts/harvest.mjs` · commit `fb01f602`

The prime working document: 267 cases across 19 phases and 11 sheets. You read cases from it and record results into it.

Why it is shaped this way: the workbook is **generated**, not authored. Cases are edited in code and the workbook is rebuilt from them, so a rebuild has to know which cells came from a human and which are its own. It cannot tell by looking, so ownership is fixed **by column**, per sheet.

> **Looks like** a spreadsheet, where any cell you can type into is yours. **Is actually** six sheets under four different ownership rules, where a majority of the cells are regenerated and your edit disappears at the next rebuild. **Nothing tells you** — there is no lock, no colour, no warning.

Two of the sheets are matched by **row position** rather than by a key. Insert or delete a row in Excel and every value below silently reattaches to the wrong row.

**Hits** — the analyst's phase report, which counts from these columns; the defect log the developer signs off from; any rebuild, which will overwrite anything outside your columns.

**Does not hit** — **the test cases themselves.** The natural instinct on finding a wrong or unrunnable case is to correct the case text in the sheet. That edit is always lost. Cases live in `qa/scripts/cases/*.mjs`; the sheet is a render of them.

**If you are unsure** — you own the cream columns and any row you added yourself. Never edit in place; always rebuild with `--import`.

---

## Card 8 — The comped PRO persona

**Type** Identity · **Mark** ghost · **Source** `qa/TEST-PLAN.md` §2.4; corroborated at `qa/handoffs/INDEX.md:132` and `qa/handoffs/S1-2026-08-15-RESPONSE.md:110` (*"Still not available… do not plan entitlement tests around it"*); and at `qa/handoffs/archive/M0-RESPONSE.md:126` · commit `fb01f602`

A paid-plan persona the test plan requires and which has no account behind it.

> **Looks like** the sixth entry in a list of five working accounts, pending like the others. **Is actually** a persona that cannot be created at all: no product path grants an organisation a paid plan without taking money. **Nothing tells you** — it sits in the persona table reading as approved.

<!-- ghost-check: unverifiable settling this one would require naming internals of a third party's production system, which this repository does not publish; the absence is attested by three independent documents cited above -->

Ghost, not leftover: never in use, not retired, a name with nothing wired behind it. The obvious workaround, writing the entitlement row by hand, would invalidate the eight cases the persona exists to run.

**Hits** — the eight paid-plan cases, which cannot run. The plan records this as a coverage hole rather than an inconvenience, so a reader who "solves" it quietly has removed a recorded risk without telling anyone.

**Does not hit** — **the other five personas.** The natural assumption on finding one identity broken is that the account set is unreliable. It is not. The other five are live and working; this one is a gap by design, waiting on a surface being built.

**Same failure as card 1, from the other end.** A hand-written entitlement grant was ruled out because it would invalidate the very cases the persona exists to run — which is what an over-privileged account does to the other eight. One identity has too much, one has nothing, and both destroy the same phase.

**If you are unsure** — do not create it. Record the cases as blocked and say why.

---

## One change, traced

**A case is wrong and you want to fix it.**

Edit it in the workbook and the correction survives until the next rebuild, then vanishes with no message. Edit it in `qa/scripts/cases/` and it survives, because that is where cases live. The workbook is a render.

Follow it outward: the corrected case changes what the tester does, which changes the result recorded, which changes the analyst's count, which changes what reaches the developer in the next packet. **It does not change the findings register**, which records what was observed under the old case. That history stays, and card 4 says why.

---

## The ghost that resolved

A ghost this map marked was closed by a merge mid-build, so card 6 aged in a way anyone can verify from either commit. It was not deleted. Both hashes and what it proves are in `tests/ghost-resolved.md`.
