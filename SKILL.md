---
name: thai-suno-songwriter
description: Generate ready-to-paste prompts for Suno AI to create Thai-language songs (Thai-only or Thai+English code-switching). Use this skill whenever the user mentions Suno, AI music generation, แต่งเพลงด้วย AI, สร้างเพลงไทย, generating song lyrics for AI, T-pop/Thai pop/Thai rock songwriting, or wants to produce the full Lyrics + Styles + Title + slider settings (Vocal Gender, Weirdness, Style Influence) for Suno v4.5/v4.5+/v4.5-all. Trigger this skill on any phrase like "ช่วยแต่งเพลง suno", "อยากทำเพลงไทย AI", "เขียน prompt สำหรับ suno", "Thai song lyrics for Suno", or any request that combines Thai songwriting with an AI music generator — even if Suno isn't named explicitly. The skill produces output formatted for direct paste into Suno's Custom Mode fields, follows Thai pop/rock conventions (tonal-melodic alignment, ฉันทลักษณ์, common chord-progression-friendly phrasing), warns about likely tone-mispronunciation (เพี้ยน) risk, and gives iteration tips.
---

# Thai Suno Songwriter

Help the user create a complete, ready-to-paste prompt set for Suno AI in Thai (or Thai mixed with English). The output goes into four Suno fields plus three sliders.

## What Suno needs (the target output)

The user will paste the skill's output into Suno's Advanced/Custom mode, which has these fields (see screenshot reference if available, or `references/suno-fields-reference.md`):

| Field | What it is | Limit |
|---|---|---|
| **Lyrics** | Thai lyrics with `[Section]` headers and `(backing vocals)` in parens | ≤5,000 chars (target ≤3,000) |
| **Styles** | Comma-separated genre/mood/instrument tags | ≤1,000 chars (target ≤200) |
| **Song Title** | Cosmetic name | ≤80 chars |
| **Vocal Gender** | Male / Female toggle | binary |
| **Weirdness** | 0–100% slider | recommend per genre |
| **Style Influence** | 0–100% slider | recommend per genre |

The skill always asks the user about their concept first, then produces all six in one consolidated answer.

## Workflow (do these steps in order)

### Step 1 — Elicit the concept (always ask)

Even if the user gives a one-line request, ask the questions below before writing anything. Use the `ask_user_input_v0` tool when available so the user can tap answers on mobile; otherwise ask in prose with numbered options.

Ask these (combine into one tool call — split into 2 calls only if more than 3 questions are needed):

1. **หัวข้อ/เรื่อง** — what is the song about? (free text, encourage 1 sentence)
2. **อารมณ์** — pick one: `เศร้า/อกหัก` · `รัก/หวาน` · `ฮึกเหิม/สู้ชีวิต` · `เหงา/คิดถึง` · `สนุก/ปาร์ตี้` · `โกรธ/ระบาย` · `อื่นๆ (ระบุ)`
3. **แนวเพลง (sub-genre)** — pick one: `T-pop ballad` · `Thai pop-rock / stadium rock` · `Thai indie / bedroom pop` · `City pop / 80s synth` · `Phleng phuea chiwit / folk-rock` · `Pop-punk` · `R&B / city ballad` · `Luk thung / mor lam fusion`
4. **ภาษา** — pick one: `ไทยล้วน` · `ไทยเป็นหลัก + อังกฤษบางท่อน (chorus echoes / bridge)` · `ครึ่งไทยครึ่งอังกฤษ`
5. **เพศนักร้อง** — `Male` / `Female` / `ดูเอ็ท`
6. **ความยาว** — `สั้น (~2 นาที, แค่ verse-chorus-verse-chorus)` / `มาตรฐาน (~3:30, เต็มโครง)` / `ยาว (~5 นาที, มี bridge ยาว+โซโล)`

Skip a question only if the user already answered it explicitly in the conversation. If unsure, ask. Don't guess on language ratio — that decision changes the lyric structure.

### Step 2 — Read the relevant reference files

Before writing, view these files based on the genre and language choices:

- **Always read** `references/suno-fields-reference.md` (tags, sliders, formatting rules) and `references/tonal-melodic-rules.md` (เพี้ยน prevention).
- **For Thai pop/rock genre selection** — read the matching section in `references/style-templates.md`.
- **For full worked examples** — read `references/examples.md`.
- **For risk-flagging final lyrics** — apply `references/pian-risk-checklist.md`.

