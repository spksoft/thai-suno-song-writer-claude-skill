# Thai Tone Craft — Tonal-Melodic Alignment, เพี้ยน Risk, Rhyme × Tone Matrix

This file is the single source for everything that determines whether Suno will sing a Thai lyric correctly. It merges three concerns that used to live in separate files:

1. **Tonal-melodic alignment theory** — how Thai tones interact with melody (what makes "เพี้ยน" happen)
2. **The 10 เพี้ยน risk patterns** — the audit catalog Step 7-A consults
3. **The Rhyme × Tone risk matrix** — how a chosen end-rhyme family interacts with the chosen tone at the rhyme position (Step 7-A2)

Per the skill's "warn, don't auto-fix" rule: this file's audits flag risks and propose fixes; they never silently rewrite the user's lyric. The user always chooses.

## Contents

1. The five Thai phonetic tones
2. The tonal-melodic mapping rule
3. Where mismatches are tolerated vs. forbidden
4. The 10 เพี้ยน risk patterns (Step 7-A catalog)
5. Fix techniques, ranked
6. Suno's specific weaknesses for Thai (set expectations)
7. Rhyme × Tone risk matrix (Step 7-A2)
8. Commit-to-the-fall — the survival strategy for falling-tone hooks
9. The เพี้ยน audit (how Step 7-A operates)
10. Quick scan algorithm

---

## 1. The five Thai phonetic tones

| Tone | Thai name | Contour | Example |
|---|---|---|---|
| MID | สามัญ | level [33] | คา /khaa/ |
| LOW | เอก | low-falling [21] | ข่า /khàa/ |
| FALLING | โท | high-falling [42] | ค่า /khâa/ |
| HIGH | ตรี | high-level/rising [45] | ค้า /kháa/ |
| RISING | จัตวา | low-rising [24] | ขา /khǎa/ |

**Important:** the spoken phonetic tone is NOT always what the written tone-mark suggests. Initial consonant class (อักษรกลาง/สูง/ต่ำ) and live/dead syllable (คำเป็น/คำตาย) determine the spoken tone. When in doubt, say the word out loud — that's what Suno will try to imitate.

### Decomposing contour tones for melodic mapping

- **RISING (จัตวา)** acts like HIGH for mapping — its endpoint is high.
- **FALLING (โท)** acts like LOW for mapping — its endpoint is low.
- Two FALLINGs in a row: the second's offset governs.

---

## 2. The tonal-melodic mapping rule

When two adjacent syllables are sung on two notes, the melodic *direction* between those notes should match the spoken *tonal direction* between the syllables:

- 2nd syllable's tone is HIGHER than the 1st → melody should ascend or stay level
- 2nd syllable's tone is LOWER than the 1st → melody should descend or stay level
- Opposite-direction mismatches produce เพี้ยน

Empirical studies of Thai pop (Ketkaew & Pittayaporn 2014; Saurman 1999) show ~60–80% of pop melodies follow this rule; classical/lukthung is closer to 90%. Modern pop tolerates more mismatches than older pop, but **content words — especially hook keywords — still demand alignment**.

---

## 3. Where mismatches are tolerated vs. forbidden

| Forgiving zone | Strict zone |
|---|---|
| Unstressed grammatical particles (ก็, นะ, แล้ว) | Hook title-line words |
| Quick passing notes / grace notes | Downbeats (beat 1 of any bar) |
| Linking syllables in compound words | First syllable of a phrase |
| Rap/very fast sections | Long held notes |
| | Title nouns, emotional-key verbs |

For Suno specifically: you can't control the melody Suno generates, but you CAN avoid building lyrics whose tonal patterns force the model toward mismatches. The 10 patterns in §4 capture the failure modes.

---

## 4. The 10 เพี้ยน risk patterns

Each pattern is the catalog Step 7-A runs against every line. Flag any matches in the output's "⚠️ เพี้ยน Risk Flags" block, formatted as:

```
- บรรทัด "..." [issue], แนะนำเปลี่ยนเป็น "..."
```

If no flags found, output: `ไม่พบจุดเสี่ยงสำคัญ`.

### 1. Line length > 12 syllables

