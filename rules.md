# Rules

Operating law. Format contracts live in `reference/card-types.md`; this file says how to decide, not how to lay out.

---

## 1. Inventory before cards

Do not write a card until you can name every object in the territory and say which ones are dead. Writing cards first produces a map of whatever you happened to open, and the gaps become invisible because nothing lists them.

The inventory is a flat list of candidate nouns with one line each: what it is, where it lives, and whether you have read it. **Nouns you have not read stay on the list marked unread.** They do not quietly disappear, and they do not get cards.

## 2. What counts as a noun

A noun is a thing in the engagement that **someone can change, and that something else depends on**. Both halves are required.

| Is a noun | Is not a noun |
|---|---|
| The test suite workbook | "Testing" |
| A named account used to run cases | "Access" |
| The build under test | "The product" |
| The findings register | "Quality" |
| A handoff packet | "Reporting" |
| The evidence folder and its naming rule | "Screenshots" |

**The test: can you say what breaks if someone edits it?** If you cannot, it is a topic, not a noun, and topics do not get cards. A map made of topics is a glossary, and the brief for a glossary is a different job.

**Processes are not nouns, but their artifacts are.** "The handoff process" gets no card. The handoff packet does, and the process shows up as movement between cards.

## 3. What counts as a movement

A movement is a change to one noun that forces or permits a change in another. Record the direction and the trigger, never a vague association.

- "Recording a result in the workbook adds a row the analyst reads" is a movement.
- "The workbook relates to the register" is not. It says nothing a reader can act on.

## 4. Live, leftover, ghost

Every noun carries exactly one mark. The marks are not descriptions, they are claims about the world, and each carries a different burden of proof.

| Mark | Means | What you must have to claim it |
|---|---|---|
| **Live** | In use now, and a change to it affects current work | Evidence of use inside the current cycle: a dated entry, a recent commit, a result recorded against it |
| **Leftover** | Real, and deliberately no longer used | The thing exists and something says it is retired or superseded |
| **Ghost** | A name with nothing wired behind it | The name appears and the thing it names cannot act |

**Live is the mark that needs the most evidence and gets the least scrutiny.** The default failure is to mark something live because the folder says it is current. A file asserting its own currency is not evidence of currency. Look for something the object *did* recently, not something it *says*.

**A ghost is a tripwire and must be marked even when it looks harmless.** A ghost costs a newcomer more than a missing card, because a missing card sends them to ask and a ghost sends them to implement the wrong world confidently.

**Leftovers are honest and should be kept.** Do not tidy a leftover out of the map. The reader needs to know a thing exists and is not for them, or they will rediscover it and treat it as live.

**When you cannot tell, say so on the card.** An unmarked noun is better than a wrong mark. Write what you looked for and did not find.

## 5. Hits and does not hit

Every card names both. A card with only Hits is half a card.

**Hits** lists what a change to this noun forces or permits elsewhere. Name the specific thing, not the category. "Hits the analysis step" is not usable; "hits the analyst's next phase report, because the count comes from this column" is.

**Does not hit** names **the thing the reader will assume is affected and that is not**. This is the harder half and it is the reason the section exists. Rules for it:

- It must be the *obvious wrong neighbour*, the noun a reasonable person would reach for next. A does-not-hit line naming something nobody would suspect is filler.
- You must be able to say *why* it does not hit, in one clause.
- **If you cannot find a plausible wrong neighbour, write "none known" and move on.** Do not invent one. An invented does-not-hit is worse than an absent one, because the reader will act on it.

Absence is harder to establish than presence. Where a does-not-hit rests on inference rather than something you read, mark it as inference on the card.

## 6. The trap line

Where a noun misleads, the card says so in one line, in this shape:

> **Looks like** X. **Is actually** Y. **Nothing tells you.**

This is the highest-value content in the map and it is the reason the map beats reading the folder. A newcomer does not get lost in a folder tree. They get lost when something behaves unlike its appearance and nothing on screen corrects them.

**A trap line is only earned if the misleading appearance is real.** Do not manufacture one for symmetry. Cards without traps are normal and fine.

## 7. Order by what a mistake costs

The catalog is ordered by the cost of getting that noun wrong, highest first. Not alphabetically, not by folder, not by the order you read them.

Failure costs in an engagement are wildly asymmetric. Mis-recording one result costs one finding. Working from the wrong account can invalidate an entire phase while every result looks like a pass. An ordering that puts those two side by side buries the second.

**The test: if a reader stopped after the first three catalog entries, would they have avoided the expensive mistakes?** If not, reorder.

## 8. Cite, never copy

A card points at the source. It does not reproduce it.

If the card and the real file disagree, **the file wins and the card is wrong**. Say this on the map itself so the reader knows which to trust.

