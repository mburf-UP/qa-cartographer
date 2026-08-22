## Card 3 — The build under test

**Type** Subject · **Mark** live · **Source** `qa/TEST-PLAN.md` §2.7 and §3.2; `qa/handoffs/M3-RESPONSE.md:3` · commit `fb01f602`

The running copy of the product your results were measured against. You do not control it, you cannot pin it, and it moves while you work.

It is a Subject rather than an Instrument because that is the whole difficulty: every other object in this engagement holds still while you use it. This one is redeployed by someone else, on their schedule, including mid-session — one deploy landed inside a session on 2026-08-16. A result without a build attached is not a result; it is an anecdote about an afternoon.

> **Looks like** a stable thing you are testing, the way a document is stable while you read it. **Is actually** a moving target that can change between two cases in the same phase, with no notification and nothing in the browser to mark the moment. **Nothing tells you** — the page looks identical either side of a deploy.

The plan names **one** method that works, in §2.7, and it is a response header read from the browser's network panel. It also names the obvious method that does not: an endpoint built for exactly this purpose returns 401 to a browser, so a tester who reaches for it concludes the build is unavailable rather than that they used the wrong door. The working method is manual, has to be done before recording rather than after, and is the reason the workbook's Session Log has a column for it.

**Hits** — every result recorded in the session, because a result's meaning depends on which build produced it; the retest lists in the handoff packets, which are build-gated and read "not fixed" against a build that predates the fix; the analyst's next report, which cannot separate a regression from a stale build without the hash.

**Does not hit** — **the test cases.** The natural thought on discovering the build moved is that the cases are now wrong and need rewriting. They do not. A case describes intended behaviour and is written against the plan, not against a build; what changes is whether *this run's result* still stands. Cases are edited in the generator (card 6) for reasons that have nothing to do with deploys. Separately it does not hit the observations register, which records what was observed at a stated build and is deliberately never rewritten when the build moves (card 4).

**If you are unsure** — read the build header and write it in the Session Log **before** you record any result, not after. If you cannot get it, record that you could not and say so in the session notes; an unknown build honestly marked is recoverable, and a result silently attributed to the wrong build is not.
