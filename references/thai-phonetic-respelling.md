# Thai Phonetic Respelling — Disambiguating Thai Script for Suno

> **NOT romanization.** All respelling stays IN THAI SCRIPT. Suno tokenizes Latin characters as English phonology — romanizing Thai destroys tonal-melodic alignment. This file documents how to respell problem syllables in Thai itself, using the script's own disambiguation devices: พินทุ (◌ฺ) under cluster members, hyphens between syllable boundaries, explicit consonant-class hints (ห-leading), and full-form spelling of numerals/acronyms.

> Loaded by Step 3.5-E of `SKILL.md` when one or more words have been flagged by the Step 7-A เพี้ยน audit. Not loaded by default; not used when no problem words exist.

## The cardinal rule

Thai script can carry pronunciation hints that the normative spelling elides. Use these hints **only when both** are true:

1. The word is flagged in Step 7-A (เพี้ยน Risk) — meaning Suno is likely to mis-render it
2. The user prefers locking the pronunciation over re-rolling

When both conditions are met, propose the respelled form alongside the normative form. The user picks which one to paste into Suno. Never silently substitute — that violates the skill's "warn don't auto-fix" rule.

## Why this works (one paragraph for the curious)

Suno's text-to-speech pipeline runs Thai through a phonetic mapper before the audio model. The mapper handles common Thai words reliably but fails on:
- Consonant clusters (ปร, ปล, กร, ตร) that elide to single consonants
- Multi-syllable proper names with ambiguous syllable boundaries
- Pali/Sanskrit compounds whose written form omits the inner vowels
- Numerals, acronyms, and same-line English (parsed under English phonology)

The respelling techniques below give the mapper extra cues it cannot ignore: an explicit syllable break, a phonetic-only character that forces articulation, or a fully written-out form. All while staying in Thai script.

---

## 1. Consonant cluster disambiguation

Insert **พินทุ ◌ฺ** (U+0E3A) under the second member of an initial cluster to force the cluster's articulation. This is a real Thai diacritic with phonetic meaning — it survives Suno's tokenizer.

| Normative | Respelled | What Suno was getting wrong |
|---|---|---|
| ปลา /plaa/ | ปฺลา | Dropping ปล- to /paa/ ("ปาa") |
| ปลาย /plaai/ | ปฺลาย | Same — "ปาย-" |
| ครอบ /khrôop/ | คฺรอบ | Dropping คร- to /khôop/ |
| ครู /khruu/ | คฺรู | Same |
| สร้าง /sâaŋ/ | สฺร้าง | Suno hears /sâaŋ/ as /saaŋ/ — same word but with cluster lost |
| ตรง /troŋ/ | ตฺรง | Cluster ตร- drops to /toŋ/ |
| กลับ /klàp/ | กฺลับ | Cluster กล- drops to /kàp/ |
| ปฏิ /pà-tì/ | ปฺฏิ | Compound start, often elided on stressed beat |
| พลัง /pʰá-laŋ/ or /pʰlaŋ/ | พฺลัง | Forces single-syllable cluster reading |

**When to use:** the cluster falls on a stressed beat (downbeat or start of phrase) AND Step 7-A flagged the word.

**When NOT to use:** the cluster is in an unstressed mid-line position; the word is fast and short; the audit didn't flag it.

---

## 2. Proper-name syllable lock-in

Thai proper names (people, places) often surface in lyrics. Suno has minimal training data for them — silent syllables, wrong tones, wrong vowel length are common. Use hyphens to split syllables; add a high-class-consonant hint (ห-leading on low-class initials) to stabilize tone.

