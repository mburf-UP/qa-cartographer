## Card 4 — The observations register

**Type** Record · **Mark** live · **Source** `qa/OBSERVATIONS-REGISTER.md`; field definitions at `qa/TEST-PLAN.md` §5.3 · commit `fb01f602`

The permanent record of what was found. Ninety-three findings, each one an entry that outlives the session that produced it and that someone else reads to make a decision.

Its first line states the rule the whole file is built on: findings are **logged, not changed**. An entry is written once, and when it turns out to be wrong the correction arrives as a *new* entry that supersedes it — the wrong one stays, marked. That is why the file is the engagement's memory rather than its current opinion, and it is the reason a reader can tell what was believed at the time from what is believed now.

A finding is not a bug report. Each entry carries a status, a confidence, a severity, a risk tier, the test cases it touches, the finding itself with sources, a proposed resolution that requires sign-off, and — the field that matters most and is easiest to skip — **what else changes if the proposed fix is applied**. That last field exists because a fix that quietly breaks a neighbouring thing is how a QA cycle turns into two.

> **Looks like** a list of problems, so a reader skims for the severe ones. **Is actually** a decision record, where the most expensive entries are often the ones marked closed or not-a-defect — because those carry the reasoning that stops the same thing being re-raised in three weeks. **Nothing tells you**: a closed entry and an open one look the same in the file.

**Confidence is stated because some entries were read from code and some were confirmed against the running product**, and those are different claims. An entry can be right about the code and wrong about the world.

**Hits** — the handoff packet, which is assembled from entries and inherits their severity and disposition (card 5); the workbook's defect log, which is a render of dispositions rather than a place to set them (card 2); the test cases named in an entry, which may be rewritten or withdrawn as a result (card 6).

**Does not hit** — **the recorded test results.** The instinct on writing a finding is that the case it came from now needs its result changed. It does not. The result records what happened when the case ran; the finding records what was concluded about it. They are separate columns owned by separate steps, and overwriting the first to match the second destroys the evidence the second rests on. Nor does adding a finding change the build (card 3) — nothing here deploys.

**If you are unsure** — do not edit an existing entry. Add a new one that names the entry it supersedes and says why. If your finding might duplicate one already recorded, say so in the entry rather than searching for certainty first; a duplicate that names its twin costs a minute, and a finding withheld because it might be known costs the finding.
