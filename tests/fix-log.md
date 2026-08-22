# Fix log

Every change made to the map because a cold run found something. Each entry names the run, the change, and the file it landed in, so anyone can check the fix is actually there rather than promised.

Entries are append-only. A fix that was later reversed says so; it is not deleted.

---

## From run 01 (class E, adversarial) — 2026-08-22

**FIX-01 · "eight entitlement cases" was eight of nine, unexplained** · `examples.md` card 1

The run read the case file and found P14 holds `ENT-001` to `009`. Eight carry the `FREE` persona; `ENT-007` carries `PRO`, which has never been runnable. Every document in the territory says "eight" and means the eight `FREE` ones without saying so, and the card inherited the number without the reason. A reader counting cases in the source would have found nine and no explanation.

Card 1 now states eight-not-nine and points at card 8 for why.

**FIX-02 · the "does not hit" line named the wrong wrong-neighbour** · `examples.md` card 1

The card named the recipient flow. The run named *"the findings recorded outside the entitlement phase"*, on the grounds that the thought a reader actually has on realising they used the wrong account is that the whole session is void.

That is the better line, and the reason is instructive: **the card was written to describe a noun, the run was answering a real question, and the wrong neighbour is situational.** `rules.md` §5 asks for the noun a reasonable person would reach for, which means the person's situation, not the card's.

Adopted. The recipient flow is demoted to a supporting sentence rather than deleted, because it is still true.

**FIX-03 · card 8's ghost rested on one source when three exist** · `examples.md` card 8

The run cited `handoffs/INDEX.md:132` and `S1-2026-08-15-RESPONSE.md:110`, neither of which the card referenced: *"Still not available… do not plan entitlement tests around it."* Three independent statements is a materially stronger claim than one, and a ghost is exactly the mark that needs the most support.

Both added to the card's source line.

**FIX-04 · two cards were the same failure and neither said so** · `examples.md` card 8

Unprompted, the run connected them: *"A hand-written grant was ruled out precisely because it would invalidate the cases it exists for — the same failure as the account you used, from the other end."*

Card 1 is an identity with too much privilege. Card 8 is an identity with none. Both destroy the same phase. That relationship was in neither card and is now in card 8.

---

## Not fixed, and why

**`METHOD.md` §6 criterion 2 cannot distinguish reading-to-answer from reading-to-verify.** Run 01 answered correctly from the catalog and one card, then opened three uncited files to check itself. Literally that fails the criterion; in substance it is better than passing it.

**Left as written.** The criterion was fixed on 2026-08-18 before any run, and changing it mid-series to fit a result is the exact move that makes a test method worthless. It stands for the remaining runs and gets revised afterwards, with this entry as the reason.

---

## From run 02 (class A, front door) — 2026-08-22

**FIX-05 · `reference/collisions.md` carried a stale commit pin** · `reference/collisions.md`

It said `3d5edab6` while `examples.md` said `fb01f602`. Two files in the same folder asserting different versions of the same territory, which is precisely the defect comp #9 named as *"One canonical copy, and any disagreement between copies is a bug, not a variant"* — shipped here by the person quoting it.

The run caught it and was careful about it: *"pinned to commit `3d5edab6`, which I cannot check against; the two files agreed everywhere I compared them."* It did not assume the disagreement was substantive, and said what it had actually checked.

Repinned. `tests/ghost-resolved.md` still names both commits, correctly, because both are the subject of that record.

**FIX-06 · two account collisions were missing** · `reference/collisions.md`

The run found documents writing the plus-form spelling where the accounts use a hyphen, a plus form surviving in an evidence README and the archived packets because `+` was tried first and abandoned. It also separated two things the map had merged: the alias has **no mail login of its own**, so you read the verification message as the primary address and complete signup as the alias. Conflating those stops a newcomer working entirely.

Both added.

**FIX-07 · `rules.md` §5 asks for the wrong kind of wrong-neighbour** · pending

Two runs, two "does not hit" lines better than the card's, and the same reason both times: **the run was answering a real question and the card was describing a noun.** The obvious wrong neighbour is situational, so it belongs to the reader's moment rather than the card's subject.

§5 currently says "the noun a reasonable person would reach for". It should say "the noun a reasonable person would reach for **in the situation that sends them to this card**". Held until after the remaining runs, because changing operating law mid-series makes the later runs untestable against the earlier ones.

**FIX-08 · a map declares its gaps and does not defend them** · `rules.md` §11, `reference/card-types.md` · held

