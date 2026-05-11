# English Prosody, Rhyme & Diction

Unified English-side reference for **stress-beat alignment**, **rhyme craft**, and **pronunciation risk**. Used by Step 3 (composition), Step 3.5 (directives layering), and Step 7 audits (7-B diction/prosody, 7-D rhyme/form) for any English content (English-only or English-primary bilingual).

Replaces older split `prosody-meter-en.md` + `rhyme-craft-en.md` + `english-diction-checklist.md`. Per skill's "warn, don't auto-fix" rule: every audit flags issues and proposes rewrites, never silently rewrites.

**TOC:** 1. Stress-timing & prosody · 2. Rhyme craft · 3. Diction checklist (10 patterns) · 4. Combined audit checklist (Step 7-B + 7-D) · 5. Severity → summary · 6. Composition workflow · 7. Quick reference cards.

**Cross-refs:** `suno-platform.md` (tag grammar, sliders, directives), `english-genre-craft.md` (forms, genres, frameworks, Style templates), `english-examples.md` (worked outputs).

---

## 1. Stress-timing & prosody

The English parallel to Thai tone-melody alignment (เพี้ยน). Where Thai's hardest constraint is tone-vs-pitch alignment, English's hardest constraint is **stress-vs-downbeat alignment**.

### 1.1 English is stress-timed (the load-bearing difference vs Thai)

- **Thai is syllable-timed** — each syllable gets roughly equal duration; tones carry meaning.
- **English is stress-timed** — stressed syllables fall at roughly equal intervals; unstressed syllables compress between them. The unit of English rhythm is the **foot**.

An English line's "feel" comes from **where the stresses land**, not how many syllables it has. A 10-syllable line and a 13-syllable line with the same 4 stresses feel about the same length. This is why English rhyme can survive uneven syllable counts but breaks instantly when stress hits the wrong syllable.

### 1.2 Metrical feet that matter for songwriting

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

### 1.3 The stress-to-downbeat rule

**Core rule:** stressed syllables land on strong beats (1 and 3 in 4/4 time); unstressed syllables land on weak beats (2 and 4, or off-beats).

Violating this rule creates "wonky prosody" — the music emphasizes a syllable that the speaker would naturally swallow. The listener perceives the lyric as forced or mis-fit to the melody.

**Test procedure:**
1. Read the line aloud as conversational English. Notice which syllables you naturally stress.
2. Mentally place the line over the melody. Check: do the music's downbeats / longest notes / highest pitches fall on the same syllables?
3. If yes → prosody is correct. If no → flag.

**Common violations:**

**A. Function words on downbeats**
- "*The* night is dark" — "The" is unstressed in speech but lands on beat 1 if it's the line's first word and the melody starts on the downbeat.
- "*Of* all the times" — same problem.
- Fix: rearrange so a content word leads. "Night is dark" (drop the article) or "All the times I tried."

**B. Wrong-syllable stress on multi-syllable words**
- "Play me a song on your gui-TAR" — natural stress is gui-TAR (second syllable). If the melody emphasizes the first syllable, it becomes "GUI-tar" and sounds wrong.
- "I'll be there to-MOR-row" — natural is to-MOR-row. Wrong: TO-mor-row.
- Multi-syllable word stress is **dictionary-fixed**. The melody must respect it.

**C. Verbs accidentally stressed as nouns** (homograph stress)
- *record* — verb (rih-KORD) vs noun (REH-cord).
- *contract* — verb (kun-TRAKT) vs noun (KON-trakt).
- *desert* — verb (dih-ZURT) vs noun (DEZ-urt).
- *present* — verb (prih-ZENT) vs noun (PREZ-ent).

### 1.4 Line length consistency (Pattison's "stable vs unstable")

**Equal-length lines feel stable; unequal-length lines feel unstable.** Both have purposes.

