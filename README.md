# A map of a live QA engagement

This folder maps the working objects of a live QA engagement against a commercial property-technology platform: a 267-case suite across 19 phases and 93 findings, run by one tester who does not build the product, handing findings to the developer who does.

It maps the objects, not the findings. What is wrong with the product is not in here and never will be — that would be an audit, and this is a map.

**The platform is not named, and nothing here identifies it.** No address, no domain, no person, no repository, no internal symbol, no route, and no security property of a running system. That is not squeamishness — the engagement is a third party's commercial system, mapped on trust, and this repository is public. What the map is *for* survives that completely: the value is in the shape — which objects exist, what a mistake costs, where the territory misleads you — and none of it needed a real name. See [Whether any of this is true](#whether-any-of-this-is-true) for the control that keeps it that way.

**Do not read this folder.** Reading it all would take longer than reading the engagement, which would make the map worse than useless. It is built so that a catalog and **one** card are enough. If you find yourself opening a third file to answer one question, that is a defect in the map and worth telling us about.

---

## Where to go

Find your line. Open the one file. Stop.

| If you are | Open | Which gives you |
|---|---|---|
| **Taking over the testing**, cold, with the last tester gone | [`examples.md`](examples.md) — the catalog at the top | The eight objects, ranked by what getting each one wrong costs. Read down until you reach your question, open that card, act |
| **Judging whether this works** | [`examples.md`](examples.md) — the catalog, then card 1 | Whether a stranger can find one thing, know why it is shaped that way, name what else moves, and stop |
| **Mapping a territory of your own** | [`identity.md`](identity.md) | What a cartographer is and refuses to be. [`rules.md`](rules.md) is the operating law behind it, and you want it second, not first |
| **Checking whether any of this is true** | [`check-map.ps1`](check-map.ps1) | Below |

The catalog is ordered by **what a mistake costs**, not by topic and not by folder. Stopping after three entries should still have saved you from the expensive mistakes. If it does not, the ordering is wrong and that is a defect too.

---

## Two things before you open a card

**Where a card and the real file disagree, the file wins and the card is wrong.** Cards cite; they never copy. Every card names the commit it was made from, so you can always tell a map that has aged from a map that was never right.

**This engagement has been wrong about itself 17 times in 93 findings**, and it writes those corrections down instead of tidying them away. That is not a disclaimer. A handover document that describes only a clean process quietly tells a newcomer the process is reliable, and a newcomer who believes that will follow an instruction that does not add up and produce a confident wrong result nobody catches. **Pushing back here is the expected case and the highest-value thing you can do.** There is a track record of it being welcomed, and the catalog says where it is kept.

---

## Every object has a card — and the stopping rule that got here

The catalog names **eight** objects and **all eight have cards.** Three are written out in [`examples.md`](examples.md) as the worked example; the other five are in [`map/`](map/), one file each. No card appears twice.

**If your question is not on a row at all, ask — do not improvise from the engagement's own files.** You would probably get the right answer, and you would hand it back in the same voice as one this map actually checked. The person reading your reply cannot tell those apart.

That rule is here because it was tested and the map failed it.

### The run that failed, and the run that proves the fix

A cold reader was given an earlier version and a question landing on two cards that were not yet written. It noticed they were unwritten, said so in its first sentence, **then read the source files and answered anyway** — correctly, with line numbers, well enough to act on. Declaring the gap had felt like the whole job. It is half of it, and the easy half.

Three changes followed: mark the gap **on the catalog row** where a reader meets it, put the stopping rule **in the map** addressed to the reader, and give the rule **its reason** rather than only its instruction.

Then the same question, to a fresh reader, against the fixed map:

| | Before | After |
|---|---|---|
| Found the right catalog entries | yes | yes |
| Said the cards were unwritten | yes | yes |
| **Then** | **read five source files and answered in full** | **stopped, and named what to ask for** |

The second reader paraphrased the reason back in its own words — *"you can't tell those apart from where you're sitting"* — and refused on that basis, while still saying what to request and by what name. **A refusal that leaves you stuck is a different thing from one that leaves you better off.**

Both runs, and the four before them, are in [`tests/cold-run/runs/`](tests/cold-run/runs/).

## Whether any of this is true

```text
pwsh -NoProfile -File check-map.ps1
```

It settles the two claims a machine can settle, across every card:

- **Every source a card cites is really there** — the path, the line, the section heading, and where a card quotes the source, the quoted words are on the line it points at.
- **Every object marked `ghost` is really absent**, in the scope the card claims. A ghost is a name with nothing wired behind it, and it is the mark that costs a newcomer most: a missing card sends them to ask, a ghost sends them to build against a world that is not there.

