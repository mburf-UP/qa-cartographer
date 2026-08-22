# Card types and the card contract

The closed set. Every noun gets exactly one type. If a noun fits none of these, it is probably not a noun (`rules.md` §2) or the set needs a deliberate addition, which is a change to this file and not a judgement call made mid-map.

---

## The five types

| Type | The reader's relationship to it | Test |
|---|---|---|
| **Instrument** | Something they **operate** | Can they run it, fill it in, or point it at something? |
| **Identity** | Something they **act as** | Does the answer change depending on which one they used? |
| **Record** | Something they **write into**, that outlives the session | Does someone else read it later to make a decision? |
| **Boundary** | Where work **leaves their hands** | Does a different person or system own what happens next? |
| **Subject** | What they **examine and do not control** | Can they change it? If yes, it is not a Subject |

**Why the type matters rather than being decoration:** it predicts the failure. An Instrument fails by being operated wrongly. An Identity fails silently and invalidates everything downstream. A Record fails by being written in the wrong place or the wrong column. A Boundary fails by implying more than it delivers. A Subject fails by moving underneath you.

**Identity cards are ordered first regardless of anything else.** They are the only type whose failure mode is *invisible success*.

---

## The card contract

Every card carries these, in this order. Nothing else.

```
# <noun>

**Type** · **Mark** · **Source**

One sentence: what it is.

Why it is shaped that way.        (one short paragraph, only if non-obvious)

**Looks like** X. **Is actually** Y. **Nothing tells you.**    (only if a real trap exists)

**Hits** — what a change here forces or permits.
**Does not hit** — the obvious wrong neighbour, and why not.

**If you are unsure** — the one thing to check, or who to ask.
```

### Field rules

**Mark** is exactly one of `live`, `leftover`, `ghost`, or `unknown`. Never two, never a hedge. `unknown` is a legitimate answer and says what you looked for.

**Source** is a path, plus a section or sheet where one exists, plus the commit the map was made from. A card with no source is not a card.

**Looks like / is actually** is omitted entirely when there is no genuine trap. An empty trap line invites invention, and an invented trap is worse than none (`rules.md` §6).

**Hits** names things, never categories. "Hits the phase report" is usable. "Hits reporting" is not.

**Does not hit** must name the neighbour a reasonable person would reach for, with a one-clause reason. If none exists, write `none known`. Do not manufacture one.

**If you are unsure** exists because the alternative is a reader guessing. One line, one action.

---

## Length

**A card is one screen.** If it does not fit, the noun is really two nouns, or you are explaining the territory instead of pointing at it.

The catalog entry for a card is **one line**: the noun, its type, its mark, whether the card exists, and the question it answers. The catalog explains nothing. Content in the catalog is content the reader loads whether they need it or not, which is the failure the whole design exists to prevent.

---

## The uncovered case

A catalog entry with no card yet is normal. **It is not finished until it says so on its own row.**

The row carries `not written — ask`, in the same column for every entry, next to the question that entry would have answered. That is the point of use: it is where a reader arrives with a question and decides what to do next.

**Not in a Gaps section further down, and not as a count.** Both were tried and both failed, in different ways:

- A gaps section is read *after* the reader has already chosen a row, so it arrives too late to stop them and reads as an apology rather than an instruction.
- A count goes stale silently. This map's own footer said five cards were unwritten when eight were, and it survived its author, the test author and two cold runs before a reader checked it (`tests/fix-log.md`, FIX-11). **A mark on each row has nothing to keep in sync**, which is why it is the row and not the count.

The catalog is still one line per noun. `not written — ask` is three words and it is the only content the catalog is allowed to carry that is not a pointer, because it *is* a pointer: it points at a person.

---

## What never goes on a card

- The territory's own text, restated. Cite it (`rules.md` §8).
- A list of what is wrong. That is an audit.
- Why something failed. That is a diagnosis.
- A sequence of steps. That is a runbook, and it belongs in the territory, not the map.
- History. How the territory came to be this way is the least useful framing for someone whose job starts now.