| Normative | Respelled | Why |
|---|---|---|
| สิริ | สิ-หฺริ | Hyphen + ห-hint stabilizes /si.rí/ vs /si.ree/ collisions |
| ภัทร | ภัด-ทระ | Force 2-syllable read instead of 1 |
| นริน | นะ-ริน | Force initial /na-/ vowel (otherwise sometimes read as /nrin/) |
| ปวีณา | ปะ-วี-นา | Three-syllable lock-in |
| เชียงใหม่ | เชียง-ใหฺม่ | Hyphen prevents Suno running them as one syllable |
| ขอนแก่น | ขอน-แก่น | Same |
| นครราชสีมา | นะ-คอน-ราด-สี-มา | Five-syllable lock-in for the long form |
| อุดรธานี | อุ-ดอน-ทา-นี | Four-syllable lock-in |

**When to use:** any proper name that hasn't already been verified to render cleanly. Test the normative form first; if take 1 sounds wrong, respell.

**When NOT to use:** very common short names (มะลิ, ทิม) that Suno handles fine; names that occur in unstressed pickup positions.

---

## 3. Pali / Sanskrit compound syllabification

Long formal compounds have **inherent vowels** that Thai writing omits — the reader is expected to know them. Suno's mapper doesn't always know them. Hyphenate at syllable boundaries, spelling out the inherent vowels with full short-vowel forms (◌ะ, ◌ิ, ◌ุ).

| Normative | Respelled | Notes |
|---|---|---|
| สรรเสริญ | สัน-เสฺริญ | Pinthu on cluster + syllable hyphen |
| อัจฉริยภาพ | อัด-ฉะ-ริ-ยะ-พาบ | Five-syllable Pali compound; without the hyphens Suno may drop syllables 3–4 |
| สิริมงคล | สิ-หฺริ-มง-คล | Mixes #2 (ห-hint) + #3 (compound) |
| ปฏิสัมพันธ์ | ปะ-ติ-สัม-พัน | Drop the silent karan (◌์); spell out the inherent /a/ |
| บุญญาธิการ | บุน-ยา-ทิ-กาน | Four-syllable lock-in |
| อนันตกาล | อะ-นัน-ตะ-กาน | Same; lock the /a/ in syllable 1 |
| สุนทรียภาพ | สุน-ทะ-รี-ยะ-พาบ | Five-syllable formal compound |
| ไร้กาลเวลา | ไร้-กาน-เว-ลา | Four-syllable formal compound |

**Honest tradeoff:** the respelled form is uglier on the page. For ballad sections with long held notes, the trade is worth it (Suno gets time to settle into the formal compound). For fast verse sections, often easier to substitute an everyday Thai equivalent (`ไร้กาลเวลา` → `ไม่มีวันจาง`).

The skill's recommendation: try the substitution FIRST. Use respelling only when the formal word is essential to the meaning.

---

## 4. Numbers and acronyms in Thai script

Write numbers and acronyms out **in Thai script with hyphenation** to force literal pronunciation. Latin digits and Latin letters trigger English phonology — that's why "2026" might be read as "two thousand twenty-six" in English-accented Thai.

| Source | Respelled |
|---|---|
| 2026 | สอง-พัน-ยี่-สิบ-หก |
| 100% | ร้อย-เปอร์-เซ็นต์ |
| 5G | ห้า-จี |
| AI | เอ-ไอ (letters) or เอไอ (word) |
| IG | ไอ-จี |
| BL | บี-แอล |
| ATM | เอ-ที-เอ็ม |
| BNK48 | บี-เอ็น-เค-สี่-สิบ-แปด |

**Pick the form deliberately:** "AI" as letters (เอ-ไอ) sounds like reading initials; "AI" as a word (เอไอ) sounds like a name. The skill should always know which the user wants and ask if unclear.

---

## 5. Same-line code-switch survival (last-resort fallback)

The skill's standing rule (per `bilingual-mixing.md` §2) is: never code-switch within a single sung line. Split to two lines, or move English to a `(parenthetical echo)` after the Thai line.

When that rule **cannot** be followed (user insists on keeping a specific English word inline for stylistic reasons), respelling in Thai script is the last-resort fallback that survives Suno's tokenizer better than Latin-mixed text.