| Pattern | Feel | Use when |
|---|---|---|
| All lines equal length | Stable, declarative | Verses about certainty; resolved choruses |
| Alternating short / long | Stable through pattern | Ballad meter (8-6-8-6) |
| Lines lengthening | Building tension | Pre-chorus into chorus; bridge climax |
| Lines shortening | Settling, resolution | Outro; bridge resolution |
| Irregular / unpredictable | Unstable | Unsettled emotions, restless ideas |

Paul Simon's "Still Crazy After All These Years" bridge famously shortens the 4th line to create instability matching the emotional content — craft, not chaos.

**Length targets per section:**

| Section | Syllables/line | Rationale |
|---|---|---|
| Verse | 8–10 (up to 12) | Story-detail level |
| Pre-chorus | 4–8 | Shorter for lift |
| Chorus | 10–12 | Hook gets air |
| Bridge | Variable | Often deliberately uneven |
| Hook (within chorus) | 2–7 | Memorable, projectable |

**Hard ceiling: 15 syllables.** Lines >15 get rushed by Suno and consonants collapse. Flag in Step 7-B.

### 1.5 Back-phrasing (relaxed conversational singing)

Singing the melody slightly LATER than the written rhythm. Creates relaxed, conversational, intimate feel. Heavy in jazz, R&B, country soul, smoky-pop.

For Suno, this isn't something the lyric writer controls directly — but it can be hinted at in the Styles field:
- `conversational delivery`
- `relaxed back-phrasing`
- `behind-the-beat phrasing`
- `smoky female delivery, slightly behind the beat`

(No artist names — `Adele-style` etc. are silently filtered by Suno. Use sonic descriptors.)

### 1.6 Word painting (text painting)

**Melodic shape mirrors lyric meaning.** Melody DESCENDS on "down/fall/valley"; RISES on "up/fly/mountain"; HALTS on "stop/freeze". Handel's *Messiah*: "valley" ends low, "mountain" peaks. Modern: "Friends in Low Places" sings "low" on a low note; "Despacito" slows on "despacito".

For Suno, word painting is a **soft suggestion** in Styles, not forced. Add `melodic contour matches lyric direction` for rise/fall keywords; `dramatic pause on key word` for stop/freeze moments. Costs little, occasionally lands.

**Candidate vocabulary** (flag for melodic hint):

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

Soft suggestion only — flagged as optional polish, not a required fix.

---

## 2. Rhyme craft

Scope: rhyme and form (scheme, density, hook placement, cliché pairs). Pronunciation risk lives in §3. Step 7-D runs this; Step 7-B runs §3. Two audits stay separate.

### 2.1 The six rhyme types (Pattison)

Pattison's framework ranks six types by **closure** — how resolved the ear feels. From most stable to least:

| # | Type | Definition | Example | Closure |
|---|---|---|---|---|
| 1 | **Perfect** | Identical stressed vowel + identical consonants after | *cat / hat*, *light / night*, *taken / shaken* | Max — completes the line |
| 2 | **Family** | Same vowel + consonants from same phonetic family* | *bat / cab*, *fit / lid*, *knock / jog* | Strong but with forward motion |
| 3 | **Additive** | Matching vowel; rhyming line ADDS a final consonant | *stow / hope*, *year / feared* | Mild tension |
| 4 | **Subtractive** | Matching vowel; rhyming line DROPS a final consonant | *bake / stay*, *shout / now* | Mild tension, feels unresolved |
| 5 | **Assonance** | Matching stressed vowel, different ending consonants | *rope / known*, *straight / fame* | Clearly unstable |
| 6 | **Consonance** | Different vowels, matching ending consonants | *bat / spit*, *run / gone* | Most unstable |

*Phonetic families (voiced/unvoiced consonant pairs): p/b · t/d · k/g · f/v · s/z · sh/zh · ch/j · m/n/ng (nasals).

**Pattison's stability rule:** stable thought (resolution, certainty) → perfect or family. Unstable thought (longing, question, doubt) → additive, subtractive, assonance, or consonance. The last line of a chorus that resolves wants perfect; a bridge that questions wants assonance/consonance.

