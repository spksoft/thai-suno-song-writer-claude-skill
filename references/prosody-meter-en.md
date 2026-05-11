# English Prosody & Meter for Song Lyrics

The English parallel to `tonal-melodic-rules.md`. While Thai's hardest constraint is **tone-melody alignment** (เพี้ยน), English's hardest constraint is **stress-beat alignment**. This file explains how English stress works, how it interacts with sung melody, and what the skill flags in Step 7-B.

## 1. English is stress-timed (the load-bearing difference vs Thai)

- **Thai is syllable-timed** — each syllable gets roughly equal duration; tones carry meaning.
- **English is stress-timed** — stressed syllables fall at roughly equal time intervals; unstressed syllables compress between them. The unit of English rhythm is the **foot**.

Practical consequence: an English line's "feel" comes from **where the stresses land**, not how many syllables it has. A 10-syllable line and a 13-syllable line with the same 4 stresses feel about the same length.

This is why English rhyme can survive uneven syllable counts but breaks instantly when stress hits the wrong syllable.

## 2. Metrical feet that matter for songwriting

| Foot | Pattern | "da-DUM" | Where it shows up |
|---|---|---|---|
| **Iamb** | u / | da-DUM | most common in English pop, ballad, conversation |
| **Trochee** | / u | DUM-da | nursery rhymes, marches, anthemic rock choruses |
| **Anapest** | u u / | da-da-DUM | folk ballads, country, limericks ("'Twas the night before Christmas") |
| **Dactyl** | / u u | DUM-da-da | waltz, Irish trad, some country |
| **Spondee** | / / | DUM-DUM | emphatic phrases, hooks |

**Defaults for genres:**
- Pop/rock/country/ballad: iambic dominant (matches conversational English).
- Anthemic rock choruses: trochaic (front-loaded shouts).
- Folk ballads / country / sea shanties: anapestic (galloping feel).
- Religious / hymn-derived: iambic tetrameter or common meter.

## 3. The stress-to-downbeat rule

**Core rule:** stressed syllables land on strong beats (1 and 3 in 4/4 time); unstressed syllables land on weak beats (2 and 4, or off-beats).

Violating this rule creates "wonky prosody" — the music emphasizes a syllable that the speaker would naturally swallow. The listener perceives the lyric as forced or mis-fit to the melody.

### Test procedure

For any line, do this mental check:
1. Read the line aloud as conversational English. Notice which syllables you naturally stress.
2. Mentally place the line over the melody. Check: do the music's downbeats / longest notes / highest pitches fall on the same syllables?
3. If yes → prosody is correct. If no → flag.

### Common violations

**A. Function words on downbeats**
- "*The* night is dark" — "The" is unstressed in speech but lands on beat 1 if it's the line's first word and the melody starts on the downbeat.
- "*Of* all the times" — same problem.
- Fix: rearrange so a content word leads. "Night is dark" (drop the article) or "All the times I tried."

**B. Wrong-syllable stress on multi-syllable words**
- "Play me a song on your gui-TAR" — natural stress is gui-TAR (second syllable). If the melody emphasizes the first syllable, it becomes "GUI-tar" and sounds wrong.
- "I'll be there to-MOR-row" — natural is to-MOR-row. Wrong: TO-mor-row.
- Multi-syllable word stress is **dictionary-fixed**. The melody must respect it.
- Fix: swap for a synonym or restructure.

**C. Verbs accidentally stressed as nouns** (homograph stress)
- *record* — verb (rih-KORD) vs noun (REH-cord). Music may pick the wrong one.
- *contract* — verb (kun-TRAKT) vs noun (KON-trakt).
- *desert* — verb (dih-ZURT) vs noun (DEZ-urt).
- *present* — verb (prih-ZENT) vs noun (PREZ-ent).
- Detect: any of these words at a stressed position where the wrong stress would change meaning.

## 4. Line length consistency (Pattison's "stable vs unstable")

Pattison's framework: **equal-length lines feel stable; unequal-length lines feel unstable.** Both have purposes.

| Pattern | Feel | Use when |
|---|---|---|
| All lines equal length | Stable, declarative | Verses about certainty; resolved choruses |
| Alternating short / long | Stable through pattern | Ballad meter (8-6-8-6) |
| Lines lengthening | Building tension | Pre-chorus into chorus; bridge climax |
| Lines shortening | Settling, resolution | Outro; bridge resolution |
| Irregular / unpredictable | Unstable | Unsettled emotions, restless ideas |

Paul Simon's "Still Crazy After All These Years" bridge famously shortens the 4th line to create instability matching the emotional content. This is craft, not chaos.

### Length targets per section

| Section | Syllables per line | Rationale |
|---|---|---|
| Verse | 8–10 (up to 12) | Story-detail level; room for nouns and verbs |
| Pre-chorus | 4–8 | Shorter for lift |
| Chorus | 10–12 | Wider than verse for projection; the hook gets air |
| Bridge | Variable | Often deliberately uneven |
| Hook (within chorus) | 2–7 syllables | Memorable, repeatable, projectable |

**Hard ceiling: 15 syllables.** Lines >15 syllables get rushed by Suno and consonants collapse. Flag in Step 7-B.

## 5. Back-phrasing (relaxed conversational singing)

Singing the melody slightly LATER than the written rhythm. Creates relaxed, conversational, intimate feel. Heavy in jazz, R&B, country soul, Adele-style pop.

