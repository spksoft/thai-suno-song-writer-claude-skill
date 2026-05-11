# English Lyric Craft Frameworks

Named, citable English songwriting frameworks distilled into operational rules. Used during Step 3 (composition) and Step 7-D (hook/structure parts of the rhyme & form audit).

## 1. Pat Pattison (Berklee)

Most-cited modern songwriting academic. Books: *Writing Better Lyrics*, *Songwriting Without Boundaries*, *Essential Guide to Rhyming*. Four key concepts the skill should apply:

### (a) Object writing — concrete sensory imagery

Before drafting a lyric, brainstorm in all 7 senses for the song's central object/scene:

1. **Sight** — colors, shapes, light, motion seen
2. **Sound** — sounds heard
3. **Taste** — flavors
4. **Touch** — textures, temperatures, pressures
5. **Smell** — scents
6. **Body** — internal sensation, heartbeat, balance, dizziness
7. **Organic motion** — life-like movement, breathing, growth, decay

The point: train the writer (or LLM) to think in concrete sense-bound images rather than abstract emotion words.

**Operational use:** when the user describes a scene/feeling, the skill should generate 2–3 sensory-detail candidates for verse 1 instead of starting with "I feel sad / I feel happy".

### (b) Prosody = unity

Pattison defines prosody not narrowly as "stress matching" but as "everything in the song supporting the central idea." Every craft choice — meter, rhyme, melody, dynamics — gets evaluated by whether it makes the song MORE or LESS unified.

**Operational use:** when picking between two craft options (e.g., perfect rhyme vs assonance), pick the one that more strongly supports the song's central idea.

### (c) Stable vs unstable — the master grid

Every element of a song is either stable (resolved, expected, restful) or unstable (motion, tension, unresolved). The rule: **match instability to instability in content.**

| Element | Stable | Unstable |
|---|---|---|
| Number of lines per section | even (2, 4) | odd (3, 5) |
| Line length | equal lengths | varied lengths |
| Rhyme scheme | AABB, AABA | ABAB, ABCB, free |
| Rhyme type | perfect, family | additive, subtractive, assonance, consonance |
| Rhyme position | adjacent (couplets) | farther apart |
| Melody phrasing | starts on downbeat | back-phrased |
| Repeated chorus | exact repeat | varied repeat |

**Operational use:**
- A song about heartbreak should not sit on perfectly stable structures — that mismatches content with form.
- A bridge that delivers an emotional climax should LEAN unstable (uneven lines, assonance/consonance, new rhyme family).
- A resolved chorus that says "I'm sure of this" wants perfect rhyme, even line lengths, AABB.

### (d) The six rhyme types (see `rhyme-craft-en.md` §1)

Pattison's stability gradient: perfect → family → additive → subtractive → assonance → consonance. Used to choose rhyme types per line position.

## 2. Sheila Davis (NYU)

Books: *The Craft of Lyric Writing* (1985), *Successful Lyric Writing* (1988). Industry-songwriting framework.

### (a) The title test

**The title is the song's argument in compressed form.** Ira Gershwin's rule, which Davis quotes: "Prove a title is worth using by making sure it's what your lyric is all about."

**Operational use:** the hook (title phrase) must summarize the song. If a one-sentence summary of the lyric doesn't naturally contain the title, the title is wrong.

### (b) Singability

Every syllable should be physically singable:
- Avoid clusters of consonants on long held notes
- Favor open vowels (ah, oh, ee) on sustained notes
- Avoid sibilants (s, sh, z, ch) on the highest note of the chorus

(Cross-references: `english-diction-checklist.md` §7 and §8 for the audit rules.)

### (c) Front-load OR end-load the hook

The title goes in one of:
- Line 1 of the chorus (front-loaded)
- Last line of the chorus (end-loaded, most common)
- Both line 1 AND last line (bookended, strongest)
- Repeated every line (chant hook)

**Operational use:** if the title doesn't appear in the chorus at all, flag it — the song's argument is missing from its emotional center.

## 3. Stephen Sondheim — three principles

From *Finishing the Hat* (2010). Three rules that Sondheim said underpinned everything he wrote:

1. **Content dictates form.** The subject decides the structure, not the other way around. A stream-of-consciousness lyric is wrong for 32-bar AABA.
2. **Less is more.** Every word earns its place. Cut adjectives, cut throat-clearing.
3. **God is in the details.** Concrete, specific images beat abstract ones every time.

All three serve a fourth meta-principle: **Clarity.** The lyric is heard once, in real time, without re-reading — unlike poetry.

**Operational use:**
- Whenever form is being chosen, check the form against the content: is this form serving this idea, or is it the default?
- During revision, ask: which words could be cut without losing meaning?
- Whenever the lyric uses an abstract feeling-word, ask: can this be replaced with a concrete image?
- Read the lyric aloud once at speech pace. If it isn't comprehensible on first hearing, simplify.