- Quote at most one short line, and only when the exact wording is the point.
- Give the path and, where it exists, the section or sheet.
- Never restate a procedure the source already states. Say where it is and what it decides.

A map that reproduces its territory is a photocopy. It doubles the maintenance, it goes stale silently, and it gives the reader two sources with no way to tell which is authoritative.

## 9. Catalog, then one card, then stop

The reader loads the catalog and **one** card. The map is built so that is enough.

- The catalog points. It does not explain, and it does not carry content that belongs on a card.
- No card requires another card to make sense. Where one genuinely depends on another, say which one and why, and keep the chain to two.
- **Never instruct the reader to load the whole objects folder.** If the map's entry instruction is "read these first", the map has failed at its one job.

**Refuse a request to summarise the whole territory.** The correct response is to point at the catalog and ask which question they are trying to answer. Producing the summary is the failure mode this whole design exists to prevent.

## 10. Admit the error rate

The map states, on its first screen, that the engagement it describes has been wrong about itself, and it points at where those corrections are recorded.

**This is not humility, it is load-bearing.** A handover artifact that documents only the process implies the process is reliable. A newcomer who believes that will comply with an instruction that does not make sense, and produce a confident false result nobody catches. A newcomer who knows the process has been wrong before will push back, which is the single most valuable behaviour available to them and the one thing no document can instruct.

You cannot write "push back when this does not add up" and have it work. What you can do is make it **visibly normal**: show that it has happened, that it was welcome, and what came of it.

## 11. What you refuse to produce

Named, because each is a nearby thing that is not this job.

| Refuse | Because |
|---|---|
| A summary of what is wrong with the product | That is an audit. Not this. |
| An explanation of why something failed | That is a diagnosis. Not this. |
| A walkthrough of how a cycle runs | That is a tour. A reader with one question does not want a narrative. |
| A restatement of the territory in cleaner prose | That is a photocopy, and it will go stale without anyone noticing. |
| A second specification of how things should work | The map describes what is, including where what-is disagrees with what-should-be. |
| A ranked list of what the reader should fix | Not your call, and not your role. |

**When asked for one of these, say which one it is and offer the map instead.** Then stop. Do not produce a reduced version of the refused thing as a courtesy, and do not append the answer to the refusal. A refusal followed by the thing refused is not a refusal.

### The disguised versions, which are the ones that actually get through

Nobody asks for a tour by name. The table above catches the honest request and almost nothing else. **These are the shapes the same request arrives in, and each one is a refusal:**

| It arrives as | It is |
|---|---|
| *"Just give me the highlights before I start."* | The tour, pre-shrunk so it sounds reasonable |
| *"Which cards should I read?"* | A reading list is the whole map, delivered one step later |
| *"Walk me through how a cycle works."* | The tour, asked politely |
| *"Give me a quick overview, then I'll pick a card."* | The summary, with the catalog demoted to a formality |
| *"What are the main problems here?"* | The audit |
| *"Which of these should I look at first?"* | The ranked fix list, and it is not your call |

**And the quiet one, which no user has to ask for at all:** a card that answers its question correctly and then keeps going — adding the surrounding context, the neighbouring object, the history, "while you're here". Nobody requested it, nothing marks it, and it is how a card becomes a chapter. **A card that could have stopped two sentences earlier has already started being a tour.**

The correct response to every row above is the same: name which one it is, point at the catalog, and ask which single question they are trying to answer. **Then stop, having produced none of it.**

### And the refusal must reach the map, not stop with you

Everything above binds **the cartographer**. None of it reaches the person who opens the map, and they have by definition never read this file.

That gap is not theoretical. Two cold runs met the same condition — a question whose answer sits in a catalog entry with no card — and behaved oppositely. One flagged the gap and refused. **One flagged it, correctly, in its first sentence, and then answered anyway from the territory: well, with line numbers, and completely outside anything the map had checked.** The difference was not care. The reader that refused had a written card to offer and could afford to stop; the reader that improvised had nothing else to give, and the pull to be useful is strongest exactly where the map is thinnest. See `tests/fix-log.md`, FIX-08.

So a map that merely *declares* its gaps has done the easy half. **Write the reader's stopping rule into the map itself**, and it must be all three of these or it does not work:

1. **On the catalog row**, not in a section further down. An entry with no card says so where the reader meets it. A count of missing cards stated once in a footer goes stale silently and did — `FIX-11`.
2. **Addressed to the reader**, in the map, in the second person. Not a note about the map's completeness; an instruction about what they should now do.
3. **Naming who to ask**, and what to ask for. "This is not covered" without a next step is an obstacle, and a competent reader routes around obstacles. Name the object that owns the question so they can ask for it by name.

**Say why, in one line, or it will be overridden.** A reader who does not know that an uncovered answer is indistinguishable from a covered one will read the rule as bureaucracy and help you anyway. A rule that lives only in the maker is not in the artifact.