**Anti-patterns:** *identity rhyme* (same word repeated — craft failure unless deliberately hypnotic); *eye rhyme* (*love/move*, *cough/though* — looks like a rhyme on paper but sounds different; useless in song).

### 2.2 Rhyme schemes

| Scheme | Pattern | Stability | Where it fits |
|---|---|---|---|
| **AABB** | couplet | very stable | folk, country verse, kids' songs, hymn |
| **ABAB** | alternating | moderate | pop verse, ballad, sonnet-influenced |
| **ABCB** | only lines 2 and 4 rhyme | unstable / natural | folk ballad, country, story-songs (the "natural speech" scheme) |
| **AABA** | rhyme returns; line 3 releases | stable with detour | 32-bar standards, ballads |
| **ABABCDCD** | extended alternating | extended motion | longer pop verses, hip-hop |
| **AAAA** | monorhyme | hypnotic / heavy | rap, comedic, list songs |
| **AABBA** | limerick | comic | rare in pop |
| **Free** | no scheme | maximally unstable | post-2010 indie, some hip-hop |

**Genre defaults:**
- **Country**: ABCB or AABB in verses; AABB or ABAB in chorus.
- **Pop**: ABAB or ABCB in verses; AABB or repeating end-word in chorus.
- **Folk**: ABCB or ABAB; ballad meter (alternating 4-stress / 3-stress lines).
- **Hip-hop**: AAAA, AABB, or complex multisyllabic chains.
- **Indie**: often ABCB or no scheme; perfect rhyme can feel "too pop" for indie aesthetics.
- **R&B**: looser — slant rhymes, repeating end-words, internal rhymes; perfect rhyme is optional.
- **Rock**: AABB or ABAB. Less internal rhyme than pop; more memorable couplets.
- **Ballad** (cross-genre): perfect or family preferred — slow tempo lets the ear hear each rhyme land.

**Pattern: title at end of chorus** (strongest hook placement for pop, country, R&B, rock):
```
Hook line 1: …  end with rhyme word A
Line 2:       …  rhyme with A or different
Line 3:       …  rhyme with A
Hook line 4: …  end with title (rhymes with line 1 or line 3)
```

### 2.3 Internal, multisyllabic, mosaic rhyme

- **Internal rhyme** — rhymes within a single line, not at line-end. Adds density. Default in hip-hop; increasingly in pop bridges and R&B verses.
- **Multisyllabic ("multis")** — two-or-more syllables rhyming as a unit (*spaghetti / heavy already*; *vacation / aggravation*). Hallmark of advanced rap.
- **Mosaic rhyme** — multiple words form the rhyme unit (*head / instead*; *insane / pen game*). Closely related to multisyllabic.

**When to use:** pop verse/chorus → end-rhyme only; R&B/soul → light internal in verses; hip-hop verses → internal + multi + mosaic, dense; hip-hop hook → simple end-rhyme (chantable); pop bridge → light internal works.

### 2.4 The "rhyme cheating" problem

Forced rhyme is the most common amateur failure. Four diagnostic patterns:

**2.4.1 Inverted syntax to land a rhyme** — "Down the road I walked alone" instead of "I walked alone down the road". Test: would a native speaker say this in conversation?

**2.4.2 Filler lines** that exist only to set up a rhyme. Test: if you cut the line, does the song still make sense? If yes, it's filler.

**2.4.3 Cliché pairs.** Audit list (flag any of these):

| Cliché pair | Why it's tired | Better alternative |
|---|---|---|
| fire / desire | Decades of pop ballads | fire / mind (assonance) |
| heart / apart | Universal but exhausted | heart / start, heart / scarred |
| eyes / lies | Classic but predictable | eyes / time (assonance), eyes / disguise |
| love / above | Hymn-derived, overused | love / enough (family), love / shove |
| time / mine | Adequate but flat | time / find (family) |
| baby / maybe | Pop ballad cliché | baby / wavy, baby / safety |
| night / light | True pair but stale | night / right, night / quiet |
| day / way | Universal default | day / okay, day / stay |
| true / you | "I love you / it's true" trope | true / through (family) |
| soul / whole | Soul ballad cliché | soul / hold (additive) |
| cry / why | Tired question-answer | cry / try, cry / sigh |
| dream / scheme | Old-fashioned | dream / seam, dream / clean |
| me / free | Predictable | me / breathe, me / receive |
| fall / all | Cheesy when paired | fall / call, fall / small |