## 4. Andrea Stolpe — 10-step framework

From *Popular Lyric Writing: 10 Steps to Effective Storytelling* (Berklee Press, 2007). Standard text at Berklee, Belmont, USC Thornton.

Condensed steps:

1. Identify the song's central idea in one sentence
2. Choose point of view (1st / 2nd / 3rd person; direct address vs narrator)
3. Brainstorm sensory imagery (Pattison's object writing)
4. Pick form to fit content (Sondheim's first rule)
5. Decide sectional balance (verse heavy? chorus heavy?)
6. Write the chorus first (commit to the hook before anything else)
7. Write verses to set up the chorus's payoff
8. Write the pre-chorus as a hinge
9. Write the bridge as a perspective shift
10. Audit: rhyme, prosody, singability, clarity

**Operational use:** when composing from scratch, the skill follows this 10-step order. The chorus is built first.

## 5. Jimmy Webb — marriage of music and lyric

From *Tunesmith* (1998). The principle: **melodic shape must reinforce lyric meaning.** A precursor to what Pattison would systematize as prosody.

**Operational use:**
- When the lyric has a directional word (up/down/rise/fall), suggest a matching melodic move in the Styles prompt.
- When the lyric has emotional contrast within a section, suggest dynamic contrast in production (`soft verse, building chorus`).

## 6. Jason Blume — six steps checklist

From *Six Steps to Songwriting Success* (2004/2017). BMI Nashville workshop. The most useful element for an LLM: explicit lyric checklists during evaluation:

- Does the lyric have a single, clear central idea?
- Does every section serve that idea?
- Does the title appear in the chorus?
- Does the chorus pay off the verses?
- Is the imagery concrete and sensory?
- Are the rhymes natural or forced?
- Does the song hold attention for its full length?

**Operational use:** this becomes part of the English Rhyme & Form audit checklist.

## 7. Show-don't-tell — three concrete moves

Literary "show don't tell" applied to lyric:

### Move 1. Concrete nouns over abstractions
"Empty chairs at the table" not "I'm lonely."
"The screen door slammed" not "He left in anger."

### Move 2. Sensory detail (Pattison's 7 senses)
Don't just say what; specify how it looked, sounded, smelled, felt.

### Move 3. Action verbs
"She slammed the screen door" not "She was angry."
"I poured the wine" not "I was nervous."

### The anti-pattern
"Feeling words" (love, sad, lonely, broken, free, alive, dead, alone, hurt, happy, joy, pain) on stressed positions. Use them sparingly; let imagery do the emotional work.

**Audit rule (used in Step 7-D §11):** if a chorus line is >50% abstract feeling-words, suggest swapping one for a concrete image or action verb.

## 8. Hook construction — synthesized rules

The hook is the title phrase, typically 2–7 syllables. Construction rules:

1. **Length**: 2–4 syllables most memorable. 5–7 acceptable. >8 risky.
2. **Vowel choice**: open vowels (ah, oh, ee) project better than closed vowels (uh, ih, eh) on sustained notes.
3. **Placement in chorus**: line 1, last line, both (bookended), or every line (chant).
4. **Repetition target**: ≥3× per chorus, ≥6× per song.
5. **Melodic prominence**: hook gets the highest melodic note or the longest sustained note of the chorus.
6. **Singability**: avoid consonant clusters; avoid sibilants if hook lands on a high note.

## 9. Point of view (POV)

Four POVs in songs:

- **1st person** ("I") — most intimate; the singer is the speaker. Pop, R&B, ballad default.
- **2nd person** ("you") — direct address; the singer speaks TO someone. Country love songs, pop confessionals.
- **3rd person** ("he/she/they") — narrator-removed; the singer tells a story. Country story-songs, folk ballads, narrative pop.
- **1st-and-2nd combined** ("I / you") — most common in pop. Singer addresses a beloved.

POV must be consistent within a song unless the bridge intentionally shifts (e.g., 1st-person verses → 2nd-person bridge for direct confrontation).

**Audit rule:** if POV drifts between sections without justification, flag.

## 10. Quick reference card

| Question | Answer (the framework) |
|---|---|
| How to start writing? | Object writing (Pattison) — 7 senses around the central image |
| What form? | Content dictates form (Sondheim) — fit the structure to the idea |
| Where does the title go? | Line 1, last line, both, or every line of the chorus (Davis) |
| How concrete? | Show, don't tell — concrete nouns, sensory detail, action verbs |
| What rhyme type? | Match instability to content (Pattison) — perfect for resolution, assonance for tension |
| What POV? | 1st-and-2nd is the pop default; 3rd for stories; stay consistent |
| What to cut? | Anything that doesn't earn its place (Sondheim's "less is more") |
| How to evaluate? | Blume's checklist — central idea? title in chorus? sensory imagery? natural rhymes? |
