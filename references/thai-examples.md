# Worked Thai Examples — Complete Suno Prompts (v2 directive-aware)

Each example is a full, ready-to-paste output as it would be given to a user. The format models the **9-step workflow** from `SKILL.md`, including:

- 5-part Styles formula with three-layer vocal spec (per `suno-platform.md` §4c, §8)
- v5+ meta tags at top of Lyrics (per `suno-platform.md` §5)
- Inline parenthetical performance cues like `(whispered)`, `(building intensity)` (per `suno-platform.md` §4b)
- Phonetic respelling for flagged words (per `thai-phonetic-respelling.md`)
- Rhyme blueprint chosen *before* writing lines (per `thai-rhyme-craft.md` §8)
- Rhyme × Tone matrix check on chorus end-words (per `thai-tone-craft.md` §7)
- Step 8 output template with new `🎙️ Directives used` block and `🇹🇭 Suno Thai expectation` block

When the user gives a concept that matches one of these genres, use the structure as a template. Adapt the lyrics to the user's concept while preserving the directive scaffolding.

---

## Example 1 — Thai mainstream pop ballad (เศร้า, รอคอย, female lead)

**User concept:** เพลงเศร้าเรื่องคนที่ยังคิดถึงแฟนเก่าและรอให้กลับมา ผู้หญิงร้อง 3:30 นาที