Reading them is fast and avoids guessing on tag names, slider numbers, and Thai pronunciation pitfalls.

### Step 3 — Compose the lyrics

Standard structure for ~3:30 Thai pop song (adjust for length):

```
[Intro]
[Verse 1]        ← 4 lines, 6–12 syllables each
[Pre-Chorus]     ← 2–3 lines (optional but adds lift)
[Chorus]         ← 4–6 lines, hook on line 1 and line 4
[Verse 2]        ← 4 lines, expand or shift the scene
[Pre-Chorus]
[Chorus]         ← write out in full again (don't reference)
[Bridge]         ← 2–4 lines, contrasting perspective
[Chorus]         ← write out in full a third time
[Outro]
```

Lyric-craft rules to follow (from `references/tonal-melodic-rules.md`):

- **6–12 syllables per line** for Thai. More than 12 forces the model to compress and tones collapse.
- **Use Thai script** (ภาษาไทย) — never romanize. Romanization confuses Suno's tokenizer.
- **Repeat the chorus identically** when it appears 2nd/3rd time. Suno doesn't loop a labeled section by reference; if `[Chorus]` is empty after a verse, Suno improvises (badly). Repeating also reinforces correct pronunciation if it landed on take 1.
- **Backing vocals/echoes in `(parentheses)`** — they get sung as harmony/echo, lower in the mix. Example: `อยากบอกเธอว่ารัก (ว่ารัก ว่ารัก)`
- **Section directives in `[brackets]`** — they are NOT sung. Use for `[Soft piano]`, `[Acoustic guitar fade]`, etc. inserted between sections.
- **Thai+English code-switching:** anchor each section to one language with a parenthetical marker after the section header, like `[Verse 1] (Thai)` or `[Bridge] (English)`. Don't mix scripts within the same line — put English to its own line or its own `(echo)`.
- **Apply tonal-melodic alignment principles:** the chorus hook line is the most important — pick title words whose lexical tones flow naturally with a singable melodic shape. See `references/tonal-melodic-rules.md` for the 5-tone contour rules and the "fix techniques" list.
- **Rhyme:** use สัมผัสนอก (last syllable of line N rhymes with a syllable in line N+1) where natural; สัมผัสใน (alliteration / vowel echo within a line) is a bonus, not required. Don't sacrifice naturalness for rhyme.

### Step 4 — Compose the Styles description

Format: comma-separated tags, in this order:

```
[Genre], [Sub-genre/Era], [Mood], [2–3 instruments], [Vocal cue], [Production], [BPM], [Thai diction cue]
```

Target 4–8 tags total, ≈150–250 chars. Keep under 1,000 chars.

**Always include a Thai-pronunciation cue** at the end: `clear native Thai diction` or `Thai vocals in Bangkok accent, no English drift` — this measurably reduces เพี้ยน issues per Thai user community reports.

**Never use real Thai artist names** — Suno blocks them silently. Use sonic descriptors instead. For example, instead of "Bodyslam-style", write `Thai stadium rock, anthemic, soaring male vocals, distorted electric guitars, big drums`. See `references/style-templates.md` for ready-made templates per sub-genre.

### Step 5 — Recommend slider settings

Based on the chosen sub-genre, pick from this lookup (also in `references/suno-fields-reference.md`):

| Sub-genre | Weirdness | Style Influence |
|---|---|---|
| Mainstream T-pop / radio pop | 25–35% | 70–85% |
| Thai pop-rock / stadium rock | 35–50% | 65–80% |
| Indie / Bangkok bedroom pop | 50–65% | 55–70% |
| City pop / 80s pastiche | 20–30% | 80–95% |
| Phleng phuea chiwit | 30–45% | 65–80% |
| Pop-punk | 35–50% | 65–80% |
| R&B / city ballad | 25–40% | 70–85% |
| Luk thung / mor lam fusion | 40–60% | 60–75% |

Always state the chosen number, not a range, in the final output. Pick the midpoint of the range unless the user specified "experimental" or "very mainstream."

### Step 6 — Generate the Song Title

The title is cosmetic in Suno (does not influence audio), but the user will see it. Pick something:
- 2–6 Thai words (or short English/Thai mix)
- Echoes the chorus hook phrase, OR uses a memorable image from the lyrics
- ≤30 Thai characters is comfortable

### Step 7 — Run the เพี้ยน risk check

Before finalizing, scan the lyrics for these high-risk patterns (full list in `references/pian-risk-checklist.md`):