| English word | Thai-script respelling | Notes |
|---|---|---|
| forever | ฟอ-เร-เวอร์ | Standard transliteration |
| Bangkok | แบง-คอก | Suno would otherwise read this as English |
| online | ออน-ไลน์ | Common in BL/series OST |
| forever young | ฟอ-เร-เวอร์ ยัง | |
| heartbreak | ฮาร์ท-เบรก | |
| Wifi | วาย-ฟาย | |
| Live | ไลฟ์ | |
| OK | โอ-เค | |

**The rule stays**: prefer splitting the line. Respelling is the fallback, not the recommended path. Document this clearly in Step 8 — show both the split version and the respelled version, let the user choose.

---

## 6. When NOT to respell

Respelling is a craft tool, not a default. Use it sparingly. Skip it in these cases:

- **Common short Thai words that already work** — ใจ, ไป, มา, รัก, รู้, ฝัน, คืน. The phonetic mapper handles these cleanly across all Suno model versions. Respelling them just adds noise.
- **Unstressed positions** — the cluster on the second syllable of a multi-syllable word doesn't usually fail; respelling it is overkill.
- **When the user is happy with re-rolling** — many users prefer normative spelling for visual aesthetics and treat 2–3 regenerations as the cost of doing business in Thai. Respelling fixes pronunciation at the cost of visual aesthetic. Respect the preference.
- **When the respelled version itself is uglier than the problem** — judgment call. If a 5-syllable Pali compound becomes 8 hyphenated parts that read like a phonetics homework, it may be better to substitute the word.
- **When the word has already rendered cleanly in a prior take** — Suno's behavior is take-dependent. If Take 2 got "ปลายทาง" right, you don't need to respell for Take 3.

The default mental model: respell ~1–3 words per song, the ones flagged in 7-A. If you're respelling 6+ words, you're probably over-applying the technique.

---

## 7. Output contract: how respelling appears in Step 8

When the skill applies respelling in Step 3.5-E, it must surface both the original and the respelled form in the Step 8 output, in the `🎙️ Directives used` block. The user must see both so they can choose.

**Format inside the Directives used block:**

```
- "ปฺลายทาง" — phonetic respelling of "ปลายทาง" to preserve ปล- cluster (Step 7-A flag #1)
- "สิ-หฺริ" — phonetic respelling of "สิริ" to lock syllable boundaries (Step 7-A flag #3)
```

**Format inside the Lyrics field** (what gets pasted into Suno):

```
[Verse 1]
ในคืนที่ฟ้ายังไม่สาย
ใจฉันยังเดิน สู่ปฺลายทาง

[Chorus]
สิ-หฺริ คนเดียวที่ฉันเฝ้าคอย
```

The respelled forms go directly into the Lyrics field. The normative form does NOT appear in the Lyrics field — only one version gets sung.

**If the user wants to compare:** offer to generate twice (once with respelling, once without) and let them pick the better take. Document this option in the Iteration Tips block.

---

## Cross-references

- **Step 7-A (เพี้ยน Risk audit)** — see `thai-tone-craft.md` §"10 pronunciation risk patterns". The audit feeds the respelling decisions here.
- **Step 7-A2 (Rhyme × Tone matrix check)** — see `thai-tone-craft.md` §"Rhyme × Tone risk matrix". Tone-related risks may or may not be fixable by respelling; check the matrix first.
- **Cardinal "never romanize Thai" rule** — preserved throughout. Respelling is in Thai script, by definition. The K-pop romanization precedent in `bilingual-mixing.md` §6 is about Korean only.
- **Suno Song Editor / Replace Section workflow** — see `suno-platform.md` §"Persona / Voices / Extend / Song Editor — Thai workflow". Respelling pairs naturally with Replace Section: if a normative-spelled line fails in Take 1, replace just that line with the respelled version rather than re-rolling the whole song.
