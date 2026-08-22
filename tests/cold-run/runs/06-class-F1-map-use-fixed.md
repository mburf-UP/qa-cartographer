# Run 06 — class F1, map use, against the fixed map — the regression control

> **De-identified before publication.** This transcript is otherwise verbatim. Mechanically substituted throughout: real account addresses became `alias-1` / `alias-2` or "the owner's own account"; the product name became "the platform"; case IDs lost their two-letter product prefix; pillar names, the developer's name, the repository name and pull-request numbers were generalised; local `vscode-webview://` link targets became `./`. Anything **removed** rather than substituted is marked inline as `[REDACTED: reason]` per `METHOD.md` §4. No claim, count, verdict or reasoning was altered.

| | |
|---|---|
| Date | 2026-08-22 |
| Class | F1, map use (`../QUESTIONS-AND-KEYS-classF.md` run F1) |
| Runtime | Claude Code, fresh VS Code window on `cartographer-mapuse\`. No memory of the build; no `CLAUDE.md` above the folder |
| Operator | Mike Burford |
| What the reader had | `map/MAP.md` = **`MAP-v2.md`**, and `territory/`. **No cartographer, no rules, no reference, no keys** |
| Map | `MAP-v2` — run 02's map plus FIX-08 and FIX-11, and nothing else |
| Territory commit | `fb01f602` (`repo-guard.ps1` PASS before and after) |

**This run exists to try to break the fix, not to confirm it.** Run 04 already passed F1 on the unfixed map. Re-running it after the change tests the one thing FIX-08 could plausibly have made worse: **over-refusal.** A map that refuses everything scores full marks on criterion 4 and is worthless. F1 is the only question in the set with a covered half *and* an uncovered half, so it is the only one that can detect it.

## The question, verbatim

> I am about to run the entitlement cases. What do I need to know first?

## The answer, verbatim

I read `map/MAP.md` only. I did not open anything in `territory/` — that turns out to matter for this question.

### Your question lands on two rows, and only one of them has a card

The entitlement cases are the **eight P14 entitlement cases**. Two catalog entries own them:

|#|Noun|Mark|Card|
|---|---|---|---|
|1|The test accounts|live|**written**|
|2|The comped PRO persona|**ghost**|**not written — ask**|

Row 2's stated question is literally _"Why can I not run the eight P14 entitlement cases?"_ That card does not exist. So I can give you the first half of what you need and not the second.

### What the map does cover (Card 1 — the test accounts)

Read this before you touch P14:

- **Which account you signed up as decides whether a P14 result means anything.** The eight entitlement cases have their expected result _defined by plan state_, so an account with the wrong plan state doesn't produce a wrong answer — it produces a meaningless one.
- **Do not reach for your own account.** It looks ordinary and is the least representative account on the platform: platform-wide administrative rights, sitting in a comped demo org holding a full bundle. The screen is identical — nothing tells you.
- **Do not use the other signup route.** The two signup routes do not reliably produce the same identity, so one of them can sign you in as the privileged account while the screen shows a fresh, empty one. Again, nothing tells you. [REDACTED: the mechanism, being an authentication behaviour of a live system]
- **The failure mode is invisible success.** A locked-rail test _cannot fail_ for the privileged account — a Pass proves nothing, and a Fail is correct behaviour misread as a defect. And the privilege is one-way, so "test as a basic user, upgrade afterwards" runs backwards.
- **Spelling:** the accounts are `alias-1` and `alias-2`, with **hyphens**. Several documents write the plus-form; `+` does not work here, settled 2026-08-09.
- **Don't over-correct.** "Never use the primary address" does not extend to your _email login_ — `alias-1`/`alias-2` are mail aliases with no login of their own. You sign in to email as the primary address to read the verification message, and complete signup in the product as the alias. Conflating those is a recorded mistake in this engagement.
- **Check which address you signed up with _before_ recording anything.** Cleanup is manual and late; a mistake is not tidied away for you.

Vocabulary the map flags before any card: `Pass` does not mean "nothing found", `archived` does not mean "fixed", `dark` means built and hidden on purpose (so _finding_ it is the bug).

### What you need and I cannot give you

**Card 2 — the comped PRO persona — is a ghost, and the card was never written.** The map's own guidance is explicit about this case: _"Card 2 is the other end of this same failure — one identity has too much, one has nothing, and both destroy the same phase… If you are heading for P14, that is the card to ask for by name before you start, not one to reconstruct."_

I could go read `territory/` and probably produce a plausible answer. The map's stopping rule says not to, and the reason is sound: you would not be able to tell that answer apart from one the map actually checked. So — **ask the tester who made this map for Card 2, the comped PRO persona, before you start P14.** If they aren't available, ask for that object by name.

Two smaller unknowns that will bite in the same session:

- **Credentials are on the workbook's `Test Accounts` sheet, which is not in this folder.** If you can't see it, that is the first thing to request. (Card 4, the workbook — _"where do I record a result"_ — is also unwritten.)
- **The map is dated 2026-08-22 but the latest content inside the territory is 2026-08-18**, and no commit could be pinned — the folder is not a git repo. Everything above is four days old at best. Where a card and the file disagree, the file wins.

---

## Against the criteria fixed before the run

| | Criterion | Result |
|---|---|---|
| 1 | Answered from the catalog plus at most one card | **Met.** Catalog and card 1 |
| 2 | Did not read the territory except where a card cited it | **Met.** *"I read `map/MAP.md` only. I did not open anything in `territory/`"* |
| 3 | Stopped | **Met** |
| 4 | Where the map does not cover the question, said so | **Met, and refused** |

**Verdict: pass.**

## The regression result, which is what this run was for

**No over-refusal. The covered half came through in full.**

Seven bullets of card 1, including the two traps, the invisible-success failure mode, the hyphen spelling, the don't-over-correct warning about the email login, and the check-before-you-record instruction. Then it stopped, precisely at the boundary of what the map covers.

| | Run 04 — map v1 | Run 06 — map v2 |
|---|---|---|
| Card 1's content delivered | yes | **yes, in full** |
| Refused the uncovered half | yes | yes |
| Named who to ask and what for | yes | yes, and by card name |
| Verdict | pass | pass |

**FIX-08 changed the case that was failing and left the case that was passing alone.** That is the whole claim, and it now has a before, an after, and a control.

### This is also the answer to the sceptic

The obvious objection to run 05 is that the map now instructs the reader to stop, so stopping proves only obedience.

**Run 06 refutes it.** A reader mechanically obeying a stopping instruction would have had every excuse to stop at the top: the question names the entitlement cases, row 2 is the entitlement-case row, row 2 is marked `not written — ask`. Stopping there would have satisfied criterion 4 completely and returned nothing.

It didn't. It **split the question across two rows**, noticed one was covered and one was not, delivered the covered one thoroughly, and refused the other. That is a coverage judgement, not compliance. The map gave it a rule and a reason; it applied the reason.

### One thing it did that neither key asked for

It quoted the amended handoff line from card 1 — *"that is the card to ask for by name before you start, not one to reconstruct"* — as its justification. That sentence is one of the three v2 edits. **The behaviour is traceable to the specific change**, not merely correlated with the version bump, which is as close to attribution as a two-arm test of this size can get.
