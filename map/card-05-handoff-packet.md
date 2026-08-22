## Card 5 — The handoff packet

**Type** Boundary · **Mark** live · **Source** `qa/handoffs/INDEX.md`; the packet-and-response pair at `qa/handoffs/M3-send-and-sign.md` and `qa/handoffs/M3-RESPONSE.md` · commit `fb01f602`

Where the work leaves the tester's hands. A packet is a set of findings and questions issued to the developer; a RESPONSE file is what comes back, with a disposition on each one.

This is the only Boundary in the map, and the type is the point: **once a packet is issued, what happens next is not yours.** You cannot fix, prioritise, or decide — you can only ask well and record the answer. The packets are paired for that reason. The question and its answer live in two files with the same stem, so a reader can always see what was asked alongside what was decided, rather than a summary of both written afterwards by one side.

`INDEX.md` is the front of this object, and it states its own rule in the third line: **if it is in this folder it needs someone; if it is in `archive/` it does not.** Folder position *is* the status field. There is no "done" flag inside a packet.

> **Looks like** `archived` means the problem was fixed. **Is actually** that the packet's *questions* have been answered — the code change is tracked separately and lands later, if it lands. **Nothing tells you**: an archived packet full of answered questions reads exactly like a closed problem.

A second trap sits inside the answered packets. **A retest list is build-gated.** The response names the build its fixes landed in; run those cases against an earlier build and every one reads "not fixed", and a tester working front-to-back will put a closed finding back into the register as a new defect. The gate is stated in the packet header, which is read once, while the retest list is worked case by case, possibly days later.

**Hits** — the observations register, because a disposition returns and is recorded against the entry (card 4); the retest cases, which become runnable only at or above the named build (card 3); `INDEX.md` itself, which is the status and must be moved when a packet is spent — a spent packet left in place reads as the current front of the work.

**Does not hit** — **the product.** The obvious next thought on reading "FIXED — merged" is that the running build now contains it. That is two separate events: merged is a statement about the repository, deployed is a statement about the thing you are testing, and the gap between them is exactly where false regressions come from. Card 3 is how you tell.

**If you are unsure** — check `INDEX.md` before opening anything in `handoffs/`, and prefer it to the newest-looking file. The newest file is not the live one; the folder's own rule is.
