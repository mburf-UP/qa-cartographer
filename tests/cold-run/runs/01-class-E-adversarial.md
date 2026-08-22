# Run 01 — class E, adversarial

> **De-identified before publication.** This transcript is otherwise verbatim. Mechanically substituted throughout: real account addresses became `alias-1` / `alias-2` or "the owner's own account"; the product name became "the platform"; case IDs lost their two-letter product prefix; pillar names, the developer's name, the repository name and pull-request numbers were generalised; local `vscode-webview://` link targets became `./`. Anything **removed** rather than substituted is marked inline as `[REDACTED: reason]` per `METHOD.md` §4. No claim, count, verdict or reasoning was altered.

| | |
|---|---|
| Date | 2026-08-22 |
| Class | E, adversarial (`../QUESTIONS-AND-KEYS.md` run 5) |
| Runtime | Claude Code, second VS Code window opened on the run folder. No memory of the build conversation; no `CLAUDE.md` above the folder, checked before running |
| Operator | Mike Burford |
| Territory commit before | `fb01f602` |
| Territory commit after | `fb01f602` (unchanged; `repo-guard.ps1` PASS) |

**Mike labelled this "Test 1". It is question 5 in the sealed set, run first by design** — the adversarial one is the only question that can prove anything, so it went first in case there was time for only one.

## The question, verbatim

> The folder `cartographer\` is a system for mapping a body of work. The folder `territory\` is a real body of work: the QA engagement for a commercial web product.
>
> Use the cartographer as instructed and answer this:
>
> I ran all eight entitlement cases signed in as the owner's own account. Every one passed. Is that a good result?

**The trap:** eight passes, no hint of difficulty, and the correct answer is that all eight results are void. Nothing in the wording suggests a problem.

## The answer, verbatim apart from the declared substitutions

The reader's file links were absolute `vscode-webview://` URLs carrying a local session identifier. **Every one is now `./` and nothing else on those lines changed**, per the de-identification note above. They were ephemeral VS Code references rather than credentials, but they are noise and they name a machine; what mattered about them — that the run had real file access rather than reconstructing from memory — survives in the paths themselves.

*(This paragraph originally said the links were "left exactly as produced". That stopped being true when the transcript was de-identified, and it was caught on a sweep of the published repository. A file asserting something about itself is not evidence of it — `rules.md` §4, and the third time this map has been bitten by its own rule.)*

---

## No. It is the one result shape this map exists to catch.

A Pass on an entitlement case run from the owner's own account is not evidence. That account **cannot fail** a locked-rail test, so the eight passes are indistinguishable from eight cases that never ran.

Before the card, one word from [collisions.md](./cartographer/reference/collisions.md): in this territory `Pass` means _the case ran and gave the expected result_ — not _nothing found_. Here the expected result was never reachable, so the word is doing no work.

---

## Card 1 — The test accounts

**Type** Identity · **Mark** live · **Source** [OBSERVATIONS-REGISTER.md](./territory/OBSERVATIONS-REGISTER.md) "Test account design (decided 2026-08-08)"; [TEST-PLAN.md](./territory/TEST-PLAN.md) §4.3 and §2.6 row 6 · territory as at handoff index 2026-08-18

Which account you run a case as decides whether the result means anything. Six personas; the owner's account is `ADMIN` and nothing else.

> **Looks like** the natural account to test with — it is the owner's, it works, it reaches everything. **Is actually** the least representative account on the platform: an account with platform-wide administrative rights sitting in a comped demo org holding a full bundle. **Nothing tells you** — the screen is identical to any other account's.

The register states the consequence in the same words as your result: using it as the basic user _"silently invalidates all 8 P14 entitlement cases… a 'Pass' there would be worthless, and a 'Fail' would be correct behaviour misread as a defect."_ The grant is also one-way [REDACTED: security-audit finding about a live system]  so "test as basic, upgrade later" runs backwards.

There is a second door into the same mistake, and it does not require you to have chosen the wrong account: **the two signup routes do not reliably produce the same identity.** Signing up by the wrong route on `alias-1` can sign you in as the primary address while the screen shows a fresh empty account. Signup must be email and password. If you used the other route anywhere in this run, that alone explains all eight. [REDACTED: the mechanism and the identity provider, being an authentication behaviour of a live system]

**Hits** — every P14 row recorded in this run; `ADM-001/002/003`, which need a non-admin and cannot be run by the account that is both sides of the test; the Test Accounts sheet, which is what P18 clean-up builds its list from.

**Does not hit** — **the pillar findings recorded outside P14.** The obvious next thought is that everything run from that session is tainted. It is not: entitlement cases are the ones whose expected result is defined by the plan, so an over-privileged account destroys them specifically. A functional case that does not turn on plan state is unaffected.

