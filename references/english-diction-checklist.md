# English Pronunciation Risk Checklist

The English parallel to `pian-risk-checklist.md`. Per the skill's "warn, don't auto-fix" rule: when the user supplies their own lyrics, flag risk and suggest a rewrite — do not silently rewrite.

**Scope:** this file covers **pronunciation/rendering risk only** (whether Suno will mispronounce a word). For rhyme and form issues — scheme detection, cliché pairs, hook placement, density — see `rhyme-craft-en.md`. Step 7-B runs this checklist; Step 7-D runs the rhyme audit. The two stay visually separate in the final output.

## How to use this checklist

For each line of lyrics, scan for these patterns. Flag any matches in the final output's "Pronunciation Risk Flags (English)" section. Format each flag as:

```
- Line "…": [issue], suggest rewriting as "…"
```

If no flags found, output: `No major risks detected`

## The 10 risk patterns

### 1. Homographs (same spelling, multiple pronunciations)

Words Suno guesses pronunciation for, often wrong. Re-rolling rarely fixes — the lyric must change.

**Starter list:**
- *read* — past vs present tense (red vs reed)
- *live* — verb vs adjective (liv vs lyv)
- *lead* — verb vs metal (leed vs led)
- *bass* — fish vs music (bæs vs beɪs)
- *tear* — eye-water vs rip (tir vs tehr)
- *wind* — air vs coil (wind vs wynd)
- *wound* — injury vs past-of-wind (woond vs wownd)
- *close* — verb vs adjective (kloze vs klohs)
- *refuse* — verb vs noun (rih-FYOOZ vs REH-fyoos)
- *present* — gift vs introduce (PREZ-ent vs prih-ZENT)
- *object* — thing vs disagree (OB-jekt vs ob-JEKT)
- *conduct* — verb vs noun (kun-DUKT vs KON-dukt)
- *desert* — abandon vs sand (dih-ZURT vs DEZ-urt)
- *produce* — verb vs noun (pro-DOOS vs PROD-oos)
- *record* — verb vs noun (rih-KORD vs REK-ord)
- *contract* — agree vs shrink (KON-trakt vs kun-TRAKT)

**Fix:** disambiguate with context, swap for a synonym, or use the unambiguous form (past tense "I read" → "I've read" or "I saw").

**Example flag:**
```
- Line "I tear the page in two": "tear" is homograph (rip vs eye-water); suggest rewriting as "I rip the page in two" to remove ambiguity
```

### 2. Silent letters / irregular spelling

Words whose spelling doesn't match their pronunciation. Suno reads phonetically and gets it wrong.

**Examples:** *knight, queue, colonel, choir, Wednesday, gnome, pneumonia, mortgage, salmon, debris, rendezvous, faux.*

**Fix:** phonetic respell or pick a synonym.

**Example flag:**
```
- Line "I'll be your knight tonight": "knight" silent-K risk — sometimes rendered "kuh-night"; suggest "I'll be your warrior tonight" or write phonetically as "nite"
```

### 3. Loanwords (non-English origin)

Words borrowed from other languages with non-English phonology.

**Examples:** *genre, fiancé, café, façade, ballet, bouquet, déjà vu, rendezvous, naïve, résumé, croissant.*

**Fix:** keep if intentional (Suno often handles them OK); flag if on a stressed downbeat or held note where misrendering would be noticeable.

### 4. Acronyms

`AI`, `JR`, `ATM`, `DJ`, `LA`, `NYC`, `OK`.

**Risk:** read as a single fused word or as letters inconsistently.

**Fix:** force the version you want:
- `AI` (letters) → spell `A I` with space, or write `A.I.`
- `AI` (word "ay") → write `aye` or `eye`
- `LA` (letters) → `L A`
- `OK` → write `okay`

**Example flag:**
```
- Line "Lost in the AI dream": "AI" may render as "eye" or "ay-eye" inconsistently — suggest "A I" with space, or rewrite as "Lost in the cyber dream"
```

### 5. Numbers and dates

Any digits.

**Risk:** `2024` may be read as "two thousand twenty-four", "twenty twenty-four", "two-zero-two-four", or silently skipped.

**Fix:** spell out as words.
- `2026` → `twenty twenty-six` or `two thousand twenty-six`
- `100%` → `one hundred percent` or `a hundred percent`
- `5G` → `five G` (space) or `fifth gen`
- `911` → `nine one one`

### 6. Lines >15 syllables (approximate via word count >14)

Suno rushes long lines and consonants collapse. Sweet spot: 6–12 syllables; verses 8–10, choruses 10–12.

**Fix:** split into two lines.

**Example flag:**
```
- Line "I never thought I'd find myself standing in the rain just waiting for you to come home tonight" (24 syllables): too long for one breath; suggest split: "I never thought I'd find myself standing in the rain" / "Just waiting for you to come home tonight"
```