A card marked `ghost` that asserts nothing checkable **fails**. Otherwise the cheapest way to pass would be to claim nothing, and the mark needing the most evidence would carry the least.

The script is read-only against the engagement's repository: it opens files, lists directories, and reads the current commit. It writes nothing and runs nothing.

**You can run it, even though you cannot see the territory.** The engagement is a third party's private system and is not in this repository, so a synthetic one ships instead:

```text
pwsh -NoProfile -File check-map.ps1 -Map ./tests/fixture -Territory ./tests/fixture/territory
```

Two invented cards over an invented body of work, containing the three shapes the checker settles: a real section heading, a quote on a cited line, and a ghost that is genuinely absent. **Everything in [`tests/fixture/`](tests/fixture/) is made up** — it demonstrates a working check, not a good map. Without it this repository would claim a guarantee nobody could verify from a fresh clone.

**On its first run it failed this map**, on a ghost claim its author would have sworn to: a card said a function "exists and nothing calls it" when the engagement's own notes said *nothing in the **product** calls it*. Two words lost in paraphrase turned a careful claim into a false one. It also now guards mechanically against the one defect a cold reader had already caught by hand — two files pinning different commits — so that class cannot come back.

Every fix is logged in [`tests/fix-log.md`](tests/fix-log.md) with the change and the file it landed in, so you can check the fix is there rather than promised.

### The second control: nothing identifying ships

```text
pwsh -NoProfile -File check-safe.ps1
```

It scans every file here against a deny-list and exits non-zero on any hit. **Identifiers cannot be excused** — an address, a domain, a person, a repository, an internal symbol, a case-ID prefix. **Security-shaped statements** — an authentication behaviour, an administrative route, a privilege level — fail until a human reduces them to the abstract form and records in [`safe-allow.txt`](safe-allow.txt) what was removed to get there.

The distinction is the whole design. The abstract pattern is what makes this map worth reading; the specific instance is what would put a live system at risk. *"Something looks like one thing, is actually another, and nothing on screen tells you"* is the most useful sentence here and it endangers nobody. The account name attached to it endangers somebody and teaches nothing extra.

It exists because the risk is not carelessness. **A cold reader writing a transcript has every reason to paste in the real account, the real route, the real function name** — they make the answer concrete, and the reader has no idea the transcript is about to be published. The useful instinct and the dangerous one are the same instinct, and it recurs on every single run.

### Both controls are tested

A checker that has only ever passed is not evidence of anything, so both are attacked deliberately. **Both tests run from a fresh clone with nothing installed but PowerShell and Python:**

| Test | Injects | Result |
|---|---|---|
| [`tests/check-map-negative-test.py`](tests/check-map-negative-test.py) | 9 map defects into the fixture, one at a time, plus a control against false positives | **9/9 caught** |
| [`tests/check-safe-negative-test.py`](tests/check-safe-negative-test.py) | 20 planted identifiers, one at a time | **20/20 caught** |

**`check-safe` also caught its own allow-list lying.** Two entries claimed a security mechanism had been reduced to the abstract form. It had not — the full text was still in two files, and the scan passed the whole time because it printed a count instead of the claims. It now prints every exemption, with the reason claimed for it, on every run including passes. **A count is not a control.**

Last run 2026-08-22 against commit `fb01f602`: `check-map` **pass** — 8 cards, 20 citations, 3 ghost assertions, 1 ghost standing as declared-unverifiable. `check-safe` **pass** — 29 files, nothing identifying.

---

## The six runs, in one table

Every run is recorded verbatim in [`tests/cold-run/runs/`](tests/cold-run/runs/) with its answer key written **before** it ran. Nothing was tidied, nothing was re-run to get a better answer, and the partial is published in full.

| # | What it tested | Result |
|---|---|---|
| 01 | Adversarial — a question pointing at a plausible wrong object | pass |
| 02 | Front door — can a cold reader build a map at all | pass; produced the map used in 03–06 |
| 03 | Map use, question landing on unwritten cards | **partial — the finding that drove the fix** |
| 04 | Map use, question with a covered half and an uncovered half | pass |
| 05 | 03 repeated against the fixed map | **pass — the pair** |
| 06 | 04 repeated against the fixed map, as a regression control | **pass, no over-refusal** |

**Run 06 is there to try to break the fix, not confirm it.** A map that refuses everything scores full marks on "did it stop" and is worthless. Run 06 is the only question with both a covered and an uncovered half, so it is the only one that can detect over-refusal. It delivered the covered half in full, then stopped.
