# Tonal-Melodic Alignment for Thai Lyrics (กฎวรรณยุกต์-ทำนอง)

This document explains the single hardest constraint when writing Thai lyrics for any sung melody: **lexical tones must roughly match melodic contour, or words sound like different words**. This is what Thai songwriters call "เพี้ยน" or "ข่มขืนวรรณยุกต์."

For Suno specifically, the model itself decides the melody — so the lyric writer can't fully control alignment. But certain patterns make เพี้ยน much more likely, and a good prompt-writer can avoid them. This skill flags risks rather than enforcing 100% alignment (per the user's preference: warn, don't auto-fix).

## The five Thai phonetic tones

| Tone | Thai name | Contour | Example |
|---|---|---|---|
| MID | สามัญ | level [33] | คา /khaː/ |
| LOW | เอก | low-falling [21] | ข่า /khàː/ |
| FALLING | โท | high-falling [42] | ค่า /khâː/ |
| HIGH | ตรี | high-level/rising [45] | ค้า /kháː/ |
| RISING | จัตวา | low-rising [24] | ขา /khǎː/ |

**Important:** the spoken phonetic tone is NOT always what the written tone-mark suggests. Initial consonant class (อักษรกลาง/สูง/ต่ำ) and "live/dead" syllable (คำเป็น/คำตาย) determine the spoken tone. When in doubt, say the word out loud — that's what Suno will try to imitate.

## The mapping rule

When two adjacent syllables are sung on two notes, the melodic *direction* between those notes should match the spoken *tonal direction* between the two syllables:

- If the second syllable's tone is HIGHER than the first → melody should ascend or stay level
- If the second syllable's tone is LOWER than the first → melody should descend or stay level
- "Opposite-direction" mismatches produce เพี้ยน

Empirical studies of Thai pop (Ketkaew & Pittayaporn 2014, Saurman 1999) show ~60–80% of pop melodies follow this rule; classical/luk thung is closer to 90%. Modern pop tolerates more mismatches than older pop, but content words (especially hook keywords) still demand alignment.

### Decomposing contour tones

- RISING (จัตวา) acts like HIGH for mapping — its endpoint is high.
- FALLING (โท) acts like LOW — its endpoint is low.
- Two FALLINGs in a row: the second's offset governs.

## Where mismatches are tolerated vs. forbidden

| Forgiving zone | Strict zone |
|---|---|
| Unstressed grammatical particles (ก็, นะ, แล้ว) | Hook title-line words |
| Quick passing notes / grace notes | Downbeats (beat 1 of any bar) |
| Linking syllables in compound words | First syllable of a phrase |
| Rap/very fast sections | Long held notes |
| | Title nouns, emotional-key verbs |

## Patterns that make Suno generate เพี้ยน most often

These are the patterns the skill should flag during Step 7 of the workflow. Each one is reproducible — they don't always fail, but they're the high-failure-rate cases.

### 1. Lines longer than 12 syllables
Suno compresses long Thai lines into faster cadence; tones flatten.
**Fix:** split into two lines.

### 2. Pali/Sanskrit compounds (3+ syllables)
Words like สรรเสริญ (san-sŏen), อัจฉริยภาพ (àt-cha-rí-yá-phâap), สิริมงคล (sì-rí-mong-khon) are rare in Suno's training data and often render with wrong vowel length or wrong tone.
**Fix:** move to slow ballad section (long notes give Suno time), or substitute everyday Thai equivalent.

### 3. Initial consonant clusters on stressed beats
ปร-, กล-, คว-, ปฏ-, ตร-, ปล- at the start of a syllable on a downbeat often lose the cluster (ปลา → ปา) or merge incorrectly.
**Fix:** insert hyphen between cluster and vowel ("ปลฺา" or "ปฺลา"), or rewrite with a non-cluster word.