Count Thai syllables (≈ count of "characters that make sound" — tone marks don't count). Long lines compress; tones flatten.

**Fix:** split into two lines.

```
- บรรทัด "เธอทำให้ฉันรู้สึกอบอุ่นใจในทุกๆ วันที่เราอยู่ด้วยกัน" (15 พยางค์) เกินยาว เสี่ยง tone collapse — แนะนำแยกเป็น 2 บรรทัด: "เธอทำให้ฉันรู้สึกอบอุ่นใจ" / "ในทุกๆ วันที่เราอยู่ด้วยกัน"
```

### 2. Pali/Sanskrit compounds (3+ syllables, formal Thai)

Words like สรรเสริญ, อัจฉริยภาพ, สิริมงคล, บุญญาธิการ, สุนทรียภาพ, ปฏิสัมพันธ์, อนันตกาล, ไร้กาลเวลา.

**Risk:** rare in Suno's training; often wrong vowel length or wrong tone.

**Fix options** (in order of preference):
1. Substitute everyday Thai equivalent (`ไร้กาลเวลา` → `ไม่มีวันจาง`)
2. Move to slow-ballad section where long notes give Suno time
3. Apply phonetic respelling (see `thai-phonetic-respelling.md` §3) — pair with `(building intensity)` directive or `[Belted]` to give Suno extra context

### 3. Initial consonant clusters on stressed beats

Watch for: ปร-, ปล-, ปฏ-, กร-, กล-, กว-, คร-, คล-, คว-, ตร-, ตล-, พร-, พล-, สร-.

**Risk on stressed beats:** Suno often loses the cluster (ปลา → ปา) or merges incorrectly.

**Fix options:**
1. Phonetic respelling via พินทุ (ปลฺา / ปฺลา) — see `thai-phonetic-respelling.md` §1
2. Rewrite with non-cluster word (`ปลายทาง` → `จุดหมาย` / `ที่หมาย`)
3. Move the cluster off the downbeat

```
- บรรทัด "ปลายทางที่ฉันฝัน": initial cluster ปล- บน accent — เสี่ยงเป็น "ปายทาง" — แนะนำ "ที่หมายที่ฉันฝัน" หรือใช้ respelling "ปฺลายทาง"
```

### 4. Mai-tho falling tone (โท) on long held notes

Words ending in falling tone: เก่า, ก็, ค่อย, น่า, ไม่, คล้าย, น้อง, เข่า, แล้ว.

**Risk:** falling tone collapses to mid (flat) on sustained notes.

**Fix options** (this is the most common Thai-pop issue):
1. Put the falling-tone word on short notes (eighth or shorter)
2. **Commit to the fall** — embrace the descent (see §8). Pair with a vocal directive like `[Belted]` to give the dynamic.
3. Use Replace Section in Song Editor after take 1 to fix specific occurrences

### 5. Real names (people, places)

People: สมชาย, นริน, สิริ, ภัทร, ปวีณา. Places: เชียงใหม่, ขอนแก่น, สุราษฎร์, นครราชสีมา.

**Risk:** no reliable training data — silent syllables, wrong tones, wrong vowel length.

**Fix:** phonetic respelling via hyphens + ห-hint (`สิริ` → `สิ-หฺริ`). See `thai-phonetic-respelling.md` §2.

### 6. Numbers

Any digits (2026, 5G, 100%) — read inconsistently as English numerals or Thai.

**Fix:** write the number out as Thai words. See `thai-phonetic-respelling.md` §4.
- 2026 → `สอง-พัน-ยี่-สิบ-หก`
- 100% → `ร้อย-เปอร์-เซ็นต์`

### 7. English acronyms

AI, JR, ATM, IG — read as letters or word inconsistently.

**Fix:** force the version you want. See `thai-phonetic-respelling.md` §4.
- AI → `เอ-ไอ` (letters) or `เอไอ` (word)
- IG → `ไอ-จี`

### 8. Same-line Thai+English code-switching

Lines like "รักเธอ forever" or "Bangkok ในคืนนี้" cause mid-line drift.

**Fix options:**
1. Split into two lines (recommended)
2. Move English to `(parenthetical echo)` after the Thai lead line
3. Last resort: phonetic respell the English in Thai script (see `thai-phonetic-respelling.md` §5)

```
- บรรทัด "Bangkok ในคืนนี้มันเหงาเกินไป": same-line code-switching เสี่ยง drift — แนะนำแยกเป็น "ในคืนนี้กรุงเทพมันเหงาเกินไป" + (echo "Bangkok tonight")
```

### 9. Short vowels on long held notes

Vowels: อิ, อะ, อุ, อึ collapse into nothing when held longer than a half note.

**Fix:** for held-note positions, prefer long vowels: อา, อี, อู, ออ, แอ, โอ, or complex เอีย, เอือ.

**Detection rule:** if a line's last syllable (often held in Thai phrasing) ends in อิ, อะ, อุ — that's a flag.

### 10. Conflicting vocabulary registers

Mixing very formal Thai (ราชาศัพท์, classical) with very colloquial Thai in the same section.

```
- บรรทัด "องค์เจ้าของหัวใจ ฉันโคตรรักเธอ": register mismatch (formal องค์เจ้า + slang โคตร) — แนะนำเลือกอย่างใดอย่างหนึ่ง
```

This is a stylistic flag, not a phonetic one — but Suno may render confidently in either register and clash with the other.

---

## 5. Fix techniques, ranked

When you spot a likely เพี้ยน in a lyric, options in order of quality:

1. **Substitute the word** — find a near-synonym whose tone or phonetic profile is more reliable.
2. **Reorder the phrase** — put the constrained word on a less-stressed position.
3. **Adjust the lyric line entirely** — rewrite to avoid the conflict.
4. **Apply phonetic respelling** — keeps the word, gives Suno extra cues (see `thai-phonetic-respelling.md`).
5. **Add a vocal directive** — `[Belted]`, `[Staccato]`, `(building intensity)` — gives the performance enough character to absorb the rendering quirk.
6. **Move to an unstressed position** — last resort, often changes meaning.
7. **Accept the mismatch** — for unstressed grammatical particles only.

For Suno specifically, options (1)–(5) are the only ones available during composition. Once Suno has generated, Replace Section (Song Editor) can fix #6 — see `suno-platform.md` §"Persona / Voices / Extend / Song Editor — Thai workflow".

---

## 6. Suno's specific weaknesses for Thai

This is the section the skill quotes when surfacing the "Suno-Thai expectation" framing in Step 8.

**Empirical pattern observations** (from Thai user reports — Pantip, VeryCatSound, community discussion 2024–2026):

- **Thai is in Suno's "lesser-represented" tier.** Suno's documented "best languages" list (Sept 2025–2026): English, Spanish, Portuguese, French, Japanese, Korean, Mandarin. Thai is not on that list. Take 1 will often have at least one เพี้ยน line, drifted accent, or flattened tone.
- **v4.5+all renders Thai noticeably worse than English.** v5 and v5.5 are improving but still imperfect.
- **Female voices tend to render Thai vowels slightly more clearly** than male voices in current models — minor effect, but worth knowing.
- **Slow ballads (60–80 BPM) almost always handle tones better** than fast pop (>120 BPM). The faster the cadence, the more tones flatten.
- **The first take of any Thai line is the worst.** The second pass through a chorus often improves because the model has settled into the phonology of the song.
- **Pasting the full chorus 3 times in the lyrics field** (rather than relying on `[Chorus]` reference) measurably improves consistency.
- **Persona/Voices lock pronunciation across takes.** For series/EP work in Thai, this is the single most impactful technique — see `suno-platform.md`.

**Expectation framing for users:** Suno is not yet ready to render Thai perfectly on Take 1. Plan for 2–3 regenerations, plus targeted Replace Section fixes for specific bad lines. This is normal and expected. The skill flags risks before generation precisely so the user knows where Take 1 will likely fail.

---

## 7. Rhyme × Tone risk matrix

This matrix is the heart of Step 7-A2. It maps **the chorus end-rhyme family × the spoken tone of the end-word × held-note duration** to a risk level. Use it to verify that a chosen rhyme strategy is Suno-stable before composing the rest of the chorus.

### How to read the matrix

- **Rows**: the 9 most-used Thai pop rhyme families (from `thai-rhyme-craft.md` §5)
- **Columns**: the spoken tone of the end-word (mid, low, falling, high, rising)
- **Cells**: a risk symbol + survival strategy

| Family | MID (สามัญ) | LOW (เอก) | FALLING (โท) | HIGH (ตรี) | RISING (จัตวา) |
|---|---|---|---|---|---|
| **ใจ-family** /ai/ | SAFE | SAFE | RISK¹ | SAFE | SAFE |
| **เธอ-family** /ɤː/ | SAFE | SAFE | RISK¹ | SAFE | SAFE |
| **รัก-family** /ak/ | SAFE | SAFE | RISK¹ | SAFE | RISK² |
| **ฝัน-family** /an/ | SAFE | SAFE | RISK¹ | SAFE | SAFE |
| **คืน-family** /ɯːn/ | SAFE | CAUTION³ | RISK¹ | SAFE | SAFE |
| **มา-family** /aː/ | SAFE | SAFE | RISK¹ | SAFE | SAFE |
| **ดาว-family** /aw/ | SAFE | SAFE | RISK¹ | SAFE | CAUTION³ |
| **เดิน-family** /ɤːn/ | SAFE | CAUTION³ | RISK¹ | SAFE | SAFE |
| **หวัง-family** /aŋ/ | SAFE | SAFE | RISK¹ | SAFE | SAFE |

### Risk codes

**RISK¹ — Falling tone (โท) on a sustained held note**
Falling tone often flattens to mid on sustained notes. **Survival strategy:** *commit to the fall* — design the melody to descend on the held syllable rather than fight the tone. Pair with a vocal directive like `[Belted]` or `(building intensity)` to give the descent dynamic shape. See §8 for the precedent (คุกเข่า / เพื่อนเล่น).

**RISK² — Rising tone (จัตวา) on a stop-final syllable**
Rising tone needs vocal time to rise; stop consonants (กก/กด/กบ) cut the syllable short and can mask the rise. Suno hears the start of the rise but not the peak. **Survival strategy:** use this combination only on short notes (eighth or shorter) or in the verse, not the chorus hook.

**CAUTION³ — Low tone (เอก) on a long-vowel family**
Low tone on long vowels (/ɯː/, /ɤː/, /aw/) can drift toward mid because the long vowel gives Suno time to "correct" toward the model's neutral pitch. **Survival strategy:** reserve for bridge or pre-chorus end-words, not the chorus hook. Or add an explicit ห-prefix in respelling to lock the low tone.

### How Step 7-A2 uses the matrix

```
Detect the chorus end-rhyme word.
Look up (family) × (tone) in the matrix.
Emit a flag when cell = RISK¹ / RISK² / CAUTION³:

  - "ฮุก '__' บนแฟมิลี __/tone __: per Rhyme×Tone matrix risk¹ —
     แนะนำ commit-to-the-fall (ดู §8) หรือ pick mid-tone partner
     จาก family เดียวกัน (suggest: __, __, __)"
```

When the cell is SAFE, the audit returns silently (the chorus is on safe ground).

### Cross-reference

This matrix is **referenced — not duplicated — by** `thai-rhyme-craft.md` (the rhyme-craft file points readers here for tone-safety analysis). Preserving the "avoid duplicating tables" anti-pattern correction: don't duplicate, cross-link.

---

## 8. Commit-to-the-fall — survival strategy for falling-tone hooks

Falling tones (โท) at the end of hook words are flagged as RISK¹ in the matrix above. But this combination is so common in Thai pop hooks (คุกเข่า, เพื่อนเล่น, ก้าวต่อไป, ลงใจ) that we need a robust survival strategy, not just a warning.

**The strategy: commit to the fall.**

Instead of trying to hold a falling tone steady (which Suno flattens), design the song so the melody itself descends on the held syllable. The vocalist drops pitch, the band swells around the held note, and the listener hears the descent as part of the emotional design — not as a Suno failure.

### Documented precedents (from `thai-hit-songs.md`)

- **คุกเข่า — Cocktail (2011).** "เข่า" is FALLING tone on sustained downbeat. The song commits to the fall: vocal melody drops on "เข่า", band swells. Suno reproductions of this kind of hook need `[Belted]` plus acceptance that Take 1 may flatten the syllable — and that's part of the design.
- **เพื่อนเล่น — Tilly Birds (2021).** "เพื่อน" is FALLING tone, repeated twice. The melody descends sharply on both occurrences. Same principle.

### How to apply commit-to-the-fall in the prompt

1. **In Step 3 (compose):** acknowledge that the hook word's tone is falling and let it shape the melodic intent (descending phrase on the held syllable).
2. **In Step 3.5 (directives):** add `[Belted]` bracket cue at the chorus, OR `(building intensity)` inline cue on the line containing the hook. These give Suno enough dynamic shape to absorb the falling syllable as a deliberate descent rather than a flat error.
3. **In Step 4 (Styles):** include a Vocal Direction tag that signals dramatic descent — e.g., `dramatic vocal descent on chorus hook`, `emotional belted male vocals with descending phrasing`.
4. **In Step 7-A2 (audit):** when the matrix flags RISK¹, output: "Hook on falling tone — apply commit-to-the-fall (ดู §8 of thai-tone-craft.md)" rather than "redraft the chorus." The flag is informational; the strategy is documented; the user can opt in or substitute.

### When NOT to commit-to-the-fall

- The song is upbeat (>110 BPM) — fast tempos don't have room for the descent dynamic. Substitute a non-falling-tone hook instead.
- The hook word is short and pickup-positioned — there's no held note to fall from. Substitute.
- The user wants the hook to sound triumphant or rising — commit-to-the-fall is melancholic by design. Substitute.

---

## 9. The เพี้ยน audit — how Step 7-A operates

The audit Step 7-A runs against every line. For each line, scan the patterns in §4 in this order:

1. **First pass — count syllables per line.** Flag any >12.
2. **Second pass — scan for Pali/Sanskrit compounds.** Use the list in #2 as anchor.
3. **Third pass — scan for clusters at start of lines or after `[Section]` headers** (stressed positions).
4. **Fourth pass — scan end-of-line words** for falling tones and short vowels.
5. **Fifth pass — scan for proper names, numbers, English acronyms, code-switching.**
6. **Sixth pass (NEW) — run §7's Rhyme × Tone matrix on every chorus end-word.** This is Step 7-A2.
7. **Aggregate** — produce one flag per genuine risk. Don't over-flag; if a line has 3 risks, list only the most severe.

### What a clean flag block looks like

```
### ⚠️ เพี้ยน Risk Flags

- บรรทัด "ปลายทางที่ฉันฝัน": cluster ปล- บน accent — อาจเป็น "ปายทาง" — แนะนำเปลี่ยนเป็น "ที่หมายที่ฉันฝัน" หรือ respelling "ปฺลายทาง"
- บรรทัด "ไร้กาลเวลา": Pali compound 4 พยางค์ — แนะนำเปลี่ยนเป็น "ไม่มีวันจาง"
- ฮุก "เข่า" — falling tone บนโน้ตยาว — Rhyme×Tone matrix RISK¹ — แนะนำ commit-to-the-fall (เพิ่ม [Belted] บน [Chorus]) หรือ substitute hook word ที่ tone กลาง
```

### Severity mapping

| Flag count | Summary |
|---|---|
| 0 | `clean` |
| 1–2 | `minor` |
| 3–5 | `rework_recommended` |
| 6+ | `redraft_needed` |

This mapping mirrors the rhyme audit in `thai-rhyme-craft.md` §7. Each audit reports independently — never aggregate counts across audits.

---

## 10. Quick scan algorithm (for code/audit use)

When the skill needs to scan lyrics programmatically (for tooling or self-check), use this algorithm:

```
for each line in lyrics:
    syllable_count = count_thai_syllables(line)
    if syllable_count > 12: flag(line, "line_too_long")

    for each word in line:
        if is_pali_compound(word): flag(line, "pali_compound", word)
        if has_initial_cluster(word) and is_stressed_position(word, line):
            flag(line, "cluster_on_stress", word)
        if has_falling_tone_end(word) and is_held_note_position(word, line):
            flag(line, "falling_tone_on_held_note", word)
        if is_proper_name(word): flag(line, "proper_name", word)
        if has_digits(word): flag(line, "number_literal", word)
        if has_english_acronym(word): flag(line, "english_acronym", word)
        if has_short_vowel_end(word) and is_held_note_position(word, line):
            flag(line, "short_vowel_held", word)

    if has_thai_and_english_mix(line):
        flag(line, "same_line_code_switch")
    if has_register_conflict(line):
        flag(line, "register_mismatch")

# Step 7-A2: Rhyme × Tone matrix
for each chorus_end_word:
    family = detect_rhyme_family(word)
    tone = detect_spoken_tone(word)
    risk = MATRIX[family][tone]
    if risk in (RISK1, RISK2, CAUTION3):
        flag(chorus, "rhyme_tone_matrix", risk, suggest_alternatives(family, tone))
```

This is documentation of the audit logic, not enforcement — the skill operates by reading and applying these patterns in prose, not running code.

---

## Cross-references

- **Thai rhyme families and schemes** — `thai-rhyme-craft.md` §5. The matrix in §7 above references the 9 families documented there.
- **Phonetic respelling for flagged words** — `thai-phonetic-respelling.md`. Many fixes in §4 point here for the actual respelling technique.
- **Suno platform mechanics (Replace Section, Persona, etc.)** — `suno-platform.md`. The "fix techniques #5–6" in §5 above use platform features documented there.
- **Hit-song precedents for falling-tone hooks** — `thai-hit-songs.md`. The commit-to-the-fall strategy in §8 cites specific case studies (Cocktail, Tilly Birds).