Fix: switch to family or assonance. Flag the cliché pair and suggest 1–2 alternatives.

**2.4.4 Meaning twisted to fit the rhyme** — "I rode my bike through the fire / Just to feel my heart's desire". Test: does every line serve the song's central idea?

**Remedy: loosen the scheme.** Move from AABB to ABAB to ABCB; from perfect to family to assonance. **ABCB is the "natural speech" scheme** — only half the lines rhyme, so the writer has 50% more freedom.

### 2.5 Rhyme density rules (Suno-specific)

**Dense end-rhyme breaks Suno's melodic phrasing in melodic genres.** Too dense, too perfect, too repetitive → Suno over-emphasizes last words, rushes lines, crowds the chorus.

**Per section:** Verse 50–75% rhymed line-ends · Pre-chorus 50–100% · Chorus 50–75% (LOWER than verse — needs air) · Bridge 0–75% (loose for contrast).

**Per genre:** Pop/Country 50–75% chorus · Folk 50% (ABCB ballad meter) · Rock 75–100% · Hip-hop verse 100%+ · Hip-hop hook 50–75% · R&B 50% or less · Indie variable.

**Rule of thumb:** reserve dense, multisyllabic, internal-rhyme writing for rap/spoken sections only. Melodic sections need less rhyme, not more.

### 2.6 Hook placement

The hook is the title phrase, typically 2–7 syllables. Must appear in the chorus in one of four positions:

1. **Line 1** — front-loaded
2. **Last line** — end-loaded (most common)
3. **Both line 1 AND last** — bookended (strongest)
4. **Every line** — chant hook (EDM, anthems)

If the hook never appears in the chorus, flag. Exceptions: chorus IS the title; or narrative-delayed hook (rare).

**Sub-rules:** Title 2–7 syll (1–4 most memorable) · Hook gets highest melodic note or longest sustained note · Prefer open vowels (ah/oh/ee) over closed (uh/ih/eh) on sustained notes · Repeat hook ≥3× per chorus, ≥6× per song.

### 2.7 Show-don't-tell

A pop chorus uses either concrete imagery + action, or abstract feeling-words.

**Works:** "Standing at the door, holding back the tears / Counting all the years we wasted"
**Doesn't:** "Feeling so sad and broken inside / I'm lonely without you tonight"

**Audit rule:** if a chorus line is >50% abstract feeling-words (love, sad, lonely, broken, free, alive, dead, alone, happy, hurt), suggest swapping one for a concrete image or action verb.

---

## 3. Diction checklist (pronunciation risk)

Pronunciation/rendering risk only — whether Suno will mispronounce a word. For each line of lyrics, scan for these 10 patterns. Format each flag as:

```
- Line "…": [issue], suggest rewriting as "…"
```

### The 10 risk patterns

**1. Homographs** (same spelling, multiple pronunciations) — Suno guesses, often wrong; re-rolling rarely fixes.

Starter list: *read* (past/present), *live* (verb/adj), *lead* (verb/metal), *bass* (fish/music), *tear* (water/rip), *wind* (air/coil), *wound* (injury/past-of-wind), *close* (verb/adj), *refuse* (verb/noun), *present* (gift/introduce), *object* (thing/disagree), *conduct* (verb/noun), *desert* (abandon/sand), *produce* (verb/noun), *record* (verb/noun), *contract* (agree/shrink).

Fix: disambiguate with context, swap synonym, or use unambiguous form.

