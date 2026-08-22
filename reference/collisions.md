# Naming collisions in this territory

Words that mean one thing in general use and something narrower, or opposite, here. Every entry follows `rules.md` §6: **looks like X, is actually Y, nothing tells you.**

This file exists because a newcomer does not get lost in the folder tree. They get lost when a word behaves unlike its appearance. **Read this before any card.**

Pinned to commit `fb01f602`. Where this file and the source disagree, the source wins (`rules.md` §8).

---

## Result words

| Word | Looks like | Is actually | What it costs |
|---|---|---|---|
| **Pass** | Nothing found | The case ran and gave the expected result. **The commentary on a Pass row can hold the most valuable finding on the sheet** | Three of the engagement's best findings sit in Pass rows. A reader who skips them skips the findings |
| **Blocked** | A kind of failure | Could not run it at all | A pile of Fails sharing one cause hides the cause. Blocked is what keeps them separable |
| **Fail** | Something is broken | Ran it, wrong result | On a dark-feature case the polarity inverts: finding the feature **is** the failure |
| **Gated** | Stopped early, incomplete | Stopped deliberately before an irreversible action. **Stopping is the correct outcome** | Four gated cases in one phase were executed anyway by a careful tester with the instruction on screen |
| **Partial** | Nearly a pass | Worked with a deviation not worth a Fail, and the deviation still gets written down | The deviation is the content; recording only "Partial" discards it |

## Severity, tier, priority — three different scales, routinely conflated

| Word | What it measures | Who owns it |
|---|---|---|
| **Severity S1 to S4** | What it costs the business if a real customer hits it. **Not whether the test failed** | The analyst |
| **Tier 0 to 3** | How risky the *fix* is, and who must approve it | The developer |
| **Priority** | What gets done first | The humans, not QA |

A severity is not a pass/fail grade and a tier is not a severity. An S1 can be Tier 0; a cosmetic issue can be Tier 3.

## Feature-state words

| Word | Looks like | Is actually |
|---|---|---|
| **Armed** / on | Working | Live and visible. **Its absence is a bug** |
| **Dark** / off | Broken or missing | Built and hidden on purpose. **You should find nothing, and finding it is the bug** |
| **A NAME_IN_CAPITALS** | Something on screen | An internal switch label in the code. Never a thing the tester verifies |

**The switch is set when the site is built, not when a page loads.** It cannot be flipped from a browser and its setting is not visible from outside. A flag can be present by name and impossible to turn on, and that failure is silent and looks like nothing.

## Tool and file words

| Term | Looks like | Is actually | What it costs |
|---|---|---|---|
| **`harvest.mjs`** | A script you run | A module imported by the generator. **Never run directly.** The whole user-facing surface is one flag, `--import` | A newcomer tries to run it |
| **`evidence/`** vs **`evidence/screenshots/`** | The same place | Only `screenshots/` is committed. A file one directory up is gitignored | The screenshot **silently** never reaches the developer. No error |
| **Session Log** | A log of your sessions | A workbook sheet matched **by row position**, not by key | Insert or delete a row in Excel and every value below reattaches to the wrong row, silently |
| **Defect Log `Status`** | Yours to update | Generator-owned. Dispositions arrive through handoff packets and the sheet is a render of them | Harvesting it froze one finding at "Awaiting decision" for two rebuilds after it had been answered |
| **Sweep Results** | Harvested like the rest | Harvested from **nothing**, deliberately | It used to be harvested, which turned one stale manual paste into a permanently stale one. The sheet showed three-day-old numbers with nothing saying so |

## Counter and reading traps

| Reading | Looks like | Is actually |
|---|---|---|
| **`0 / 221 requests`** | The recorder captured nothing | 221 captured, **0 displayed**. An open search box with no match filters the list to empty, which looks identical to a dead panel |
| **A DevTools panel opened after page load** | The page made no requests | The recorder only starts when you open it |
| **"Too many attempts"** | A bug | A rate limit working. And the limit is a **bucket that refills**, so the exact count will not match a case that assumed a fixed number |

**The rule these three share:** a zero is only a result if you can tell a real zero from a broken instrument. Read the `X / Y` counter first. `Y > 0` means the recording worked, whatever the list shows.

## Handoff words

| Word | Looks like | Is actually |
|---|---|---|
| **Archived** | Done, fixed, shipped | Its **questions** are answered. Shipping is tracked separately and verified much later. **An archived packet does not mean the code changed** |
| **Closed** (a finding) | Fixed | May be fixed, may be refuted, may be superseded and wrong but kept as the record of the error |
| **Live packet** | Work in progress | Something in it still needs a person. One is currently held open waiting on external counsel, not on the developer |

## Account words

| Term | Looks like | Is actually |
|---|---|---|
| **The founder's account** | The obvious account to test with | The **least representative account on the platform**: an account holding platform-wide administrative rights, sitting in a comped organisation with a full bundle |
| **An alias account** | A separate user | A separate user **only when signup is email and password**. The other signup route does not reliably produce a separate identity, so the screen can look like a fresh account while you are signed in as the privileged one |
| **`+` addressing** | The standard way to make throwaway test accounts | Does not work here. These addresses are classified in a way that keeps them out of the routine cleanup, so they persist |
| **the plus-form spelling in the documents** | The account name | A **stale spelling**. The accounts use a hyphen, `alias-1`. Several files still write the plus form, including an evidence README and the archived packets, because `+` was tried first and abandoned |
| **The alias account's login** | One login for mail and for the product | Two different things. The alias has **no mail login of its own**: you sign in to email as the primary address to read the verification message, and complete signup in the product **as the alias**. Conflating them is a recorded mistake here |

**This block is the most expensive in the file.** Working from the wrong account does not fail. It passes, everything looks correct, and an entire phase of entitlement results is silently worthless.

---

## How to add to this file

A collision earns an entry when **someone acted on the wrong reading**. Not when a word is merely ambiguous. If nobody has been caught by it, it is a definition and belongs in the territory's own glossary, not here.