- Lines >12 syllables → split into two lines
- Pali/Sanskrit compounds (สรรเสริญ, อัจฉริยภาพ) on fast sections → relocate or substitute
- Initial consonant clusters (ปร, กล, คว, ปฏ) on stressed beats → consider hyphenating or rewriting
- Mai-tho falling tone (เก่า, ก็, ค่อย) on long held notes → flag — the falling tone often becomes flat in Suno
- Numbers, English acronyms → write out as Thai words
- Same-line code-switching → split into two lines or move English to a `(echo)`
- Short vowels (อิ, อะ, อุ) on long held notes → switch to long vowels if possible

For each risk found, state the line, the issue, and a suggested rewrite. Don't auto-rewrite — let the user choose.

### Step 8 — Output the consolidated answer

Use this exact template so the user can copy each block straight into Suno:

```
## 🎵 [Song Title in Thai]

### 📋 Styles (paste into Styles field)

```
[comma-separated tags here]
```

### 📝 Lyrics (paste into Lyrics field)

```
[Intro]
[Verse 1]
...
[Outro]
```

### ⚙️ Settings

- **Vocal Gender:** [Male / Female]
- **Weirdness:** [X]%
- **Style Influence:** [Y]%
- **Model:** v4.5+all (or v5 if user has Pro/Premier)

### ⚠️ เพี้ยน Risk Flags

- Line "...": [issue], suggest rewriting as "..."
- (or: "ไม่พบจุดเสี่ยงสำคัญ" if clean)

### 🔁 Iteration Tips

If take 1 isn't right:
- ถ้า vibe ไม่ใช่: เพิ่ม Style Influence เป็น [Y+10]%, ลด Weirdness เป็น [X-10]%
- ถ้าบรรทัด "..." ออกเสียงเพี้ยน: ใช้ Replace Section ใน Song Editor แล้วเขียนใหม่เป็น "..."
- ถ้าอยากให้ track จำเสียงนี้: กด ⋮ → Make Persona ก่อน iterate
- ถ้าเพลงดีแล้วแต่อยากยาวขึ้น: ใช้ Extend จากท้าย outro
```

## Edge cases and special handling

**If the user already has lyrics they wrote:** skip Step 3 (composition), but still run Step 7 (เพี้ยน risk check) on their lyrics, and produce the rest of the prompt set.

**If the user wants only instrumental:** check the "Instrumental" toggle in Suno; in this case, Lyrics field stays empty (or only `[Instrumental]` tags). Still produce Styles, Title, sliders.

**If the user gives a reference song (e.g., "ทำเพลงให้คล้าย ABC ของศิลปิน X"):** never copy lyrics, never name the artist in Styles. Translate the *sonic descriptors* (era, instruments, mood, BPM) into the Styles field. Apply the "no artist names" rule from `references/suno-fields-reference.md`.

**If the user is on Free tier:** they're on v4.5-all (the free variant). All output works identically — no changes needed. Mention this in passing only if relevant.

**For luk thung / mor lam fusion:** Suno's Thai-Isan diction is weakest here. Add aggressive pronunciation cues: `central Thai with Isan flavor, melismatic vocals with wide vibrato`, and warn the user that 2–3 regenerations are often needed for usable Isan delivery.

**If the user asks for a duet / two singers:** put both genders in the Styles field (`mixed-gender vocals, male and female duet`) and use `[Female Vocal]` / `[Male Vocal]` tags inside lyrics on the lines where each voice should lead. Vocal Gender toggle is best left on whichever voice opens the song.

**Length adjustments:**
- Short (~2 min) — drop the second verse and the bridge: `[Intro] [Verse 1] [Chorus] [Verse 2] [Chorus] [Outro]`
- Long (~5 min) — add a `[Instrumental Break]` or `[Guitar Solo]` (2–8 bars) before the bridge, and consider a final modulated chorus.

## Communication style

Ask the user in their language. Most users come in Thai — answer in Thai. If the user uses informal register (กู/มึง or casual), match it; otherwise, default to friendly polite Thai. The output template (Styles/Lyrics/Settings) stays in the standard format above regardless of conversation language.

When showing the final output, lead with a 1-sentence framing in the user's language ("นี่คือชุด prompt สำหรับ Suno ครับ คัดลอกแต่ละช่องไปวางในแอปได้เลย"), then the template, then the iteration tips. Don't re-explain why each choice was made unless asked.