### Rhyme blueprint (chosen before writing)
- Hook word = "ใจ" → chorus rhyme family = **/ai/ open** (ใจ, ไป, ไกล, ไหน, ใหม่)
- Verse rhyme family = **/ɤː/** (เธอ, เผลอ, เจอ, เพ้อ) + **/aːi/** (หาย, สาย) — ABAB scheme
- Pre-chorus uses **/aː/** open (มา, หา, ครา) — couplet, sets up chorus
- **Rhyme × Tone matrix check** (`thai-tone-craft.md` §7): ใจ-family × MID tone = SAFE ✓

## 🎵 ยังเก็บเธอไว้ในใจ

### 📋 Styles (paste into Styles field)

```
Thai pop ballad, modern T-pop, bittersweet nostalgic melancholic, clean female soprano with breathy delivery, intimate close-mic with reverb tail, fingerpicked acoustic guitar, soft synth pads, soft piano, polished radio mix, 86 BPM, clear native Thai diction
```

(12 tags — squarely in the 8–15 sweet spot; under 200 chars for v5)

### 📝 Lyrics (paste into Lyrics field)

```
[Mood: Melancholic]
[Vocal Style: Soft Female]
[Texture: Sparse → Full]

[Intro]
[Soft fingerpicked acoustic guitar]

[Verse 1]
(whispered)
ในคืนที่ฟ้ายังไม่สาย
หัวใจฉันยังคิดถึงเธอเสมอ
แม้เวลาผ่านมาเนิ่นนานสักเท่าไร
ภาพของเธอก็ไม่เคยเลือนเผลอ

[Pre-Chorus]
และทุกครั้งที่ฝนพรำลงมา
(ลงมา ลงมา)
หัวใจฉันก็เปียกชื้นทุกครา

[Chorus]
อยากบอกเธอว่าฉันยังคอย
(ยังคอย ยังคอย)
อยากให้เธอรู้ใจฉันสักหน่อย
(สักหน่อย สักหน่อย)
แม้วันเวลาจะพาเราห่างไกล
ฉันยังเก็บเธอเอาไว้ข้างใน ในใจ

[Verse 2]
ภาพถ่ายใบเก่าที่ยังเก็บใกล้
รอยยิ้มของเธอที่ยังจำเสมอ
ทุกๆ คำที่เคยพูดและเข้าใจ
ยังก้องอยู่ข้างในใจที่ยังเพ้อ

[Pre-Chorus]
และทุกครั้งที่ดาวร่วงลงมา
(ลงมา ลงมา)
หัวใจฉันก็แหลกสลายทุกครา

[Chorus]
อยากบอกเธอว่าฉันยังคอย
(ยังคอย ยังคอย)
อยากให้เธอรู้ใจฉันสักหน่อย
(สักหน่อย สักหน่อย)
แม้วันเวลาจะพาเราห่างไกล
ฉันยังเก็บเธอเอาไว้ข้างใน ในใจ

[Bridge]
[Soft piano]
(stripped back)
ถ้าหากวันนึงเธอเดินกลับมา
ฉันก็ยังอยู่ตรงนี้รอเธอเรื่อยมา

[Chorus]
(building intensity)
อยากบอกเธอว่าฉันยังคอย
(ยังคอย ยังคอย)
อยากให้เธอรู้ใจฉันสักหน่อย
(สักหน่อย สักหน่อย)
แม้วันเวลาจะพาเราห่างไกล
ฉันยังเก็บเธอเอาไว้ข้างใน ในใจ

[Outro]
[Acoustic guitar fade]
ฉันยังเก็บเธอไว้ในใจ...

[Fade Out]
```

### ⚙️ Settings

- **Vocal Gender:** Female
- **Weirdness:** 30%
- **Style Influence:** 78%
- **Model:** v5.5 (or v4.5+all for users without Pro)

### 🎙️ Directives used

- `[Mood: Melancholic]` meta tag → soft hint for emotional palette (v5+ only)
- `[Vocal Style: Soft Female]` meta tag → reinforces close-mic'd female aesthetic
- `[Texture: Sparse → Full]` meta tag → cues the dynamic arc from intimate verse to full chorus
- `(whispered)` on Verse 1 line 1 → opens the song with breathy intimate delivery
- `(stripped back)` on Bridge → cues the bridge to drop to piano + vocal
- `(building intensity)` on Final Chorus → cues the band re-entry with full dynamics
- `[Soft fingerpicked acoustic guitar]` / `[Soft piano]` / `[Acoustic guitar fade]` — Layer 1 production cues for each section

### 🇹🇭 ความคาดหวังกับ Suno สำหรับเพลงไทย

Suno ฝึกเก่งสุดกับภาษา English / Spanish / Portuguese / French / Japanese / Korean / Mandarin — ภาษาไทยอยู่ในกลุ่ม lesser-represented languages คาดหวังว่า take 1 อาจมีคำที่ออกเสียงไม่ตรงเป๊ะ (เพี้ยนเสียงสระ / สูญหายพยัญชนะต้น / โทนเสียงแบนไป)

แนวทางที่ใช้ได้: regenerate 2–3 takes แล้วเลือก take ที่ดีที่สุด; สำหรับบรรทัดที่เพี้ยนเฉพาะจุด ใช้ Replace Section ใน Song Editor; ถ้าเพลงนี้ใช้ดีแล้วและจะแต่งเพลงต่อในชุดเดียวกัน กด Make Persona เพื่อ lock น้ำเสียงและสำเนียง

### ⚠️ เพี้ยน Risk Flags

- "ก็" ในบรรทัด pre-chorus — falling tone บนโน้ตที่อาจถือยาว — เสี่ยง flat; ถ้าเพี้ยนใน take 1 ใช้ Replace Section
- "เก่า" ใน verse 2 — falling tone บน accent — เสี่ยงเล็กน้อย; ถ้าเพี้ยนให้เปลี่ยนเป็น "ภาพในวันก่อนที่ยังเก็บใกล้"

### 🎼 คำคล้องจอง Audit

- **Verse 1 + Verse 2:** ABAB ครบ — line 1+3 บน /aːi/ (สาย-เท่าไร / ใกล้-เข้าใจ), line 2+4 บน /ɤː/ (เสมอ-เผลอ / เสมอ-เพ้อ). Verse 2 mirror Verse 1 → cohesive ✓
- **Pre-Chorus:** AA couplet บน /aː/ (มา-ครา) ✓
- **Chorus:** AABB บน /ɔːi/ (คอย-หน่อย) + /ai/ (ไกล-ใจ). Echo "(ยังคอย)" + "(สักหน่อย)" rhyme กับบรรทัดด้านบน ✓
- **สัมผัสใน:** chorus line "ฉันยังเก็บเธอเอาไว้ข้างใน ในใจ" — vowel /ai/ ซ้ำ 3 ครั้ง (ไว้-ใน-ใจ) — hook reinforcement ✓
- **Title hook "ใจ"** ลงตำแหน่งสุดท้ายของ chorus ทุกรอบ ✓
- **Rhyme × Tone matrix** (`thai-tone-craft.md` §7): ใจ-family × MID = SAFE ✓
- ไม่พบ ขัดสัมผัส, สัมผัสซ้ำคำเดียวกัน, หรือ forced rhyme

### 🔁 Iteration Tips

- ถ้า vibe ไม่ใช่: เพิ่ม Style Influence เป็น 88%, ลด Weirdness เป็น 20%
- ถ้าท่อน bridge ไม่ stripped back พอ: เปลี่ยน `(stripped back)` เป็น `(stripped back, just piano)` หรือเพิ่ม `[Soft piano alone]` ก่อน bridge
- ถ้าอยากให้ track จำเสียงนี้: กด ⋮ → Make Persona ก่อน iterate ต่อ
- ถ้าเพลงดีแล้วแต่อยากยาวขึ้น: ใช้ Extend จากท้าย outro (ระวัง tone drift — ดู `suno-platform.md` §11 Workflow C)

---

## Example 2 — Thai stadium rock anthem (ฮึกเหิม, สู้ชีวิต, male lead) + commit-to-the-fall

**User concept:** เพลงให้กำลังใจคนที่ท้อ ให้สู้ต่อ แนวร็อคสาย Bodyslam ผู้ชายร้อง

### Rhyme blueprint
- Hook word = "ไป" → chorus rhyme family = **/ai/ open** (ไป, ใจ, ไหว, ใหม่, ไกล, ใคร)
- Verse rhyme family = **/aːŋ/** แม่กง (ทาง, วาง, ระหว่าง, ห่าง) — AABB couplets
- Pre-chorus uses **/ai/** as well, building anticipation toward the chorus payoff
- **Rhyme × Tone matrix check**: hook "ไป" is /ai/ open, written ไม-อ but the spoken tone on stressed downbeat falls toward FALLING. (ใจ-family × FALLING) = RISK¹ per matrix. **Survival strategy: commit-to-the-fall** (see `thai-tone-craft.md` §8). The melody is designed to descend on each "ไป" — the song uses the falling tone as part of its emotional design. `[Belted]` directive added on chorus to give dynamic shape.

## 🎵 ก้าวต่อไป

### 📋 Styles (paste into Styles field)

```
Thai rock ballad, anthemic stadium rock, emotional building powerful, soaring male tenor with vibrato belted full-voice, cinematic close-mic with wide reverb, distorted electric guitars, driving rock drums, piano with strings opening, polished pro mix with dynamic verse-to-chorus contrast, 88 BPM, clear Thai pronunciation
```

(14 tags — sweet spot; ~195 chars, just under v5's 200 limit)

### 📝 Lyrics (paste into Lyrics field)

```
[Mood: Hopeful Defiant]
[Energy: Building]
[Texture: Intimate → Anthemic]

[Intro]
[Distorted electric guitar riff]

[Verse 1]
เคยล้ม เคยแพ้ บนเส้นทาง
เหมือนใจที่เดินอยู่ระหว่าง
แต่หัวใจดวงนี้ยังไม่วาง
ยังคงก้าวเดินไม่เคยร้างห่าง

[Pre-Chorus]
ไม่ว่าฟ้าจะมืดเพียงไหน
(เพียงไหน เพียงไหน)
ฉันจะไม่ยอม ไม่ยอมพ่ายไป

[Chorus]
[Belted]
ก้าวต่อไป ก้าวต่อไป
(ก้าวต่อไป)
แม้จะเหนื่อยแค่ไหน ก็ต้องไป
(ต้องไป ต้องไป)
เพราะจุดหมายที่ฝันใฝ่
ยังรออยู่ตรงนั้น ใจ
ก้าวต่อไป ไม่หยุดใจ

[Verse 2]
ทุกหยาดเหงื่อที่หลั่งลงบนทาง
ทุกบาดแผลคือบทเรียนระหว่าง
ไม่มีใครรู้ว่าฉันต้องวาง
อะไรไปแลกกับเส้นทางห่าง

[Pre-Chorus]
ไม่ว่าใครจะมองอย่างไร
(อย่างไร อย่างไร)
ฉันจะเดินทางของฉันต่อไป

[Chorus]
[Belted]
ก้าวต่อไป ก้าวต่อไป
(ก้าวต่อไป)
แม้จะเหนื่อยแค่ไหน ก็ต้องไป
(ต้องไป ต้องไป)
เพราะจุดหมายที่ฝันใฝ่
ยังรออยู่ตรงนั้น ใจ
ก้าวต่อไป ไม่หยุดใจ

[Guitar Solo]

[Bridge]
[Belted]
(building intensity)
ถ้าฉันยอมแพ้ในวันนี้
ใครจะเดินต่อให้ฉันได้ไป

[Chorus]
[Belted]
ก้าวต่อไป ก้าวต่อไป
(ก้าวต่อไป)
แม้จะเหนื่อยแค่ไหน ก็ต้องไป
(ต้องไป ต้องไป)
เพราะจุดหมายที่ฝันใฝ่
ยังรออยู่ตรงนั้น ใจ
ก้าวต่อไป ไม่หยุดใจ

[Outro]
[Distorted guitar fade]
ก้าวต่อไป...
[Fade Out]
```

### ⚙️ Settings

- **Vocal Gender:** Male
- **Weirdness:** 42%
- **Style Influence:** 75%
- **Model:** v5.5 (200-char Style limit just-fits at v5; v5.5 has the 1000-char budget)

### 🎙️ Directives used

- `[Mood: Hopeful Defiant]` / `[Energy: Building]` / `[Texture: Intimate → Anthemic]` meta tags → reinforce dynamic arc (v5+ only)
- `[Belted]` on every chorus section → key to commit-to-the-fall strategy: gives the falling-tone "ไป" hook word the dynamic shape Suno needs to render it as deliberate descent (see `thai-tone-craft.md` §8)
- `[Belted]` also on Bridge → maintains intensity
- `(building intensity)` on Bridge → cues Suno to swell into the final chorus
- `[Distorted electric guitar riff]` / `[Guitar Solo]` / `[Distorted guitar fade]` — Layer 1 production cues for arrangement structure

### 🇹🇭 ความคาดหวังกับ Suno สำหรับเพลงไทย

ไทยอยู่ในกลุ่ม lesser-represented languages — เพลงร็อค anthemic จะมีปัญหากว่า ballad เพราะ BPM สูงและความหนาแน่นของพยางค์มาก. ตัวฮุก "ก้าวต่อไป" มีคำ "ก้าว" และ "ไป" ที่ falling tone บนโน้ตยาว — Take 1 อาจเพี้ยนทั้งคู่. แนวทาง:
- regenerate 2–3 takes แล้วเลือกที่ "ก้าว" ลงเสียงต่ำตรง (commit-to-the-fall)
- ถ้า "ก้าวต่อไป" ใน take 1 ฟังแบน ใช้ Replace Section บน chorus แรกอย่างเดียว แล้วให้ Suno re-render
- Persona-lock หลัง take ดี ถ้าจะทำชุดเพลง anthem rock ต่อ

### ⚠️ เพี้ยน Risk Flags

- ฮุก "ก้าวต่อไป" — Rhyme × Tone matrix RISK¹ (ใจ-family × FALLING) — ใช้ commit-to-the-fall strategy พร้อม `[Belted]` แล้ว ✓ (acknowledged design choice, not redraft)
- "จุดหมาย" — แทนที่ "ปลายทาง" เพื่อหลีกเลี่ยง initial cluster "ปล-" บน accent (เสี่ยงเป็น "ปายทาง")
- ไม่ตอนนี้ ๆ "ก็" บน pre-chorus — falling tone บนโน้ตที่อาจถือยาว — ถ้าเพี้ยน Replace Section

### 🎼 คำคล้องจอง Audit

- **Verse 1:** AAAA บน /aːŋ/ (ทาง-ระหว่าง-วาง-ห่าง) — strong unified family, anthem-appropriate ✓
- **Verse 2:** mirror ของ Verse 1 — AAAA บน /aːŋ/ ซ้ำ family เดิม → cohesion สูง ✓
- **Pre-Chorus:** AA บน /ai/ (ไหน-ไป) → vowel family เดียวกับ chorus → "resolves into" the hook ✓
- **Chorus:** AABB บน /ai/ — line 1+2 (ไป-ไป), line 3+4 (ใฝ่-ใจ), line 5 echo ใจ → hammer the hook ✓
- **Echo (ก้าวต่อไป) + (ต้องไป):** rhyme กับบรรทัดด้านบน ✓
- **สัมผัสใน:** "ก้าวต่อไป ก้าวต่อไป" alliteration บน "ก-" + vowel /ai/ ซ้ำ → maximum chant-along catchiness ✓
- **Title hook "ก้าวต่อไป"** เปิด chorus ทุกรอบและจบ chorus ทุกรอบ → เป็นทั้ง anchor และ payoff ✓
- **Rhyme × Tone matrix flagged** as RISK¹ — addressed by commit-to-the-fall (see audit above)
- สัมผัสซ้ำคำ "ไป" ใน chorus เป็น **intentional hook repetition** (acceptable in anthemic chorus, not a flag)

### 🔁 Iteration Tips

- ถ้าฮุกแบนไม่ปลุกใจ: เพิ่ม `(building intensity)` ก่อนทุก chorus, เพิ่ม Style Influence เป็น 85%
- ถ้าเสียงร้อง weak ไม่ stadium: เพิ่ม `soaring tenor with operatic vibrato` ใน Vocal Direction
- ถ้า "ก้าว" เพี้ยนทุก take: respelling เป็น `ก้าว-ต่อ-ไป` (hyphen-split) ใน Replace Section
- ถ้าจะ extend ให้เพลงยาวขึ้น: extend ก่อน final chorus, ไม่ใช่หลัง (ดู `suno-platform.md` §11 Workflow C)

---

## Example 3 — Thai-primary bilingual indie (Thai + English chorus echoes, male lead) + phonetic respelling

**User concept:** เพลง indie ดูเหงาๆ คืนกรุงเทพ คิดถึงคนที่จากไป มีท่อน English ใน chorus echoes, ใช้ "Bangkok" ที่ต้อง respelling

### Rhyme blueprint
- Hook word = "คืนนี้" → chorus rhyme family = **/iː/** (mostly chorus echo English; lead Thai)
- Verse rhyme family = **/iaŋ/** (เงียบ, ระเบียง) + **/ai/** (ไกล, ใจ)
- **Rhyme × Tone matrix check**: "คืนนี้" — คืน-family × MID tone = SAFE ✓
- **Bilingual structure:** Thai-primary; English echoes in chorus parens only
- **Phonetic respelling needed**: "Bangkok" mid-line is forbidden (per `bilingual-mixing.md` §2). Options: split to separate line OR respell as `แบง-คอก` in Thai script (per `thai-phonetic-respelling.md` §5). Choose split.

## 🎵 ในคืนนี้ที่กรุงเทพ

### 📋 Styles (paste into Styles field)

```
Thai indie pop, Bangkok bedroom pop, dreamy nostalgic late-night, breathy male tenor close-mic'd intimate conversational, warm tape saturation lo-fi mix, jangle electric guitar with reverb, lo-fi drum machine, subtle synth pads, 100 BPM, Thai vocals primary with English chorus echoes
```

(12 tags; ends with drift declaration per `bilingual-mixing.md` §4)

### 📝 Lyrics (paste into Lyrics field)

```
[Mood: Melancholic Reflective]
[Vocal Style: Breathy Male]

[Intro] (Thai)
[Mellow electric guitar arpeggio with reverb]

[Verse 1] (Thai)
(whispered)
นั่งคนเดียวบนระเบียง
ดูแสงไฟส่องอยู่ไกลๆ
ในคืนนี้กรุงเทพดูเงียบเหลือเกิน
ราวกับเมืองที่ฉันไม่เคยรู้จัก

[Pre-Chorus] (Thai)
และความเงียบมันก็ดังขึ้นเรื่อยๆ
(louder, louder)
จนกลบเสียงในใจของฉัน

[Chorus] (Thai)
ฉันคิดถึงเธอ ทุกๆ คืน
(every night, every night)
อยากให้เธอกลับมาตรงนี้
(come back to me)
ในคืนนี้ที่กรุงเทพมันเหงาเกินไป
ถ้าไม่มีเธออยู่ข้างกัน

[Verse 2] (Thai)
รถวิ่งผ่านบนถนนเงียบๆ
แสงนีออนสะท้อนน้ำฝน
ทุกอย่างดูเหมือนหนังเก่าๆ
ที่ฉันเคยดูกับเธอ

[Pre-Chorus] (Thai)
และความทรงจำมันก็ชัดขึ้นเรื่อยๆ
(clearer, clearer)
จนเหมือนเธอยังอยู่ตรงนี้

[Chorus] (Thai)
ฉันคิดถึงเธอ ทุกๆ คืน
(every night, every night)
อยากให้เธอกลับมาตรงนี้
(come back to me)
ในคืนนี้ที่กรุงเทพมันเหงาเกินไป
ถ้าไม่มีเธออยู่ข้างกัน

[Bridge] (English)
And the city keeps on moving
But I'm standing still
Waiting for you to come home

[Chorus] (Thai)
(building intensity)
ฉันคิดถึงเธอ ทุกๆ คืน
(every night, every night)
อยากให้เธอกลับมาตรงนี้
(come back to me)
ในคืนนี้ที่กรุงเทพมันเหงาเกินไป
ถ้าไม่มีเธออยู่ข้างกัน

[Outro] (Thai)
[Guitar fade with tape echo]
ในคืนนี้ที่กรุงเทพ...
(every night)
[Fade Out]
```

### ⚙️ Settings

- **Vocal Gender:** Male
- **Weirdness:** 58%
- **Style Influence:** 65%
- **Model:** v5.5

### 🎙️ Directives used

- `[Mood: Melancholic Reflective]` / `[Vocal Style: Breathy Male]` meta tags → set indie aesthetic
- `(whispered)` on Verse 1 → opens with intimate hush
- `(building intensity)` on final Chorus → cues the dynamic build for the closing pass
- Section anchors `(Thai)` / `(English)` on **every** section — per `bilingual-mixing.md` §1 language-anchoring rule
- Parenthetical echoes `(every night, every night)` / `(come back to me)` — English backing vocals over Thai lead lines (per `bilingual-mixing.md` §3 echo-translation pattern)
- **Phonetic respelling decision**: "Bangkok" was on the same line as Thai content in the original draft. Rewritten as `ในคืนนี้ที่กรุงเทพ` (Thai-only lead line) — no respelling needed. **Alternative offered**: if user prefers "Bangkok" in the title, use Thai-script respelling `แบง-คอก` (see `thai-phonetic-respelling.md` §5 fallback path).
- `Thai vocals primary with English chorus echoes` drift declaration in Styles field → reduces language drift (per `bilingual-mixing.md` §4)

### 🇹🇭 ความคาดหวังกับ Suno สำหรับเพลงไทย

ไทยอยู่ในกลุ่ม lesser-represented languages — bilingual songs มีโอกาส drift ทั้ง 2 ทิศ. มี section anchors กับ drift declaration แล้ว แต่:
- ถ้า Verse 1 fade เป็นเสียง English-accented Thai: ใช้ workflow drift recovery (`bilingual-mixing.md` §5)
- ถ้า English bridge ฟังเป็น Thai-accented English: เพิ่ม `[English Vocal]` ก่อน bridge
- ถ้าเพลงนี้ดีแล้วและจะแต่งเพลง bilingual ต่อ: Persona-lock จะเก็บสำเนียงทั้ง 2 ภาษาให้คงที่ข้ามเพลง

### ⚠️ Pronunciation Risk Flags (Thai)

- "เหงาเกินไป" — ปลายบรรทัดด้วย falling tone "ไป" บนโน้ตยาว — เสี่ยงเล็กน้อย; ถ้าเพี้ยน apply commit-to-the-fall
- "ระเบียง" — initial cluster "ระ-" + "เบียง"; ปกติ Suno render ดี แต่ถ้าเพี้ยนเปลี่ยนเป็น "หน้าระเบียง"
- ใช้ section-language anchor "(Thai)" / "(English)" แล้ว ลด drift ได้มาก

### 🎼 Rhyme Audit (Thai)

- **Verse 1:** /iaŋ/ + /ai/ scheme. ABAB rough — line 1+3 บน "ระเบียง-เกิน" (loose); line 2+4 บน /ai/ "ไกลๆ-รู้จัก" (loose)
- **Chorus:** Thai lead lines + English echoes — echo "(every night)" rhymes with Thai "คืน" via /iː/ assonance ✓
- **Rhyme × Tone matrix**: คืน-family × MID (สามัญ) = SAFE ✓
- Title "ในคืนนี้ที่กรุงเทพ" closes the chorus → delayed-reveal hook (Flure/Toys archetype per `thai-hit-songs.md` §2)

### 🌐 Bilingual Mixing Audit

- **Same-line code-switching:** Fixed — original draft had "Bangkok ในคืนนี้"; rewritten to pure Thai lead line "ในคืนนี้ที่กรุงเทพ" with `(every night)` English echo ✓
- **Section anchors:** Every section has `(Thai)` / `(English)` ✓
- **Drift declaration:** `Thai vocals primary with English chorus echoes` present in Style field ✓
- **Echo length:** All English echoes 1–5 syllables ✓ (per `bilingual-mixing.md` §3 echo design rules)

### 🔁 Iteration Tips

- ถ้า English bridge ดร็อปจังหวะมากเกินไป: เปลี่ยน `[Bridge] (English)` เป็น `[Bridge] (English) [Spoken Word]` — softer transition
- ถ้า Thai สำเนียงดูไม่ Bangkok พอ: เพิ่ม `Thai vocals in Bangkok accent` ใน Styles
- ถ้าจะ extend: extend ก่อน final chorus เพื่อให้ context ของ hook อยู่ใน Suno (per `suno-platform.md` §11 Workflow C)
- ถ้าใช้ใหม่ในชุด indie EP: Make Persona บน take ที่ best — Persona เก็บทั้งสำเนียงไทยและ accent อังกฤษ

---

## How to use these examples

When the user gives a concept matching one of these genres, use the structure as a template:

1. **Keep the section skeleton** (Intro/Verse/Pre-Chorus/Chorus/Verse/Pre-Chorus/Chorus/Bridge/Chorus/Outro)
2. **Keep the chorus written out 3 times** — Suno does not loop `[Chorus]` reliably
3. **Keep the `(parenthetical echoes)` pattern** in the Pre-Chorus and Chorus — make sure echoes rhyme with the line above them (per `thai-rhyme-craft.md` §4)
4. **Pick the chorus rhyme family BEFORE writing any lines** — Examples 1, 2, 3 all show the rhyme blueprint at the top. Do this for every new song.
5. **Run the Rhyme × Tone matrix check** on the chorus end-word (per `thai-tone-craft.md` §7) before writing the verses. If RISK¹ (falling tone on chorus end), plan for commit-to-the-fall.
6. **Adapt the lyrics to the user's actual concept** while preserving the rhyme scheme and directive scaffolding.
7. **Layer in directives** per Step 3.5 of `SKILL.md` — meta tags at top, inline parens cues sparingly (max 1 per section), bracket vocal cues for sustained section character.
8. **Always run BOTH audits**: the เพี้ยน risk check (Step 7-A + 7-A2 Rhyme × Tone) AND the คำคล้องจอง rhyme audit (Step 7-C). For bilingual songs, also run the Bilingual Mixing audit (Step 7-E).
9. **Always emit the `🇹🇭 ความคาดหวังกับ Suno` framing block** when Thai content is detected — sets user expectation for 2–3 regenerations.

For non-pop genres (city pop, phleng phuea chiwit, luk thung, hip-hop), see `thai-genre-craft.md` for sub-genre style templates and slider numbers. The directive scaffolding (meta tags + inline cues + section anchors + audit blocks) stays the same across genres.

## Cross-references

- **Workflow with Step 3.5 directive layering** — `SKILL.md` §Step 3.5
- **Suno platform directive grammar** — `suno-platform.md` §3–6
- **Three-layer vocal spec** — `suno-platform.md` §4c
- **Persona / Voices / Extend / Song Editor — Thai workflow** — `suno-platform.md` §11
- **Rhyme craft, schemes, audit** — `thai-rhyme-craft.md`
- **Tonal-melodic alignment, เพี้ยน audit, Rhyme × Tone matrix** — `thai-tone-craft.md`
- **Phonetic respelling** — `thai-phonetic-respelling.md`
- **Hit-song archetypes** — `thai-hit-songs.md` (Cocktail / Bowkylion / Tilly Birds / GUNGUN / Flure case studies)
- **Bilingual mixing** — `bilingual-mixing.md`
- **Genre-specific lyric conventions and Style templates** — `thai-genre-craft.md`
- **Lyricist signatures** (when user asks "เขียนแบบฟองเบียร์/ครูสลา/etc") — `thai-lyricist-signatures.md`