For Suno, this isn't something the lyric writer controls directly — but it can be hinted at in the Styles field:
- `conversational delivery`
- `relaxed back-phrasing`
- `behind-the-beat phrasing`
- `loose Adele-style delivery` (note: no artist name — that's a community-known but Suno-blocked phrase — use "smoky female delivery, slightly behind the beat" instead)

For Thai songs, back-phrasing also exists but is less of a craft signature (Thai tonal language makes precise on-beat delivery clearer).

## 6. Word painting (text painting)

**Melodic shape mirrors lyric meaning.** The melody DESCENDS on words like "down", "fall", "valley"; RISES on "up", "fly", "mountain"; HALTS on "stop", "freeze".

Handel's *Messiah*: "valley" ends low, "mountain" peaks, "exalted" rises. Modern: "Friends in Low Places" sings "low" on a low note; "Despacito" slows tempo on "despacito" (= "slowly").

For Suno, word painting is something the prompt-builder can **suggest** in the Styles field but cannot force:
- For a song with a "rise" or "fall" key word, add `melodic contour matches lyric direction` to Styles.
- For a song with a "stop" or "freeze" moment, add `dramatic pause on key word` to Styles.

These are weak hints — Suno may or may not honor them. They cost little and occasionally land.

### Word-painting candidate vocabulary (flag for melodic hint)

When the lyric contains any of these as content words (not function words), suggest a corresponding melodic hint in the Styles prompt:

| Word | Suggested melodic move |
|---|---|
| up, rise, high, lift, climb, soar | ascending melodic line |
| down, fall, low, sink, drop, plunge | descending melodic line |
| stop, halt, freeze, pause, still, silence | held note / dramatic pause |
| run, race, chase, hurry, fast | rapid syllable rhythm |
| slow, wait, drift, drag | sustained note |
| break, shatter, snap | staccato |
| flow, drift, wave, river | legato / sustained |
| heart-beat, pulse, thunder, drum | rhythmic emphasis |

This is a **soft suggestion** in the skill's output — flagged as optional polish, not a required fix.

## 7. The prosody audit (used in Step 7-B)

When reviewing English lyrics for prosody (not pronunciation — see `english-diction-checklist.md` for that), scan with these questions:

### Per line
1. **Stress-to-downbeat alignment** — Are content words landing on inferred strong positions (line-start, after caesura)? Function words on weak positions?
2. **Multi-syllable words** — Is dictionary stress respected? Flag forced wrong-stress.
3. **Line length** — Within target for its section (verse 8–10, chorus 10–12)? Hard flag if >15.
4. **Line-end consonant load** — Heavy consonant cluster at line-end on a held note? Flag.

### Per section
5. **Length consistency** — Are lines within ±2 syllables of each other, or deliberately varied for effect? Flag chaotic variance.
6. **Stress pattern consistency** — Is the section predominantly iambic, trochaic, or anapestic? Mixed feet within one section feel jarring unless intentional.

### Across the song
7. **Word-painting opportunities** — Does the lyric contain directional / movement / motion words? Suggest melodic hints in Styles.

Output flags in the standard format: `- Line "…": [issue], suggest "…"`.

## 8. Severity → summary (parallel to other audits)

| Flag count | Summary |
|---|---|
| 0 | `Prosody clean — stress and line lengths within targets` |
| 1–2 | `Minor prosody issues` |
| 3–5 | `Multiple prosody risks — review one section` |
| 6+ | `Many prosody risks — consider redraft` |

Counted independently from English Diction, English Rhyme, Thai phonetic, Thai rhyme, and Bilingual mixing audits.

## 9. Composition guidance (use when writing fresh English lyrics)

1. **Decide the dominant foot** based on genre — iambic for pop/ballad; trochaic for anthemic rock chorus; anapestic for country/folk story-song.
2. **Set a syllable target per section** — verse 8–10, chorus 10–12, pre-chorus 4–8.
3. **Write the line, then test-stress it** — read aloud in conversational English, mark stressed syllables.
4. **Check the stresses fall where the music wants them** — first syllable of the line, plus regular intervals (every other syllable for iambic, every third for anapestic).
5. **Adjust word choice** to move stress where needed — usually a synonym swap fixes it.
6. **Watch line-end** — does it land on an open vowel? On a heavy consonant?

## 10. Common pitfalls (anti-pattern reference)

- **Forcing rhyme by inverting word order** ("the road I walked alone" instead of "I walked alone down the road") — also a rhyme issue (see `rhyme-craft-en.md` §4) but also a prosody issue because it breaks natural stress.
- **Cramming too many syllables to fit the line** — Suno will rush. Cut a word.
- **Stretching too few syllables across the line** — Suno will add melismas you didn't want. Add a syllable.
- **Pop verse iambic but chorus suddenly trochaic without intent** — the song feels jolted. Either commit to the contrast or unify.
- **Long held note on a closed-vowel word** (see `english-diction-checklist.md` §7) — vowel collapses; cross-audit issue.
- **Multi-syllable word straddling a melodic phrase break** — natural stress gets cut. Move the word to a single-phrase position.

## 11. Quick reference card

| If the line is… | Check this |
|---|---|
| First line of a verse | Starts with content word (not "the/of/a")? |
| Hook line (title) | 2–7 syll? Open-vowel ending? Highest note of chorus? |
| Chorus line, not the hook | 10–12 syll, iambic/anapestic? |
| Long sustained note word | Open vowel? Light consonant cluster? |
| Multi-syllable content word at line-start | Dictionary stress respected by the implied downbeat? |
| Two adjacent lines | Within ±2 syllables of each other? |
| Pre-chorus line | Shorter than verse and chorus? Lifting toward chorus? |
| Bridge line | Either uniform (stable bridge) or deliberately uneven (unstable bridge)? |