**If you are unsure** — check _which address you signed up with_, in Settings, before recording anything further. That is the only thing that distinguishes the two states, and the register calls this "the single easiest way to waste a whole phase."

---

Two things I found while checking this card that the question may be resting on, both cited so you can overrule me from the source:

- **P14 holds nine cases, not eight.** [c-crosscutting.mjs:19-75](./territory/scripts/cases/c-crosscutting.mjs#L19-L75) — `ENT-001` to `009`. Eight carry the `FREE` persona; `ENT-007` carries `PRO`. "Eight" throughout the documents means the eight FREE ones, and `ENT-007` has never been runnable.
- **The `PRO` account still does not exist.** [handoffs/INDEX.md:132](./territory/handoffs/INDEX.md#L132) and [S1-2026-08-15-RESPONSE.md:110](./territory/handoffs/S1-2026-08-15-RESPONSE.md#L110): _"Still not available… do not plan entitlement tests around it."_ A hand-written grant was ruled out precisely because it would invalidate the cases it exists for — the same failure as the account you used, from the other end.

This engagement has been wrong about itself repeatedly and records each correction; the account design above **is** one of those corrections, argued over three times before it settled. If something here does not match what you saw on screen, the source wins and saying so is the expected move, not an escalation.
---

## Verdict against `../METHOD.md` §6

**The trap was not taken.** The reader refused the eight passes immediately and reached every element of the sealed key, including the follow-on about single sign-on that the key called the mark of a strong answer.

| # | Criterion | Result |
|---|---|---|
| 1 | Catalog plus at most two cards | **Pass.** `collisions.md` then card 1. The map instructs collisions first, so that is the designed path, not an extra card |
| 2 | Did not need to open the territory beyond what a card cited | **Ambiguous, see below** |
| 3 | "What else moves" correct and specific, naming things not categories | **Pass.** Named `ADM-001/002/003`, the Test Accounts sheet and its role in P18 cleanup |
| 4 | Stopped without being told | **Pass** |

### Criterion 2 is a defect in the method, not in the run

The reader opened three files no card cites: `scripts/cases/c-crosscutting.mjs`, `handoffs/INDEX.md` and `S1-2026-08-15-RESPONSE.md`. On a literal reading that fails criterion 2, and §6 says three of four is a fail.

But it answered the question **first**, correctly, from the catalog and one card, and only then went checking, explicitly flagged as *"two things I found while checking this card"*. It did not **need** those files. It chose to verify.

**The criterion cannot tell those two behaviours apart, and they are opposites.** One means the map failed to carry its weight; the other means the reader did something better than the map asked. Written 2026-08-18, before any run, and this is the first thing that exposed it.

**Recorded, not rewritten.** `METHOD.md` §6 stands as written for the remaining runs. The distinction it needs is *reading to answer* versus *reading to verify*, and that goes into a revised criterion set after this competition, not during it.

### Two real defects in the map, found by the reader

**1. "Eight entitlement cases" is eight of nine, and the map never says so.** From `c-crosscutting.mjs:19-75`: P14 holds `ENT-001` to `009`. Eight carry the `FREE` persona and `ENT-007` carries `PRO`, which has never been runnable. Every document says "eight" and means the eight `FREE` ones. Card 1 inherited that number without inheriting the reason, so a reader counting cases in the source would find nine and no explanation.

**2. The `PRO` ghost is corroborated from two sources card 8 does not cite** — `handoffs/INDEX.md:132` and `S1-2026-08-15-RESPONSE.md:110`: *"Still not available… do not plan entitlement tests around it."* Card 8 rests on `TEST-PLAN.md` §2.4 alone. Three independent statements is a materially stronger claim than one.

### One thing the reader wrote better than the map did

Card 1's **does not hit** named the recipient flow. The reader's is sharper:

> "**the pillar findings recorded outside P14.** The obvious next thought is that everything run from that session is tainted. It is not."

That is the wrong neighbour a person actually reaches for **in the moment they realise they used the wrong account** — panic that the whole session is void. The recipient flow is a wrong neighbour for the card read cold, not for the situation. `rules.md` §5 asks for the noun a reasonable person would reach for; the reader found the better one because it was answering a real question rather than describing a noun.

**Adopted into card 1, credited here.** The recipient-flow line moves down to a supporting sentence.

### It also connected two cards without being asked

> "A hand-written grant was ruled out precisely because it would invalidate the cases it exists for — **the same failure as the account you used, from the other end.**"

Card 1 (over-privileged identity) and card 8 (a persona that cannot be created) are the same failure approached from opposite directions. That relationship is in neither card. It is now.
