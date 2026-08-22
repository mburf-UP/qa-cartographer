# Walk order

How the cartographer walks a territory. Six passes, in order. Do not start writing cards during pass 1.

---

## 1. Inventory

List every candidate noun with one line each: what it is, where it lives, and **whether you have read it**. Nothing is dropped for being boring. Unread items stay on the list marked unread and do not get cards (`rules.md` §1).

Output: a flat list. No structure, no grouping, no judgement yet.

## 2. Kill the non-nouns

Apply `rules.md` §2. For each item ask: **can I say what breaks if someone edits this?** Topics, processes and qualities come off the list. Their artifacts stay.

Expect to lose a third of the list here. If you lose none, you were listing files rather than nouns.

## 3. Mark

Assign `live`, `leftover`, `ghost` or `unknown` to each survivor, with the evidence each mark requires (`rules.md` §4).

**Do this before writing any card.** Marking is where the map earns its keep and it is the pass most often skipped, because live feels like the safe default and it is not. Look for what the object *did* recently, never what it *says* about itself.

Ghosts get found in this pass or not at all. A name cited in documentation whose file does not exist, a persona approved but never provisioned, a switch present by name and impossible to turn on: none of these announce themselves.

## 4. Trace movements

For each noun, what does a change to it force or permit elsewhere? Record direction and trigger (`rules.md` §3).

Then, for each, find the **obvious wrong neighbour**: the noun a reasonable person would assume is affected and is not. This is the slowest pass and it produces the highest-value line on every card.

## 5. Order by cost

Rank by what getting that noun wrong costs (`rules.md` §7). Identity-type nouns go first regardless, because their failure mode is invisible success.

Test the ordering: **if a reader stopped after three entries, would they have dodged the expensive mistakes?**

## 6. Write

Catalog first, one line per noun. Then cards, in the order the catalog lists them, to the contract in `card-types.md`.

Write the catalog before the cards, not after. A catalog derived from finished cards inherits whatever the cards happened to cover.

---

## Two standing rules for the walk

**Pin the commit.** Record the exact revision the map was made from, on the catalog. A territory under active work changes while you are mapping it. A map that does not say when it was true cannot be checked, and cannot be safely trusted later.

**Never load the whole territory to write one card.** If a card requires reading the entire folder, the map is not going to save anyone anything. Read what the card cites, and cite what you read.

## When to stop

Stop when every noun on the surviving inventory has a card or an explicit `unknown`. Not when the map feels complete: that feeling arrives well before the ghosts are found, and after the point where extra cards stop helping.
