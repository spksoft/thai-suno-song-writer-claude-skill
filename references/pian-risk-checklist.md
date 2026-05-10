# เพี้ยน Risk Checklist

A systematic checklist to apply to Thai lyrics before finalizing the Suno prompt. Per the user's preference: warn the user when risk is found, suggest a rewrite, but DO NOT auto-rewrite — let the user choose.

## How to use this checklist

For each line of lyrics, scan for these patterns in order. Flag any matches in the final output's "เพี้ยน Risk Flags" section. Format each flag as:

```
- บรรทัด "..." [issue], แนะนำเปลี่ยนเป็น "..."
```

If no flags found, output: `ไม่พบจุดเสี่ยงสำคัญ`

## The 10 risk patterns

### 1. Line length > 12 syllables

Count Thai syllables (≈ count of "characters that make sound" — written tone marks don't count).

**Risk:** Suno compresses long lines into faster cadence; tones flatten.
**Fix:** split into two lines.

**Example flag:**
```
- บรรทัด "เธอทำให้ฉันรู้สึกอบอุ่นใจในทุกๆ วันที่เราอยู่ด้วยกัน" (15 พยางค์) เกินยาว เสี่ยง tone collapse แนะนำแยกเป็น 2 บรรทัด: "เธอทำให้ฉันรู้สึกอบอุ่นใจ" / "ในทุกๆ วันที่เราอยู่ด้วยกัน"
```

### 2. Pali/Sanskrit compounds (3+ syllables, formal Thai)

Words like:
- สรรเสริญ (san-sŏen)
- อัจฉริยภาพ (àt-cha-rí-yá-phâap)
- สิริมงคล (sì-rí-mong-khon)
- บุญญาธิการ (bun-yaa-thí-kaan)
- สุนทรียภาพ (sŭn-tha-rii-yá-phâap)
- ปฏิสัมพันธ์ (pà-tì-săm-phan)
- อนันตกาล (à-nan-tà-kaan)
- ไร้กาลเวลา (rái-kaan-wee-laa)

**Risk:** rare in Suno's training; often render with wrong vowel length or wrong tone.
**Fix:** move to slow ballad section (long notes), or substitute with everyday Thai equivalent.

### 3. Initial consonant clusters on stressed beats

Watch for syllables starting with:
- ปร-, ปล-, ปฏ- (ประ, ปลา, ปฏิ)
- กร-, กล-, กว- (กรุง, กลม, กว่า)
- คร-, คล-, คว- (ครู, คลอง, ความ)
- ตร-, ตล- (ตรง, ตลาด)
- พร-, พล- (พระ, พลัง)
- สร- (สร้าง)

**Risk on stressed beats:** Suno often loses the cluster (ปลา → ปา) or merges incorrectly.
**Fix:** insert hyphen between cluster and vowel ("ปลฺา"), or rewrite with non-cluster word.

**Example flag:**
```
- บรรทัด "ปลายทางที่ฉันฝัน" — initial cluster "ปล-" บน accent — เสี่ยงเป็น "ปายทางฉันฝัน" — แนะนำ "ที่หมายที่ฉันฝัน" หรือ "จุดหมายที่ฉันฝัน"
```

### 4. Mai-tho falling tone on long held notes (especially end-of-phrase)

Words ending in falling tone (โท):
- เก่า, ก็, ค่อย, น่า, ไม่
- ใจ้ (well, that's actually rising; check carefully)
- ไป้, ขึ้น (when on long notes)
- คล้าย, น้อง

**Risk:** falling tone often collapses to mid (flat) on sustained notes.
**Fix:** put on short notes (eighth or shorter), or accept and earmark for Replace Section.

### 5. Real names (people, places)

Examples:
- People: สมชาย, นริน, สิริ, ภัทร
- Places: เชียงใหม่, ขอนแก่น, สุราษฎร์, นครราชสีมา

**Risk:** no reliable training data — silent syllables, wrong tones, wrong vowel length.
**Fix:** write phonetically in Thai script (สิริ → "สิ-หฺริ"), keep the same spelling everywhere, accept that 2–3 regenerations may be needed.

### 6. Numbers

Any digits (2026, 5G, 100%, etc.).

**Risk:** Suno may read inconsistently.
**Fix:** write the number out as Thai words.
- 2026 → "สองพันยี่สิบหก" or "สองศูนย์สองหก"
- 100% → "ร้อยเปอร์เซ็นต์"
- 5G → "ห้าจี"

### 7. English acronyms

AI, JR, ATM, IG, etc.

**Risk:** read as letters or word inconsistently.
**Fix:** force the version you want:
- AI → "เอ-ไอ" (letters) or "เอไอ" (word)
- IG → "ไอจี"
- ATM → "เอ-ที-เอ็ม"

### 8. Same-line Thai+English code-switching

Lines where Thai and English appear in the same sung line:
- "รักเธอ forever"
- "Bangkok ในคืนนี้"
- "ขอบคุณ thank you"

**Risk:** mid-line drift — Suno may apply English phonology to the Thai or vice versa.
**Fix:** split into two lines, or move English to a `(parenthetical echo)` after the Thai line.

**Example flag:**
```
- บรรทัด "Bangkok ในคืนนี้มันเหงาเกินไป" — same-line code-switching เสี่ยง drift — แนะนำแยก: "ในคืนนี้กรุงเทพมันเหงาเกินไป" + เพิ่ม echo "(Bangkok tonight)" ใต้บรรทัด
```

### 9. Short vowels on long held notes

Vowels: อิ, อะ, อุ, อึ.

**Risk:** these vowels collapse into nothing when held longer than a half note.
**Fix:** when designing the lyric, prefer long vowels for held-note positions:
- อา, อี, อู, ออ, แอ, โอ
- Or the complex vowels เอีย, เอือ

**Detection rule:** if a line's last syllable (often held in Thai phrasing) ends in อิ, อะ, อุ, that's a flag.

### 10. Conflicting vocabulary registers

Mixing very formal Thai (ราชาศัพท์, classical) with very colloquial Thai in the same section.

**Example flag:**
```
- บรรทัด "องค์เจ้าของหัวใจ ฉันโคตรรักเธอ" — register mismatch (formal "องค์เจ้า" + slang "โคตร") — แนะนำเลือกอย่างใดอย่างหนึ่ง
```

## Quick scan algorithm

When reviewing a full set of lyrics, follow this order:

1. **First pass — count syllables per line.** Flag any >12.
2. **Second pass — scan for Pali/Sanskrit compounds.** Use the list in #2 as anchor; look for similar 3+ syllable formal words.
3. **Third pass — scan for clusters at start of lines or after `[Section]` headers** (those are stressed positions).
4. **Fourth pass — scan end-of-line words** for falling tones and short vowels.
5. **Fifth pass — scan for proper names, numbers, English acronyms, code-switching.**
6. **Aggregate** — produce one flag per genuine risk. Don't over-flag; if a line has 3 risks, list only the most severe.

## When NOT to flag

- Common everyday words even if they technically match a pattern (e.g., "ไป" at end of line is technically a falling tone but is so common Suno handles it well).
- Single short vowels in unstressed positions.
- Cluster on the second syllable of a multi-syllable word (less stressed).
- The same word that worked in another generation already.

The goal is to flag patterns that ACTUALLY tend to fail in Suno, not every theoretical risk. Calibrate to keep flags actionable: 0–4 flags per song is a healthy range. More than 6 flags suggests over-flagging.

## What a clean flag block looks like

```
### ⚠️ เพี้ยน Risk Flags

- บรรทัด "ปลายทางที่ฉันฝัน": cluster "ปล-" บน accent อาจเป็น "ปายทาง" — ถ้าเพี้ยน เปลี่ยนเป็น "ที่หมายที่ฉันฝัน"
- บรรทัด "ไร้กาลเวลา": Pali compound 4 พยางค์ — ถ้าเพี้ยน เปลี่ยนเป็น "ไม่มีวันจาง"
- บรรทัด "เก่า" ที่ปลาย Verse 2: falling tone บนโน้ตยาวอาจ flat — ถ้าเพี้ยน ใช้ Replace Section ใน Song Editor
```

Or, if clean:

```
### ⚠️ เพี้ยน Risk Flags

ไม่พบจุดเสี่ยงสำคัญ — เนื้อร้องใช้คำง่ายๆ และโครงสร้างประโยคเหมาะกับความยาวบรรทัด ควรออกเสียงได้ชัดในการ generate
```
