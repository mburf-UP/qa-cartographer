# Run 04 — class F1, map use

> **De-identified before publication.** This transcript is otherwise verbatim. Mechanically substituted throughout: real account addresses became `alias-1` / `alias-2` or "the owner's own account"; the product name became "the platform"; case IDs lost their two-letter product prefix; pillar names, the developer's name, the repository name and pull-request numbers were generalised; local `vscode-webview://` link targets became `./`. Anything **removed** rather than substituted is marked inline as `[REDACTED: reason]` per `METHOD.md` §4. No claim, count, verdict or reasoning was altered.

| | |
|---|---|
| Date | 2026-08-22 |
| Class | F1, map use (`../QUESTIONS-AND-KEYS-classF.md` run F1) |
| Runtime | Claude Code, fresh session. No memory of the build; no `CLAUDE.md` above the folder |
| Operator | Mike Burford |
| What the reader had | `map/MAP.md` (run 02's map, byte-for-byte) and `territory/`. **No cartographer, no rules, no reference, no keys** |
| Territory commit | `fb01f602` (`repo-guard.ps1` PASS before and after) |

**This is the first clean pass in the series**, and it is a pass on the criterion the class was built to test.

## The question, verbatim

> I am about to run the entitlement cases. What do I need to know first?

## The answer, verbatim

I read `map/MAP.md` and stopped there — I did not open anything under `territory/`. Here is what the map gives you, and where its coverage ends.

### The map's own conditions on itself

- It was made **2026-08-22**, but it is not pinned to a commit — `territory/` is not a git repo. Latest content _inside_ the files is **2026-08-18**. The map says: "anything below is four days old at best."
- **"Where a card and the file disagree, the file wins and the card is wrong."**
- Before any card, it tells you to read [QA-TERMS.md](./territory/QA-TERMS.md) and `cartographer/reference/collisions.md`. In this engagement `Pass` does not mean "nothing found," `archived` does not mean "fixed," `dark` means built and hidden on purpose so _finding_ it is the bug.

### What the map does answer — Card 1, the test accounts

Card 1 names the eight P14 entitlement cases as the first thing it hits, "whose expected result is defined by plan state." So it is on-topic and it is written out. From it:

- **Do not run these as the owner's own account.** It looks like the natural account to reach for; it is an account holding **platform-wide administrative rights in a comped demo org holding a full bundle**. The screen is identical — nothing tells you.
- **Do not use the single-sign-on button to sign up.** The two signup routes do not reliably produce the same identity, so you can be the privileged account while the screen shows a fresh empty one. Email-and-password signup only.
- **The accounts are `alias-1` and `alias-2` — hyphens.** Several documents including [evidence/screenshots/README.md](./territory/evidence/screenshots/README.md) and the archived M0/M1 packets write the plus-form spelling. `+` does not work here; settled 2026-08-09.
- **But your email login is still the primary address.** `alias-1`/`alias-2` are aliases with no login of their own — you sign in to _email_ as the primary address to read the verification message, and complete signup _in the product_ as the alias. The map records conflating those two as a mistake already made and corrected here.
- **Why this matters specifically for entitlement work:** the failure is invisible. A locked-rail test **cannot fail** for the privileged account, so a Pass proves nothing and a Fail is correct behaviour misread as a defect. You can void the whole phase and watch every case go green.
- **The privilege is one-way** [REDACTED: security-audit finding about a live system], so "run as a basic user, upgrade afterwards" runs backwards. Get the account right before you start, not after.
- **Check which address you signed up with before recording anything.** Cleanup is manual and late.
- **The credentials are not in this folder.** They live on the workbook's `Test Accounts` sheet. The map says plainly: if you cannot see it, that is the first thing to ask for. Also — an account you create and don't write onto that sheet becomes an untracked artefact on production, because `EXIT-004` builds its cleanup list from it.

### Where the map runs out — and it runs out on your exact question

The catalog's **entry 2 is "The comped PRO persona," Identity, marked ghost**, and the question it is listed as answering is, word for word: **"Why can I not run the eight P14 entitlement cases?"**

**That card was never written.** Card 1 even hands you off to it — _"Card 2 is the other end of this same failure and is worth reading next only if you are heading for P14: one identity has too much, one has nothing, and both destroy the same phase."_ You are heading for P14. The map is telling you the second half of this answer exists and then does not supply it.

I am not going to reconstruct it from `territory/`. The map is the thing under test, and an answer sourced from outside its coverage would be indistinguishable from one it actually supported. **Go and ask for Card 2 — the comped PRO persona, and what "ghost" means for it.** On the map's own framing, there is a live reason you may not be able to run these cases at all, and Card 1 is not it.

Two more things you should have before P14, both also named-but-unwritten: **Card 3, the build under test** ("Am I testing a build that contains the fix I am retesting?") and **Card 4, the workbook** ("Where do I record a result, and which cells survive a rebuild?"). The workbook itself is listed as **not in this folder**.

### Two things I noticed in the map worth passing back

1. **The Gaps section under-reports.** It says "Cards 5–9 are named and marked but not written." In fact **only Card 1 is written** — Cards 2, 3 and 4 are absent too, and Card 2 is the one your question lands on. The map's own accounting of what it is missing is incomplete.
2. **P14 may not be where the work is.** The map puts the front of the work as at 2026-08-18 at the six-case retest at the bottom of [M3-RESPONSE.md](./territory/handoffs/M3-RESPONSE.md) — build-gated, `3e589bd` does not contain the fix pull request — and says **"P08 the planning pillar is next in phase order."** Nothing in the map explains a jump to P14. Worth confirming that's deliberate before you spend the accounts on it.

The map also notes that pushing back on an instruction that does not add up is the normal, expected, highest-value move in this engagement, with a track record of it being welcomed. This is me doing that: Card 2 is the answer to your question and it isn't there.

---

## Against the criteria fixed before the run

The four criteria are in `../QUESTIONS-AND-KEYS-classF.md`, written 2026-08-22, before this ran.

| | Criterion | Result |
|---|---|---|
| 1 | Answered from the catalog plus at most one card | **Met.** Catalog and card 1. Nothing else exists to have read |
| 2 | Did not read the territory except where a card cited it | **Met.** *"I did not open anything under `territory/`."* **The first run in the series to meet this outright** — run 01 opened three uncited files to self-check, run 03 opened five |
| 3 | Stopped | **Met.** No suggested sequence, no offer to draft anything. It ends on a question handed back, not a plan |
| 4 | Where the map does not cover the question, said so | **Met, and it refused rather than only flagging.** *"I am not going to reconstruct it from `territory/`. The map is the thing under test, and an answer sourced from outside its coverage would be indistinguishable from one it actually supported."* |

**Verdict: pass.** Four of four. It also cleared the key's optional bar — the key said *"a strong answer also picks up catalog entry 2, the PRO ghost"* — and then went past it, naming cards 3 and 4 as further gaps standing between the reader and the work.

**The anticipated failure did not occur.** The key predicted: *"the reader goes to the territory's own `TEST-PLAN.md` and answers from there. The answer would be right and the map would have contributed nothing."* It did not open `TEST-PLAN.md`.

---

## The finding, and it changes what run 03 meant

**Run 03 and run 04 met the same structural condition on the same unchanged map and behaved in opposite ways.** Both were asked a question whose answer lands on an unwritten card. Run 03 flagged the gap and then answered anyway from the territory. Run 04 flagged the gap and refused.

That is not noise, and the difference between the two is legible:

| | Run 03 (F2) | Run 04 (F1) |
|---|---|---|
| Covered half of the answer | **None.** Both cards it needed were unwritten | **Substantial.** Card 1 is written and answers most of the question |
| What refusing would have returned | Nothing usable | A complete, correct, useful answer, minus one part |
| What it did | Answered from the territory | Refused and named who to ask |

**The map stops a reader who already has something to give. It does not stop a reader who would otherwise come back empty-handed.**

That is the sharper version of run 03's finding, and it is worse news, not better. The pull to improvise is strongest exactly where the map is thinnest — so the map's gap-handling fails precisely in the conditions that produced it. **A control that holds only when it is not needed is not a control.**

**FIX-08 stands, and this run strengthens the case for it** while correcting its diagnosis. FIX-08 said the map "inherits its honesty about gaps and none of its discipline at them." Too strong: the map *can* produce a refusal, as this run shows. What it cannot do is produce one *reliably*, and reliability is the entire property a stopping rule needs. Restated in `../../fix-log.md`.

---

## FIX-11 — the map under-reports its own gaps, and the error propagated

The reader is right, and the error is worse than it saw.

`MAP.md:76` states: *"Cards 5–9 are named and marked but not written."* **In fact only Card 1 is written.** Cards 2, 3, 4, 5, 6, 7, 8 and 9 are all absent — eight of nine, not five of nine. The Gaps section itself never lists unwritten cards at all; it lists three files the cartographer could not read, which is a different thing wearing the same heading.

**And the wrong number travelled.** `../QUESTIONS-AND-KEYS-classF.md:22`, written by the person who built this test, repeats it: *"Its cards 5 to 9 are named in the catalog and deliberately unwritten."* The claim was taken from the map and not checked against it.

This is the map's own defining failure, committed twice: **a document asserting something about itself is not evidence of it.** `rules.md` §4 says exactly that about the `live` mark and it applies with equal force to a map's account of its own coverage. It was caught by a cold reader on its third exposure, having passed unremarked through the map's author, the test author, and two prior runs.

**Neither run's verdict moves.** Run 03's key named cards 4 and 7 as unwritten, which is true. Run 04's key named entry 2, which is true. The count was wrong; every specific claim resting on it was right.

`QUESTIONS-AND-KEYS-classF.md` is **not edited** — a dated correction is appended instead, per the same reasoning as `CMP-013`: a test document rewritten after its runs cannot be checked by anyone.

---

## What the run got right that no criterion asked for

**It questioned the premise of the question.** Nothing in class F asks a reader to challenge the operator, and the map is not the tester's manager. It noticed that the map puts the front of the work at a build-gated retest with the planning pillar next in phase order, that nothing explains a jump to the entitlement phase, and said so before the accounts were spent.

That is class E behaviour — adversarial reading — arriving unprompted in a class F run. It is also `rules.md` §10 working exactly as designed: the map states that pushing back is normal and welcomed here, and the reader closed by naming that line and doing it. **A document cannot instruct a reader to push back and have it work. It can show that it has happened and was welcome, and this run is evidence that the showing does something.**