### 4. Mai-tho falling tone (โท) on a long held note
Words ending in falling tone — เก่า, ก็, ค่อย, น่า, ไม่ — often become flat (mid tone) when sustained, because Suno doesn't naturally extend a falling pitch.
**Fix:** put these words on short notes (eighth notes or shorter), or accept the flatness and move on.

### 5. Real names of people or places
Suno has no reliable training data for Thai personal/place names. Common failure modes: silent syllables, wrong tones, wrong vowel length.
**Fix:** write phonetically in Thai script ("สิ-หฺริ" for สิริ), keep the same spelling everywhere in the lyric, and accept that it may need 2–3 regenerations.

### 6. Numbers
Suno may read 2026 as "two thousand twenty-six," "twenty twenty-six," "two-zero-two-six," or even silently fail.
**Fix:** write the number out as Thai words: "สองพันยี่สิบหก" or "สองศูนย์สองหก."

### 7. English acronyms
"AI" might be sung as "ai" (one syllable) or "เอ-ไอ" (two letters) inconsistently.
**Fix:** force the version you want with hyphens (เอ-ไอ) or as a Thai word (เอไอ).

### 8. Same-line Thai+English code-switching
Lines like "รักเธอ forever" cause mid-line drift — Suno may apply English phonology to the Thai or vice versa.
**Fix:** put the English on its own line, or in a `(parenthetical echo)` after the Thai line.

### 9. Short vowels on long held notes
Vowels อิ, อะ, อุ collapse into nothing when held for more than a half note.
**Fix:** when you have a held-note position, choose words with long vowels: อา, อี, อู, ออ, แอ.

### 10. End-of-phrase tone restrictions (legacy from กลอนแปด)
Traditional Thai poetry restricts which final tone is allowed in each วรรค (phrase). Songs that "feel hanging" often violate this. While not a เพี้ยน risk, it's a "feels right" signal:
- วรรครับ should not end on สามัญ (mid) or ตรี (high)
- วรรคส่ง should not end on เอก (low), โท (falling), or จัตวา (rising)

This is a softer guideline — break it freely if the meaning is right.

## Fix techniques (in order of preference)

When you spot a likely เพี้ยน problem in a lyric line, the fix options ranked by quality:

1. **Substitute the word** — find a near-synonym whose tone fits.
2. **Reorder the phrase** — put the constrained word on a less-constrained position.
3. **Adjust the lyric line entirely** — rewrite to avoid the conflict.
4. **Move the word to an unstressed position** (off the downbeat).
5. **Accept the mismatch** — for unstressed grammatical particles only.

For Suno, fix techniques (1)–(3) are the only ones available, since the user can't directly control note placement. Once Suno has generated, fix #4 is via Replace Section in the Song Editor.

## Example: a fix in action

**Original line (problematic):**
`อยากบอกเธอว่า "รักเธอจัง"`
- 8 syllables — fine
- "รัก" (HIGH/ตรี) followed by "เธอ" (MID/สามัญ) — should descend
- If Suno's melody happens to ascend on this transition, "รักเธอ" sounds like "ระเทอ" or similar

**Fix option A — reorder:**
`อยากบอกว่า "จังเลย รักเธอ"` — puts "รัก" on a less-stressed position

**Fix option B — substitute:**
`อยากบอกเธอว่า "ฉันรักเธอ"` — "ฉันรัก" gives the model two syllables to settle on the high tone

**Fix option C — accept with shorter notes:**
Keep the original but flag it as a candidate for Replace Section if take 1 fails.

## A note on Suno's specific weaknesses for Thai

From Thai user reports (Pantip, VeryCatSound):

- v4.5+all renders Thai noticeably worse than English. v5 and v5.5 are improving but still imperfect.
- Female voices tend to render Thai vowels slightly more clearly than male voices in current models.
- Slow ballads (60–80 BPM) almost always handle tones better than fast pop (>120 BPM).
- The first take of any Thai line is the worst; the second pass through a chorus often improves because the model has settled into the phonology.
- Pasting the same chorus 3 times in the lyrics field (rather than relying on `[Chorus]` reference) measurably improves consistency.