Example flag: `- Line "I tear the page in two": "tear" is homograph (rip vs eye-water); suggest "I rip the page in two"`

**2. Silent letters / irregular spelling** — Suno reads phonetically and gets it wrong.

Examples: *knight, queue, colonel, choir, Wednesday, gnome, pneumonia, mortgage, salmon, debris, rendezvous, faux.*

Fix: phonetic respell or pick a synonym.

**3. Loanwords** — *genre, fiancé, café, façade, ballet, bouquet, déjà vu, naïve, résumé, croissant.* Keep if intentional; flag if on a stressed downbeat or held note.

**4. Acronyms** — `AI`, `JR`, `ATM`, `DJ`, `LA`, `NYC`, `OK`. May read as fused word or as letters inconsistently.

Fix: force the version you want — `A I` with space, `A.I.`, or spell out as `okay` / `aye` / `eye`.

Example flag: `- Line "Lost in the AI dream": "AI" may render as "eye" or "ay-eye" — suggest "A I" with space, or "Lost in the cyber dream"`

**5. Numbers and dates** — `2024` may be read as "two thousand twenty-four", "twenty twenty-four", "two-zero-two-four", or skipped.

Fix: spell out. `2026` → `twenty twenty-six`; `100%` → `one hundred percent`; `5G` → `five G`; `911` → `nine one one`.

**6. Lines >15 syllables** (approximate via word count >14) — Suno rushes long lines and consonants collapse. Sweet spot 6–12 syllables; verses 8–10, choruses 10–12.

Fix: split into two lines.

**7. Closed vowels on long held notes (line-end)** — vowels /ʌ/ (uh), /ɪ/ (ih), /ɛ/ (eh) collapse into nothing when held more than a half note.

At-risk endings: *bus, fun, but, sit, fit, hit, met, get, let* at end of chorus line.

Fix: swap for an open-vowel word — /ɑ/ (ah), /i/ (ee), /u/ (oo), /oʊ/ (oh), /eɪ/ (ay).

**8. Sibilant clusters on the highest sustained note** — words with /s/, /ʃ/, /z/, /tʃ/ on the climax note hiss and distort.

At-risk: *kisses, blessings, shoulders, chases, splashes, finishes, whispers.*

Fix: rephrase so the climax lands on an open vowel; move the sibilant word off the peak.

**9. Function words on inferred downbeats** — the/of/a/an/to/and/but/or/so as the first word of a chorus or pre-chorus line tends to land on the downbeat but is unstressed in natural speech.

Fix: start the line with a content word, or invert the phrase.

**10. Multi-syllable words with wrong dictionary stress** — *to-MOR-row* sung as *TO-mor-row*; *gui-TAR* sung as *GUI-tar*; *com-PLETE* sung as *COM-plete*.

Fix: swap for a synonym or restructure the line.

### Quick scan algorithm

For a complete lyric, scan in this order:
1. First pass — homographs (§1).
2. Second pass — silent-letter words (§2).
3. Third pass — line length: count words per line, flag >14.
4. Fourth pass — line-end vowels: last word of each line, closed-vowel endings on chorus/long-held positions.
5. Fifth pass — acronyms, numbers, function-word line-starts combined sweep.
6. Sixth pass — sibilant clusters in chorus lines for ≥2 sibilants in the title or hook word.
7. Aggregate — produce one flag per genuine risk. Stop at 6 flags (more is noise; surface a meta-flag "Multiple risk patterns — consider redraft").

### When NOT to flag

- Common short function words on weak beats (only flag on inferred downbeats).
- A homograph that's unambiguous in context (e.g., "she read the letter yesterday").
- A loanword that the genre embraces (e.g., "déjà vu" in moody indie).
- Numbers part of known references (1999 Prince, "Year 3000").
- Sibilants in verse lines (only flag on chorus high-note positions).

### Example clean flag block