### 7. Closed vowels on long held notes (line-end)

Vowels /ʌ/ (uh), /ɪ/ (ih), /ɛ/ (eh) collapse into nothing when held more than a half note. End-of-line words often hold; flag end-words ending in these short vowel sounds.

**At-risk endings:** *bus, fun, but, sit, fit, hit, met, get, let* — when at the end of a chorus line.

**Fix:** swap for an open-vowel word — /ɑ/ (ah), /i/ (ee), /u/ (oo), /oʊ/ (oh), /eɪ/ (ay).

**Example flag:**
```
- Line "I just want to have some fun": "fun" /ʌ/ at line-end may collapse on a sustained note; suggest end with "all night long" or "by the fire" (open vowels)
```

### 8. Sibilant clusters on the highest sustained note

Words with /s/, /ʃ/ (sh), /z/, /tʃ/ (ch) on the climax note hiss and distort.

**At-risk words:** *kisses, blessings, shoulders, chases, splashes, finishes, whispers.*

**Fix:** rephrase so the climax note lands on an open vowel; move the sibilant word off the peak.

**Example flag:**
```
- Line "Hear all my whispers": "whispers" is sibilant-heavy and likely lands on the chorus high note; suggest "Hear me callin' out" or move "whispers" to a verse line
```

### 9. Function words on inferred downbeats

The/of/a/an/to/and/but/or/so as the first word of a chorus line or pre-chorus line tends to land on the downbeat — but they're unstressed in natural English speech, so the music's emphasis hits a syllable the speaker would swallow.

**Fix:** start the line with a content word, or invert the phrase.

**Example flag:**
```
- Line "The night is always darker before the dawn" — chorus line 1 starts with "The" (function word), which may land on downbeat against natural English stress; suggest "Night is darker still before the dawn" or "Even darkest nights bring on the dawn"
```

### 10. Multi-syllable words with wrong dictionary stress

Pop lyrics sometimes force wrong stress for rhyme. Examples: *to-MOR-row* sung as *TO-mor-row*; *gui-TAR* sung as *GUI-tar*; *com-PLETE* sung as *COM-plete*.

**Detection:** when a multi-syllable word lands at a strong position and the natural stress doesn't match.

**Fix:** swap for a synonym or restructure the line.

**Example flag:**
```
- Line "Play me a song on your guitar tonight": "guitar" stress is gui-TAR but the line meter may push GUI-tar; suggest "Play that old six-string tonight"
```

## Quick scan algorithm

For a complete lyric, scan in this order:

1. **First pass — homographs**: scan against the list in §1. Flag context-dependent uses.
2. **Second pass — silent-letter words**: scan against §2 list.
3. **Third pass — line length**: count words per line, flag any >14.
4. **Fourth pass — line-end vowels**: check last word of each line, flag closed-vowel endings on chorus/long-held positions.
5. **Fifth pass — acronyms, numbers, function-word line-starts** combined sweep.
6. **Sixth pass — sibilant clusters in chorus**: scan chorus lines for ≥2 sibilants in the title or hook word.
7. **Aggregate** — produce one flag per genuine risk. Stop at 6 flags (more is noise; if more exist, surface a meta-flag "Multiple risk patterns — consider redraft").

## When NOT to flag

- Common short function words on weak beats (totally fine — only flag on inferred downbeats).
- A homograph that's unambiguous in context (e.g., "she read the letter yesterday" — the past tense is clear from "yesterday").
- A loanword that the genre embraces (e.g., "déjà vu" in a moody indie track — likely intended).
- Numbers that are part of titles/known references where the model's training has them (e.g., "1999" Prince song, "Year 3000" — these are well-known).
- Sibilants in verse lines (only flag on chorus high-note positions).

## Severity → summary mapping (parallel to Thai เพี้ยน audit)

| Flag count | Summary |
|---|---|
| 0 | `No major risks detected` |
| 1–2 | `Minor risks — review and decide` |
| 3–5 | `Multiple risks — consider rewriting one section` |
| 6+ | `Many risks — recommend redraft` |

Counted independently from Thai เพี้ยน, English Rhyme, Thai Rhyme, and Bilingual mixing audits.

## Example clean flag block

```
### ⚠️ Pronunciation Risk Flags (English)

- Line "I can read your mind tonight": "read" homograph (past vs present); context implies present, but Suno may render past; suggest "I can see your mind tonight"
- Line "Just a 2AM thought": "2AM" — number + acronym; suggest "Just a two A M thought" or "Just a late-night thought"
- Line "Hear my whispers in the silence" — "whispers" sibilant-heavy on likely chorus high note; consider rephrasing
```

Or, if clean:

```
### ⚠️ Pronunciation Risk Flags (English)

No major risks detected — lyric uses unambiguous vocabulary, no homographs in stressed positions, no acronyms or digits, line lengths within 12-syllable target
```