Run 03 (class F2) asked a question whose answer sits in two catalog entries with no card written. The map said so, in its first paragraph, correctly. Then it read the territory and answered anyway, well and at length.

**The refusal rule is binding on the cartographer and never reaches the map.** §11 tells the cartographer what to refuse. The map inherits its honesty about gaps and none of its discipline at them, and the map's reader has by definition never read §11.

Three changes, applied together after F1:

1. `rules.md` §11 gains a second half. Refusing is not enough; the cartographer must **write the reader's stopping rule into the map itself**, addressed to whoever opens it, naming who to ask. A rule that lives only in the maker is not in the artifact.
2. The catalog marks unwritten entries **in the catalog row**, not only in a Gaps section further down. Run 03 reached the right entries immediately and the map still let it walk past them.
3. `card-types.md`'s card contract gains the uncovered case: what an entry that has no card yet must say, in one line, at the point of use.

**Held until F1 has run**, per the FIX-07 reasoning: changing operating law mid-series makes the runs incomparable. Then re-run F2 against the fixed map as run 05 and ship the pair.

**Diagnosis corrected 2026-08-22, after run 04 (F1).** The wording above — the map "inherits its honesty about gaps and none of its discipline at them" — is too strong, and run 04 disproves it. Given the same unchanged map and the same structural condition, run 04 **refused**: *"an answer sourced from outside its coverage would be indistinguishable from one it actually supported."*

So the map *can* produce a refusal. What it cannot do is produce one **reliably**, and the two runs show what decides it:

| | Run 03 (F2) | Run 04 (F1) |
|---|---|---|
| Covered half of the answer | none — both cards unwritten | substantial — card 1 written |
| What refusing would have returned | nothing usable | a complete answer minus one part |
| What it did | answered from the territory | refused, and named who to ask |

**The map stops a reader who already has something to give, and does not stop one who would otherwise come back empty-handed.** The pull to improvise is strongest exactly where the map is thinnest, so the gap-handling fails precisely in the conditions that create it.

**All three changes stand unaltered.** This is a stronger case for them, not a weaker one: a control that holds only when it is not needed is not a control. Only the reason is restated.

---

## From the checker (`check-map.ps1`) — 2026-08-22

Not a cold run. The first thing the checker was pointed at was the map, and it failed it. Logged here anyway, because the fix-log's job is to record every change the map made because something found something, and a script is something.

**FIX-09 · card 8's ghost claim was false as written** · `examples.md` card 8

The card said of an internal administrative function that it **"exists and nothing calls it"**.