```
### ⚠️ Pronunciation Risk Flags (English)

- Line "I can read your mind tonight": "read" homograph; context implies present but Suno may render past; suggest "I can see your mind tonight"
- Line "Just a 2AM thought": "2AM" number + acronym; suggest "Just a two A M thought" or "Just a late-night thought"
- Line "Hear my whispers in the silence": "whispers" sibilant-heavy on likely chorus high note; consider rephrasing
```

Or, if clean: `No major risks detected`

---

## 4. Combined audit checklist (Step 7-B + 7-D)

Two parallel audits, kept visually separate in the Step 8 output. Emit flags in the standard format: `- Line "…": [issue], suggest "…"`.

### 4-A. Prosody audit (Step 7-B prosody sub-section)

**Per line:**
1. **Stress-to-downbeat alignment** — Are content words landing on inferred strong positions (line-start, after caesura)? Function words on weak positions?
2. **Multi-syllable words** — Is dictionary stress respected? Flag forced wrong-stress.
3. **Line length** — Within target for its section (verse 8–10, chorus 10–12)? Hard flag if >15.
4. **Line-end consonant load** — Heavy consonant cluster at line-end on a held note? Flag.

**Per section:**
5. **Length consistency** — Are lines within ±2 syllables of each other, or deliberately varied for effect? Flag chaotic variance.
6. **Stress pattern consistency** — Is the section predominantly iambic, trochaic, or anapestic? Mixed feet within one section feel jarring unless intentional.

**Across the song:**
7. **Word-painting opportunities** — Does the lyric contain directional / movement / motion words? Suggest melodic hints in Styles.

### 4-B. Diction audit (Step 7-B pronunciation sub-section)

Run the 10-pattern scan from §3 in order. Emit one flag per risk, stop at 6. Aggregate into:

```
### ⚠️ Pronunciation Risk Flags (English)
- Line "…": [issue], suggest "…"
- Line "…": [issue], suggest "…"
```

### 4-C. Rhyme & form audit (Step 7-D)

**Per chorus:**
1. **Does the chorus rhyme?** Detect the scheme (AABB / ABAB / ABCB / etc.) and report it. If no scheme detected → flag.
2. **Does the title appear in the chorus?** In line 1, last line, both, or every line? If absent → flag.
3. **Is the chorus rhyme density 50–75%?** If >75% → flag "may break melodic phrasing"; if 0–25% → flag "may feel unrhymed / lose chorus quality."
4. **Any cliché pairs in the chorus?** Flag against the §2.4.3 list.

**Per verse:**
5. **Does the verse have a discernible scheme?** Report it. If completely free in a non-indie/non-spoken context → flag.
6. **Verse 1 / Verse 2 share at least one rhyme family?** Cohesion check. Soft flag if entirely different.
7. **Any cliché pairs in verses?** Flag.
8. **Any forced syntax inversions or filler lines?** Flag with best-effort detection.

**Across the song:**
9. **Hook repetition count** — title repeated ≥3× per chorus? Flag if less.
10. **Bridge present** (for songs >2:30)? Flag missing.
11. **Show-don't-tell pass** — if chorus >50% feeling-words, soft flag with suggestion.

### 4-D. POV & form consistency (used in Step 7-D)

12. **POV consistent within the song?** If POV drifts between sections without justification, flag.
13. **Section tags from recognized vocabulary?** Custom labels like `[My Cool Section]` are NOT understood by Suno; flag (see `english-genre-craft.md` §1 for valid tags).
14. **Chorus pasted identically in every chorus slot?** Suno requirement.

---

## 5. Severity → summary mapping

Three independent audit blocks, each counted separately.

| Flag count | Prosody summary | Diction summary | Rhyme/form summary |
|---|---|---|---|
| 0 | `Prosody clean — stress and line lengths within targets` | `No major risks detected` | `Rhyme scheme detected: [X]; hook placement: line [N]; no major issues` |
| 1–2 | `Minor prosody issues` | `Minor risks — review and decide` | `Minor rhyme/form issues — review and decide` |
| 3–5 | `Multiple prosody risks — review one section` | `Multiple risks — consider rewriting one section` | `Multiple issues — recommend reworking one section` |
| 6+ | `Many prosody risks — consider redraft` | `Many risks — recommend redraft` | `Many issues — consider redraft` |

Each English audit is counted independently from Thai เพี้ยน, Thai rhyme, and bilingual-mixing audits.

---

## 6. Composition workflow

When writing fresh English lyrics:

1. **Decide the dominant foot** based on genre — iambic for pop/ballad; trochaic for anthemic rock chorus; anapestic for country/folk story-song.
2. **Set syllable target per section** — verse 8–10, chorus 10–12, pre-chorus 4–8.
3. **Pick the hook (title phrase)** — 2–7 syllables, open-vowel ending preferred.
4. **Choose chorus rhyme scheme** — AABB or ABAB default; ABCB for ballad/country.
5. **Pick the hook's rhyme partner** — write one line ending with a word that perfectly or family-rhymes with the title.
6. **Fill in chorus lines** — keep density 50–75%; lean on perfect rhyme for the resolution line, family or assonance for tension lines.
7. **Pick verse scheme** — usually ABCB or ABAB (one degree less stable than chorus).
8. **Write Verse 1** — open with concrete image (Pattison's show-don't-tell; cf. ครูสลา's "first 5 seconds").
9. **Write Verse 2** — share at least one rhyme family with Verse 1; new content, parallel structure.
10. **Write pre-chorus** — different rhyme family from verse and chorus; acts as hinge.
11. **Write bridge** — perspective shift; deliberately unstable rhyme (assonance/consonance) OR new rhyme family.
12. **Test-stress each line** — read aloud in conversational English; mark stressed syllables; verify they fall where the music wants them.
13. **Audit** — run §4 checklist; rework any flag.

### When the user already has lyrics

If the user pasted their own English lyrics (skipping Step 3), the skill still runs the §4 audits. Flag issues alongside; always offer rewrite suggestions; never silently rewrite.

If the user's lyrics have systematic rhyme issues (e.g., no scheme at all, in a genre that expects one), say so directly — "These lyrics don't have a discernible end-rhyme scheme — for a [pop/country/rock] song, that will sound prose-like rather than song-like. Want me to suggest a refactor?" — and wait before rewriting.

---

## 7. Quick reference cards

### 7-A. Prosody quick card

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

### 7-B. Rhyme quick card

| If the section is… | Default rhyme strategy |
|---|---|
| Pop verse | ABAB, 50–75% density, perfect or family |
| Pop chorus | AABB or repeated end-word, title at end, 50–75% |
| Country verse (story-song) | ABCB, perfect rhyme strongly preferred |
| Country chorus | AABB, title at end, perfect rhyme |
| Folk verse (ballad meter) | ABCB, 8-6-8-6 syllables |
| Rock chorus | AABB couplets, title shouted, perfect rhyme |
| Hip-hop verse | AAAA or complex chain, multisyllabic + internal |
| Hip-hop hook | AABB or repeated end-word, simple and chantable |
| R&B verse | Loose (any scheme), light internal rhyme |
| R&B chorus | Repeated end-word ("me/you" identity), melismatic |
| Indie verse | ABCB or free, perfect rhyme avoided |
| EDM hook | Single repeated phrase before drop |
| Bridge (any genre) | Often deliberately unrhymed or in new family |

### 7-C. Common pitfalls (anti-pattern reference)

- **Forcing rhyme by inverting word order** — also breaks natural stress (§1.3).
- **Cramming too many syllables to fit the line** — Suno will rush; cut a word.
- **Stretching too few syllables across the line** — Suno will add melismas; add a syllable.
- **Pop verse iambic but chorus suddenly trochaic without intent** — feels jolted; either commit to the contrast or unify.
- **Long held note on a closed-vowel word** — vowel collapses; cross-audit (§1.4 ceiling + §3 #7).
- **Multi-syllable word straddling a melodic phrase break** — natural stress gets cut; move the word to a single-phrase position.