It has five call sites in the product repository — seed scripts, a demo-data script, and two test files. "Nothing calls it" is simply not true of the territory. [REDACTED: the function name and its call sites, being internals of a third party's production system]

**The territory said it correctly and the card lost the qualifier in compression.** `qa/handoffs/archive/M0-RESPONSE.md:126` reads *"nothing in the **product** calls it"*, and names the two surfaces it checked. Drop two words and a true, carefully scoped claim becomes a false one. This is `rules.md` §8 — cite, never copy — failing in its quiet form: not a wholesale photocopy, but a paraphrase that shed the very qualifier doing the work.

Card 8 no longer makes the unscoped claim at all, and cites `M0-RESPONSE.md:126` as its source. The scoped version is not published either: settling it mechanically would mean naming internals of a third party's production system, so card 8 carries an explicit `unverifiable` declaration with that reason, and `check-map.ps1` reports it as a standing WARN rather than letting it pass in silence.

**What this changes about ghosts generally.** A ghost is not absence, it is **absence within a scope**, and the scope is the whole substance of the claim. An unscoped ghost is either unfalsifiable or wrong. So `check-map.ps1` takes no bare "absent" assertion: every ghost names the scope its absence holds in, and **a card marked `ghost` that asserts nothing checkable fails**. Otherwise the cheapest way to pass is to claim nothing, and the mark that needs the most evidence (`rules.md` §4) would be the one carrying the least.

**Worth saying plainly:** this defect survived three cold runs. Runs 01, 02 and 03 all had access to the card and none queried it, because it reads as authoritative and checking it means grepping a repository none of them were asked to search. Cold readers and a checker do not find the same class of thing, and neither substitutes for the other.

---

## From the operator (`check-safe.ps1`) — 2026-08-22

**FIX-10 · the entry identified the live system it describes** · every shipped file

Mike read run 03 and stopped the round: the runs named real account addresses, the owner's account and its privilege level, the mail domain, a third party by name, the repository, an internal function, an administrative route, and an unremediated finding from an external security audit. This repository is public and linked from an open chat.

**He was right, and the failure is instructive rather than careless.** Nothing here was pasted in thoughtlessly. Every one of those details was added because it made an answer concrete and checkable — which is exactly what the map asks a reader for. **The useful instinct and the dangerous one are the same instinct**, and it fires on every run, which is why this could never have been fixed by resolving to be careful.

122 items across 19 files, now zero. The map's value did not depend on any of them: *"the account that looks ordinary and holds administrative rights"* is the entire trap, and the address attached to it taught a reader nothing extra.

**Three changes, and the second is the one that lasts.**

1. **De-identified throughout.** Product, domain, accounts, people, repository, pull requests, case-ID prefixes and pillar names generalised. Security-shaped statements reduced to the abstract pattern — the SSO trap now says the two signup routes do not reliably produce the same identity, with no mechanism. The audit finding is gone entirely, marked `[REDACTED: security-audit finding about a live system]`. Transcripts carry a declared-substitution header and are otherwise verbatim; no claim, count or verdict moved. This is `METHOD.md` §4's own provision, written 2026-08-18 before any run, so it is a use of the method rather than a break in it.
2. **`check-safe.ps1`**, which fails the build on any identifier and cannot be talked round. Identifiers are never allow-listed. Security-shaped phrasing is allow-listed only after reduction, in `safe-allow.txt`, naming what was removed. Proven by `tests/check-safe-negative-test.py`: 20 planted identifiers, 20 caught, clean copy passing.
3. **Card 8's ghost lost its machine check**, because settling it meant naming product internals. Rather than weaken the rule that a ghost must assert something, `check-map.ps1` gained `unverifiable <reason>` — it demands a stated reason and prints a WARN on every run including a passing one, so an unproved ghost can never go quiet. Card 6 gained the ghost that *can* be published: `build-workbook.mjs:38-39` recommends two helper scripts that are not in `qa/scripts/`, verified absent. **This is a better demonstration than the one it replaced** — `path X absent` is the crispest check in the set, and it is a dead name inside a live folder, which is the harder kind to spot.

**What this cost the entry: nothing that was load-bearing.** What it added: a second enforced guarantee, a worked example of a real constraint being met rather than described, and the observation that the risk was structural. Recorded here rather than smoothed away, on the same principle as everything else in this file.

---

## From run 04 (class F1, map use) — 2026-08-22

**FIX-11 · the map under-reports its own gaps, and the wrong number propagated into the test design** · `map/MAP.md` (recorded, not edited), `tests/cold-run/QUESTIONS-AND-KEYS-classF.md` (corrected by appendix)

`MAP.md:76` says *"Cards 5–9 are named and marked but not written."* **Only Card 1 is written.** Eight of nine are absent, not five of nine. The Gaps section never lists unwritten cards at all — it lists three files the cartographer could not read, which is a different thing under the same heading.

**And the wrong number travelled.** `QUESTIONS-AND-KEYS-classF.md:22`, written by the person who built the test, repeats it: *"Its cards 5 to 9 are named in the catalog and deliberately unwritten."* Taken from the map, not checked against it.

**This is the map's own defining failure, committed twice by its author.** `rules.md` §4: a document asserting its own currency is not evidence of currency. That rule was written about the `live` mark and applies with exactly equal force to a map's account of its own coverage. It passed unremarked through the map's author, the test author, and two prior runs, and a cold reader caught it on its third exposure.

**No verdict moves.** Run 03's key named cards 4 and 7 as unwritten — true. Run 04's key named entry 2 — true. The count was wrong and every specific claim resting on it was right, which is precisely how a wrong count survives: nothing that depends on it fails.

`MAP.md` is a verbatim run-02 artifact and is **not edited** (`METHOD.md` §4). `QUESTIONS-AND-KEYS-classF.md` gets a dated appendix rather than a rewrite, per `CMP-013`: a test document revised after its runs cannot be checked by anyone.

**What it costs the map to fix:** nothing here — it is fixed by FIX-08 item 2, which marks unwritten entries in the catalog row itself. A count stated once in a footer goes stale silently; a mark on each row cannot, because there is nothing to keep in sync.

---

## From runs 05 and 06 (class F, against the fixed map) — 2026-08-22

**FIX-08 is applied and it works. Recorded here as a result, not a fix.**

| Run | Question | Map | Verdict |
|---|---|---|---|
| 03 | F2 | v1 | **partial** — flagged the gap, then answered from the territory |
| 05 | F2 | **v2** | **pass** — flagged the gap, refused, named who to ask and what for |
| 04 | F1 | v1 | pass |
| 06 | F1 | **v2** | **pass, and no over-refusal** — full covered half delivered, uncovered half refused |

**The case that was failing changed. The case that was passing did not.** Run 05 reached the same two catalog entries as run 03, by the same route, and stopped where run 03 walked on. Run 06 still delivered card 1 in seven bullets before refusing card 2.

**Three specifics worth keeping**, because each maps to one of FIX-08's three parts:

1. **The reason travelled, not just the rule.** FIX-08 insisted the stopping rule carry a one-line *why* or a competent reader would override it as bureaucracy. Run 05 paraphrased the reason back in its own words — *"you can't tell those apart from where you're sitting"* — and used it as the justification. A rule is something to obey; a reason is something to reach.
2. **The catalog column did the stopping, not the Gaps section.** Both runs reproduced the `Card` column in their own tables. The gap was met at the row, at the moment of choosing, which is the whole of item 2.
3. **Run 06 quoted the amended card 1 handoff line verbatim** as its justification — one of exactly three edits in v2. The behaviour is traceable to the specific change rather than merely correlated with the version.

**And the refusals stayed useful.** Both named the object to ask for by name, flagged that the workbook itself is missing so the request is for the artifact and not only the card, and left the operator better off than when they arrived. A refusal that leaves the reader stuck does not survive contact with anyone in a hurry, and would have been reverted within a week.

**The sceptic's objection, and the answer.** *The map now tells the reader to stop, so stopping proves only obedience.* Run 06 refutes it: a reader obeying mechanically had every excuse to stop at the top, since the question names the entitlement cases and that row is marked unwritten. Stopping there satisfies criterion 4 completely and returns nothing. Instead it split the question across two rows, delivered the covered one and refused the other. That is a coverage judgement.

---

## From the scanner's own output — 2026-08-22

**FIX-12 · the allow-list claimed a reduction that had not happened** · `safe-allow.txt`, four shipped files

Six `authbypass` entries in `safe-allow.txt` read *"reduced to 'the two routes do not produce the same identity'; mechanism removed"*, *"as above"*, and *"identical text… already reviewed there"*.

**Two of them were false.** The full mechanism was still in `produced-map-run02.md:53` and `MAP-v2.md:63`, and in two run transcripts — naming the resolution behaviour and the condition under which the button renders. Reproducible, about a live system, in files that ship. The reduction had been done in `examples.md` and `collisions.md` and never carried across.

**The scan passed the whole time.** It printed `11 allow-listed hit(s)` and moved on. Nothing was wrong with the rule, the pattern or the match — **only the reasons lied**, and reasons were the one thing the control never checked.

Worse, the entries pointed at each other. *"As above"* and *"already reviewed there"* are not reasons; they are references to a review, and they read as though someone had checked while asserting nothing that could be false.

**Three changes:**

1. **The mechanism is reduced in all four files**, under each transcript's existing declared-substitution header, and marked `[REDACTED: the mechanism, being an authentication behaviour of a live system]`. All six `authbypass` allow entries are deleted — with the text actually reduced, the rule needs no exceptions at all.
2. **`check-safe.ps1` prints every suppression on every run, pass included**, with the claimed reason and the text it excuses. A count is not a control. An exemption that cannot be seen is indistinguishable from one that is doing its job.
3. **It also reports any allow entry that matched nothing.** A stale exemption reads exactly like a live one, and nobody re-reads a file that is passing. And `safe-allow.txt` now requires every reason to stand alone: no "as above", no pointing at another entry, no reference to a review rather than to the text.

**This is the same failure the map exists to name, committed inside the control built to prevent it:** a document asserting something about itself, believed because it was written down. `rules.md` §4 about the `live` mark; `FIX-11` about the gap count; and now the allow-list. Three instances, one shape, and the third one was guarding the security boundary.

## Not fixed, and why

**The run folder is not a git repository**, so the map's own "pin the commit" rule cannot be satisfied inside the test. Run 02 fell back to dates and said so, which is the correct handling.

**This is a defect in the test staging, not the map** — copying files out of the repo stripped the git context the rule depends on. Left as-is for the remaining runs so every run faces identical conditions; noted here so nobody reads the date-pinning in run 02 as the map failing its own rule.
