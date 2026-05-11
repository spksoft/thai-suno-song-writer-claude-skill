---
name: thai-suno-songwriter
description: Generate Suno AI prompts in Thai, English, or bilingual Thai+English. Use when user mentions Suno, AI music, แต่งเพลงด้วย AI, สร้างเพลงไทย, write a song for Suno, T-pop/Thai pop/Thai rock, or English pop/rock/country/hip-hop/R&B/folk/EDM. Triggers "ช่วยแต่งเพลง suno", "อยากทำเพลงไทย AI", "เขียน prompt สำหรับ suno", "Thai lyrics for Suno", "write English song for Suno", "bilingual T-pop", or any songwriting request for AI music. Produces Lyrics + Styles + Title + sliders + four-layer directives (section, vocal-bracket, inline parens, Thai phonetic respelling) for v4.5/v5/v5.5. Applies Thai conventions (tonal-melodic alignment, ฉันทลักษณ์, Rhyme×Tone matrix) and English conventions (Pattison prosody, rhyme types, hook placement). Warns about เพี้ยน for Thai with phonetic-respelling fallback, homographs for English. Runs rhyme audits (สัมผัสนอก/ใน, perfect/family/assonance), language anchoring for bilingual songs, and Suno-Thai expectation framing.
---

# Thai + English Suno Songwriter (v2 — directive-aware)

Help the user create a complete, ready-to-paste prompt set for Suno AI in Thai, English, or a Thai+English mix. The output goes into four Suno fields plus three sliders, with **four directive layers** woven into the Lyrics field for performance control.

## Reality check before we start (Suno + Thai)

Suno trains best on **English, Spanish, Portuguese, French, Japanese, Korean, Mandarin**. **Thai is in the lesser-represented tier** — take 1 will often have at least one เพี้ยน line, drifted accent, or flattened tone. This skill:

- Flags risk patterns BEFORE you generate (Step 7 audits)
- Offers in-Thai-script phonetic respelling for high-risk words (Step 3.5-E)
- Sets expectation in the final output that 2–3 regenerations may be needed
- Recommends Persona/Voices for series work to lock pronunciation across songs

If the user only wants take 1 to be perfect, the skill is the wrong tool — Suno itself isn't ready for that in Thai yet.

## What Suno needs (the target output)

The user will paste the skill's output into Suno's Advanced/Custom mode, which has these fields:

| Field | What it is | Limit (v5) | Limit (v4.5/v5.5) |
|---|---|---|---|
| **Lyrics** | Lyrics with `[Section]` headers, `(backing vocals)` echoes, and four directive layers | 5,000 chars | 5,000 chars |
| **Styles** | Comma-separated tags in 5-part formula | **200 chars (silent truncation)** | 1,000 chars |
| **Song Title** | Cosmetic name | 80 chars | 80 chars |
| **Vocal Gender** | Male / Female toggle | binary | binary |
| **Weirdness** | 0–100% slider | recommend per genre | recommend per genre |
| **Style Influence** | 0–100% slider | recommend per genre | recommend per genre |

The skill always asks the user about their concept first, then produces all six in one consolidated answer.

## Workflow (9 steps — do these in order)

```
Step 1   — Elicit the concept
Step 2   — Read the relevant reference files
Step 3   — Compose the lyrics
Step 3.5 — Layer in directives (NEW)
Step 4   — Compose the Styles description (5-part formula)
Step 5   — Recommend slider settings
Step 6   — Generate the Song Title
Step 6.5 — Auto-detect language for audit routing
Step 7   — Run the audits (incl. 7-A2 Rhyme×Tone, 7-F directive overload, 7-G Thai expectation)
Step 8   — Output the consolidated answer
```

### Step 1 — Elicit the concept (always ask)

Even if the user gives a one-line request, ask the questions below before writing anything. Use the `ask_user_input_v0` tool when available; otherwise ask in prose with numbered options.

Ask these (combine into one tool call — split into 2 only if more than 3 questions are needed):

1. **หัวข้อ/เรื่อง / Topic** — what is the song about?
2. **อารมณ์ / Mood** — `เศร้า/อกหัก` · `รัก/หวาน` · `ฮึกเหิม/สู้ชีวิต` · `เหงา/คิดถึง` · `สนุก/ปาร์ตี้` · `โกรธ/ระบาย` · `อื่นๆ`
3. **แนวเพลง (sub-genre)** — Thai: `T-pop ballad` · `Thai pop-rock / stadium rock` · `Thai indie / bedroom pop` · `City pop / 80s synth` · `Phleng phuea chiwit` · `Pop-punk` · `R&B / city ballad` · `Luk thung / mor lam fusion`. English: `pop ballad` · `pop upbeat` · `rock` · `country` · `hip-hop / trap` · `R&B / neo-soul` · `folk` · `indie` · `EDM` · `lo-fi` · `blues`
4. **ภาษา / Language** — `ไทยล้วน` · `ไทยเป็นหลัก + อังกฤษบางท่อน` · `ครึ่งไทยครึ่งอังกฤษ` · `อังกฤษล้วน`
5. **เพศนักร้อง / Vocal** — `Male` / `Female` / `ดูเอ็ท`
6. **ความยาว / Length** — `สั้น (~2 นาที)` / `มาตรฐาน (~3:30)` / `ยาว (~5 นาที)`

Skip a question only if the user already answered it explicitly. **Don't guess on language ratio** — it changes the lyric structure and which reference files to load.

### Step 2 — Read the relevant reference files

Before writing, view files based on language and sub-genre choices. **Read only what's needed** — two-tier loading is intentional.

**Always read:** `references/suno-platform.md` (fields, directive grammar, three-layer vocal spec, Persona/Voices/Extend/Song Editor workflows, sliders).

**If Thai content (any option except อังกฤษล้วน):**
- `references/thai-tone-craft.md` (tonal-melodic alignment, 10 เพี้ยน patterns, Rhyme × Tone matrix)
- `references/thai-rhyme-craft.md` (สัมผัสนอก/ใน, vowel families, schemes, rhyme audit)
- `references/thai-genre-craft.md` (genre lyrical conventions, vocabulary banks, Style templates)
- `references/thai-phonetic-respelling.md` (load only when Step 7-A flags problem words requiring respelling)

**If English content (any option except ไทยล้วน):**
- `references/english-prosody-rhyme.md` (stress, rhyme craft, diction audit)
- `references/english-genre-craft.md` (forms, frameworks, genre conventions, Style templates)

**If bilingual (ไทยเป็นหลัก / ครึ่งไทยครึ่งอังกฤษ):**
- `references/bilingual-mixing.md` (language anchoring, echo translation, drift declaration)

**Optional — only on user request:**
- `references/thai-lyricist-signatures.md` (when user asks "เขียนแบบดี้ / ฟองเบียร์ / ครูสลา / บอย / สุรักษ์")
- `references/thai-hit-songs.md` (when user names a song or asks for a sub-genre matching one: Cocktail / Bowkylion / Tilly Birds / GUNGUN / Flure)
- `references/thai-examples.md` (Thai worked examples — only when user asks or skill needs format reference)
- `references/english-examples.md` (English/bilingual worked examples)

### Step 3 — Compose the lyrics

Standard structure for ~3:30 song (adjust for length):

```
[Intro]
[Verse 1]        ← 4 lines
[Pre-Chorus]     ← 2–3 lines (optional but adds lift in pop/R&B)
[Chorus]         ← 4–6 lines, hook on line 1 and line 4
[Verse 2]        ← 4 lines, expand or shift the scene
[Pre-Chorus]
[Chorus]         ← write out in full again (don't reference)
[Bridge]         ← 2–4 lines, contrasting perspective
[Chorus]         ← write out in full a third time
[Outro]
```

For bilingual songs, **anchor every section** with `(Thai)` or `(English)` after the bracketed tag (see `bilingual-mixing.md` §1).

**Universal lyric-craft rules (both languages):**
- Use the **script of the language**: Thai script for Thai, Latin script for English. Never romanize Thai (confuses Suno's tokenizer). For Thai disambiguation needs, use `thai-phonetic-respelling.md` — stays in Thai script.
- **Repeat the chorus identically** when it appears 2nd/3rd time. Suno doesn't loop a labeled section reliably.
- **Backing vocals/echoes in `(parentheses)`** — sung as harmony/echo, lower in the mix.
- **Section directives in `[brackets]`** — NOT sung. Use for `[Soft piano]`, `[Guitar solo]`, etc.
- **First-5-Seconds rule**: verse 1 opens with a concrete image or specific noun, not abstract emotion.

**Thai-specific composition rules** (`thai-tone-craft.md` + `thai-rhyme-craft.md`):
- **6–12 syllables per line.** Beyond 12 forces compression and tones collapse.
- **Pick the chorus rhyme family first.** Then check it against the Rhyme × Tone matrix in `thai-tone-craft.md` §7. If RISK¹ (falling tone on chorus end), plan for commit-to-the-fall (`thai-tone-craft.md` §8).
- **สัมผัสใน (internal rhyme):** at least one per chorus line.
- **(Parens echoes) in Thai chorus must rhyme with the line above.**

**English-specific composition rules** (`english-prosody-rhyme.md` + `english-genre-craft.md`):
- **Line length**: verse 8–10 syllables; chorus 10–12. Hard ceiling 15.
- **Stress-to-downbeat**: stressed syllables on strong beats.
- **Six rhyme types** (Pattison): perfect → family → additive → subtractive → assonance → consonance.
- **Chorus rhyme density**: 50–75% (lower than verse).
- **Hook placement**: title in chorus line 1, last line, both (bookended), or every line.
- **Avoid cliché pairs**: fire/desire, heart/apart, eyes/lies, love/above.
- **Show, don't tell**: concrete nouns, sensory detail, action verbs.

**Bilingual composition rules** (`bilingual-mixing.md`):
- **Anchor every section** with `(Thai)` or `(English)`.
- **No same-line code-switching.** Within a single sung lead line, use ONE language.
- For Thai-primary songs with English chorus echoes: keep echoes short (1–5 syllables) and rhyming with the line above.
- If the lyric is >70% one language, add a drift declaration to the Style field.

### Step 3.5 — Layer in directives (NEW)

Once lyrics exist, apply the four directive layers in this order. See `suno-platform.md` §3–6 for the full reference.

**A. Section directives (bracket)** — already present from Step 3.
```
[Intro] [Verse 1] [Chorus] [Bridge] [Outro]
[Soft piano] [Guitar solo] [Half-time feel]
```

**B. Vocal performance directives (bracket, one per section maximum)** — pick from the three-layer vocal spec (see `suno-platform.md` §4c).
```
[Belted] [Whispered] [Falsetto] [Stacked Vocals] [Spoken Word] [Staccato]
```

**C. Inline parenthetical performance cues (in-line, sparingly)** — NEW in 2025+. Placed BEFORE the line they modify, on its own line. Max ONE per section.
```
(whispered) ฉันยังคิดถึงเธอ
(belted) อยากบอกให้เธอเข้าใจ
(building intensity) แม้จะเหนื่อยแค่ไหน ก็ต้องไป
(stripped back) ถ้าหากวันนึง...
```

Available inline cues: `(whispered)` · `(belted)` · `(spoken word)` · `(harmonized)` · `(ad-lib)` · `(falsetto)` · `(building intensity)` · `(stripped back)` · `(key change)` · `(half-time feel)` · `(breath)` · `(hold)`.

**D. Backing-vocal echoes (in-line, parens after the lead line)** — unchanged.
```
อยากบอกเธอว่ารัก (ว่ารัก ว่ารัก)
```

**E. Thai phonetic respelling (in-line, where pronunciation risk is flagged)** — applied IN THAI SCRIPT for problem syllables flagged by Step 7-A. See `thai-phonetic-respelling.md`.
```
ปลายทาง → ปฺลายทาง        ← cluster disambiguation
สิริ → สิ-หฺริ              ← proper-name syllable lock-in
ไร้กาลเวลา → ไร้-กาน-เว-ลา   ← Pali compound syllabification
```

Respelled forms go into the Lyrics field; the original form is surfaced in the Step 8 `🎙️ Directives used` block so the user sees both.

**F. v5+ meta tags at top of Lyrics field (bracket, optional)** — soft hints. Max 3.
```
[Mood: Melancholic]
[Vocal Style: Soft Female]
[Energy: Building]
[Texture: Sparse → Full]
[Callback: chorus melody]
```

**Hard cap:** total directive density should leave ≥70% of the Lyrics field as sung text. If directives exceed 30% of the field, drop in this order: meta tags first, then inline cues, then bracket vocal cues. Never drop section headers or backing-vocal echoes.

### Step 4 — Compose the Styles description (5-part formula)

Comma-separated tags in five buckets, in this order:

```
1. Genre / Subgenre
2. Mood & Energy
3. Vocal Direction (three-layer spec: Character + Delivery + Effects)
4. Instrumentation (2–3 instruments)
5. Production & Tempo
```

**Target 8–15 tags total**, ≈150–250 chars (raised from old 4–8 guidance per 2026 community-validated practice). Hard ceiling 20 — beyond that, Suno ignores some tags non-deterministically.

**Three-layer vocal spec** (`suno-platform.md` §4c): pick one Character + one Delivery + one Effects.
- Character: `raspy male tenor`, `clean female soprano`, `gritty baritone`, `breathy alto`, `weathered tenor with character`...
- Delivery: `belted full-voice`, `breathy whispered`, `spoken word`, `melismatic with vibrato`...
- Effects: `reverb-drenched close-mic`, `dry studio`, `tape saturation`, `polished radio mix`...

**⚠ Character budget warning**: v5 hard-limits Style at 200 chars (silent truncation). v5.5 and v4.5 allow 1,000. If targeting v5 and the string is >200, either trim or recommend switching to v5.5. Front-load critical tags (genre, mood, vocal) so they survive truncation.

**Always include a diction cue at the end:**
- **Thai**: `clear native Thai diction` or `Thai vocals in Bangkok accent, no English drift` (for luk thung: `central Thai with Isan flavor`).
- **English**: `crisp English diction`, `clear American English vocals`, or regional variant.
- **Bilingual**: append `Thai vocals primary with English chorus echoes` or similar drift declaration.

**Never use real artist names** — Suno blocks Thai AND Western artists silently. Use sonic descriptors. For Thai sub-genre templates see `thai-genre-craft.md`; for English see `english-genre-craft.md`.

### Step 5 — Recommend slider settings

Based on the chosen sub-genre, look up Weirdness + Style Influence values in `suno-platform.md` §9 (separate Thai and English tables). The table also appears below — keep both in sync if either is edited.

| Sub-genre (Thai) | Weirdness | Style Influence |
|---|---|---|
| Mainstream T-pop / radio pop | 25–35% | 70–85% |
| Thai pop-rock / stadium rock | 35–50% | 65–80% |
| Indie / Bangkok bedroom pop | 50–65% | 55–70% |
| City pop / 80s pastiche | 20–30% | 80–95% |
| Phleng phuea chiwit | 30–45% | 65–80% |
| Pop-punk | 35–50% | 65–80% |
| R&B / city ballad | 25–40% | 70–85% |
| Luk thung / mor lam fusion | 40–60% | 60–75% |

| Sub-genre (English) | Weirdness | Style Influence |
|---|---|---|
| Mainstream pop (ballad or upbeat) | 25–35% | 70–85% |
| Rock / pop-rock | 35–50% | 65–80% |
| Indie (folk-pop / bedroom-pop) | 50–65% | 55–70% |
| Modern country / Nashville | 25–35% | 75–88% |
| Hip-hop / boom-bap / trap | 40–55% | 60–75% |
| R&B / neo-soul | 25–40% | 70–85% |
| Folk / singer-songwriter | 30–45% | 65–80% |
| EDM / progressive house / synthwave | 30–45% | 70–85% |
| Lo-fi / chill | 35–50% | 65–80% |
| Blues / blues-rock | 30–45% | 70–85% |

Always state the chosen number, not a range, in the final output. Pick the midpoint unless the user specified "experimental" or "very mainstream."

### Step 6 — Generate the Song Title

The title is cosmetic in Suno (does not influence audio), but the user will see it.

- 2–6 Thai words (or short English / Thai+English mix) for Thai songs
- 2–6 English words for English songs
- Echoes the chorus hook phrase, OR uses a memorable image from the lyrics
- ≤30 Thai chars / ≤40 English chars is comfortable

### Step 6.5 — Auto-detect language for audit routing

After composing, scan the produced lyric to determine which audits to run. **Auto-detection is the authority** — even if the user picked "ไทยล้วน" at Step 1.4, if the lyric ends up containing English content, the English audits still run.

**Detection algorithm:**
1. Strip `[bracket directives]` (they don't count).
2. Strip pure ad-lib `(parens)` echoes ("oh oh oh", "la la la", "yeah", "uh").
3. For each remaining sung line, count Thai script chars (U+0E00–U+0E7F) and Latin letters.
4. Sum across all lines (excluding section markers, language anchors `(Thai)` / `(English)`, and v5+ meta tags).
5. Set flags:
   - `audit_thai_pian` = (thai_chars ≥ 20)
   - `audit_thai_khlong` = (thai_chars ≥ 20)
   - `audit_thai_tone_matrix` = (thai_chars ≥ 20) — Step 7-A2
   - `audit_english_prosody` = (latin_chars ≥ 20)
   - `audit_english_rhyme` = (latin_chars ≥ 20)
   - `audit_bilingual_mixing` = (thai_chars ≥ 20 AND latin_chars ≥ 20)
   - `audit_directive_overload` = always true (Step 7-F)
   - `audit_thai_expectation` = (thai_chars ≥ 20) — Step 7-G; not a flag-emitter, just emits framing block

**If the user's Step 1.4 choice contradicts detection** — surface a soft warning: "พบเนื้อหาภาษาอังกฤษในเพลงทั้งที่เลือก 'ไทยล้วน' — รัน English audit เพิ่มเติมให้ด้วย."

### Step 7 — Run the audits

Each audit follows "warn, don't auto-fix." State the line, the issue, suggest a rewrite — let the user choose. Each audit runs independently.

**7-A. Thai เพี้ยน Risk** (if `audit_thai_pian`) — apply `thai-tone-craft.md` §4 (10 patterns).

**7-A2. Rhyme × Tone matrix check** (if `audit_thai_tone_matrix`) — apply `thai-tone-craft.md` §7 matrix to each chorus end-word. Flag RISK¹ / RISK² / CAUTION³ cells with survival strategies.

**7-B. English Pronunciation Risk** (if `audit_english_prosody`) — apply `english-prosody-rhyme.md` §3 (10 diction patterns).

**7-C. Thai คำคล้องจอง Audit** (if `audit_thai_khlong`) — apply `thai-rhyme-craft.md` §7.

**7-D. English Rhyme & Form Audit** (if `audit_english_rhyme`) — apply `english-prosody-rhyme.md` §2 (schemes, hook placement, density, cliché pairs).

**7-E. Bilingual Mixing Audit** (if `audit_bilingual_mixing`) — apply `bilingual-mixing.md` §7.

**7-F. Directive overload audit** (always) — count inline `(parens)` cues per section. Flag if more than one inline cue appears in a single section. Flag if more than 3 meta tags total. Flag if directive density >30% of Lyrics-field chars.

**7-G. Suno-Thai expectation framing** (if `audit_thai_expectation`) — not a flag-emitter. Always emits the expectation block in Step 8 to set user expectation for 2–3 regenerations.

**Severity → summary mapping** (each flag-emitting audit independently):

| Flag count | Summary |
|---|---|
| 0 | `clean` |
| 1–2 | `minor` |
| 3–5 | `rework_recommended` |
| 6+ | `redraft_needed` |

Never aggregate counts across audits — keep them independent.

### Step 8 — Output the consolidated answer

Use this exact template. Section headers and ordering are load-bearing — new blocks are additive between existing ones; do not reorganize legacy blocks.

```
## 🎵 [Song Title]

### 📋 Styles (paste into Styles field)

```
[5-part comma-separated tags here]
```
[⚠ N chars · note v5 budget warning if N > 200]

### 📝 Lyrics (paste into Lyrics field)

```
[optional v5+ meta tags at top: [Mood: ...] etc.]

[Intro]
[Verse 1] [(Thai) or (English) — only emit when bilingual]
...
[Outro]
```

### ⚙️ Settings

- **Vocal Gender:** [Male / Female / Duet]
- **Weirdness:** [X]%
- **Style Influence:** [Y]%
- **Model:** [v4.5+all / v5 / v5.5]

### 🎙️ Directives used                          ← NEW

[Render only when ≥1 non-section-header directive was applied. One line per non-trivial directive.]

- [Belted] บน [Chorus] → ให้ Suno เร่งพลังเสียงในฮุก
- (whispered) บน [Verse 1] line 1 → เปิดเพลงด้วยน้ำเสียงเบา intimate
- [Mood: Melancholic] meta tag → soft hint สีอารมณ์ (v5+ only)
- "ปฺลายทาง" — phonetic respelling ของ "ปลายทาง" เพื่อรักษา cluster ปล-

[If no extra directives applied:]
ใช้แค่ section headers พื้นฐาน — ไม่ได้ใส่ directive performance พิเศษ

### 🇹🇭 ความคาดหวังกับ Suno สำหรับเพลงไทย          ← NEW (Thai-content songs only)

[Render ONLY when audit_thai_expectation is true. Soft framing, not a flag.]

Suno ฝึกเก่งสุดกับภาษา English / Spanish / Portuguese / French / Japanese / Korean / Mandarin — ภาษาไทยอยู่ในกลุ่ม lesser-represented languages คาดหวังว่า take 1 อาจมีคำที่ออกเสียงไม่ตรงเป๊ะ (เพี้ยนเสียงสระ / สูญหายพยัญชนะต้น / โทนเสียงแบนไป)

แนวทางที่ใช้ได้: regenerate 2–3 takes แล้วเลือก take ที่ดีที่สุด; สำหรับบรรทัดที่เพี้ยนเฉพาะจุด ใช้ Replace Section ใน Song Editor; ถ้าเพลงนี้ใช้ดีแล้วและจะแต่งเพลงต่อในชุดเดียวกัน กด Make Persona เพื่อ lock น้ำเสียงและสำเนียง

[If audit_thai_pian AND NOT audit_english_prosody — preserve legacy Thai-only header bit-identical:]
### ⚠️ เพี้ยน Risk Flags

- บรรทัด "...": [issue], แนะนำเปลี่ยนเป็น "..."
- (or `ไม่พบจุดเสี่ยงสำคัญ` if clean)

[If audit_thai_pian AND audit_english_prosody — bilingual case, disambiguate:]
### ⚠️ Pronunciation Risk Flags (Thai — เพี้ยน)

- บรรทัด "...": [issue], แนะนำเปลี่ยนเป็น "..."
- (or `ไม่พบจุดเสี่ยงสำคัญ` if clean)

[If audit_english_prosody:]
### ⚠️ Pronunciation Risk Flags (English)

- Line "...": [issue], suggest rewriting as "..."
- (or `No major risks detected` if clean)

[If audit_thai_khlong AND NOT audit_english_rhyme — preserve legacy Thai-only header:]
### 🎼 คำคล้องจอง Audit

- บรรทัด "...": [rhyme issue], แนะนำเปลี่ยนเป็น "..."
- (or `scheme คำคล้องจอง ครบ — [details]` if clean)

[If audit_thai_khlong AND audit_english_rhyme — bilingual case, disambiguate:]
### 🎼 Rhyme Audit (Thai — คำคล้องจอง)

- บรรทัด "...": [rhyme issue], แนะนำเปลี่ยนเป็น "..."
- (or `scheme คำคล้องจอง ครบ — [details]` if clean)

[If audit_thai_tone_matrix AND a RISK/CAUTION cell was flagged:]
### 🎵 Rhyme × Tone Matrix note (Thai)         ← NEW sub-block

- ฮุก "...": (family) × (tone) = RISK¹ — แนะนำ commit-to-the-fall (ดู thai-tone-craft.md §8) หรือเปลี่ยน end-word เป็น tone กลาง: ["alt1", "alt2"]

[If audit_english_rhyme:]
### 🎼 Rhyme Audit (English)

- Line "...": [rhyme/form issue], suggest "..."
- (or `Rhyme scheme: [X]; hook placement: line [N]; no major issues` if clean)

[If audit_bilingual_mixing:]
### 🌐 Bilingual Mixing Audit

- Line "...": [issue], suggest "..."
- (or `Section anchors present; no same-line code-switching detected` if clean)

[Always emit if 7-F found anything; otherwise omit:]
### 🚦 Directive Overload Audit

- [Verse 1]: พบ inline cues 2 ตัว (whispered + ad-lib) — แนะนำเลือก 1 ตัว
- (or omit if clean)

### 🔁 Iteration Tips

ถ้า take 1 ไม่ใช่:
- ถ้า vibe ไม่ใช่: เพิ่ม Style Influence เป็น [Y+10]%, ลด Weirdness เป็น [X-10]%
- [language-aware tips per detected audits]
- ถ้าอยากให้ track จำเสียงนี้: กด ⋮ → Make Persona ก่อน iterate
- ถ้าเพลงดีแล้วแต่อยากยาวขึ้น: ใช้ Extend จากท้าย outro (ระวัง tone drift สำหรับเพลงไทย — extend ก่อน hook, ไม่ใช่หลัง)
- [Thai-specific] ถ้าบรรทัดใดเพี้ยน: Replace Section ใน Song Editor + apply phonetic respelling
```

**Rendering rules:**
- Audit blocks render in this order: **Directives used → Thai expectation → Thai-pron → English-pron → Thai-rhyme → Rhyme×Tone matrix note → English-rhyme → Bilingual mixing → Directive overload → Iteration tips**. The order is fixed.
- When no flags found for a language's audit, the block still renders with the "clean" message (so the user knows the audit was run and passed).
- When no content for a language exists, the block is **omitted entirely**, not rendered empty.
- The `⚠ [N] chars` budget line on Styles renders only when the Styles string is >150 chars.
- Section anchors `(Thai)` / `(English)` after `[Verse 1]` etc. ONLY appear in bilingual songs.
- Legacy Thai-only headers `### ⚠️ เพี้ยน Risk Flags` and `### 🎼 คำคล้องจอง Audit` are preserved bit-identical for the pure-Thai output case (no regression).

## Edge cases and special handling

**If the user already has lyrics they wrote:** skip Step 3 (composition). Run Step 3.5 to add directive layers. Auto-detect language in Step 6.5. Run all applicable audits in Step 7. Produce the rest of the prompt set. If a rhyme scheme is systematically absent (Thai: no คำคล้องจอง scheme; English: no detectable end-rhyme in a melodic genre), say so explicitly and offer to refactor — wait for user approval before rewriting.

**If the user wants only instrumental:** check Suno's "Instrumental" toggle; Lyrics field stays empty (or only `[Instrumental]` tags). Still produce Styles, Title, sliders. No audits run.

**If the user gives a reference song** ("ทำเพลงให้คล้าย ABC ของศิลปิน X"): NEVER copy lyrics; NEVER name the artist in Styles. Translate the *sonic descriptors* (era, instruments, mood, BPM) into the Styles field. For documented case studies (Cocktail / Bowkylion / Tilly Birds / GUNGUN / Flure), see `thai-hit-songs.md`. Apply the no-artist-names rule from `suno-platform.md` §15.

**If the user is on Free tier:** they're on v4.5-all (the free variant). Output works identically — but warn if they're trying to use v5 features they don't have. Inline parens cues are recognized inconsistently on v4.5 family — prefer bracket vocal cues for that tier.

**Targeting v5 (200-char Style limit):** if the composed Styles string is >200 chars, either trim or recommend switching to v5.5. Don't silently let truncation happen.

**For luk thung / mor lam fusion:** Suno's Thai-Isan diction is weakest here. Add aggressive pronunciation cues (`central Thai with Isan flavor, melismatic vocals with wide vibrato`), and warn the user that 2–3 regenerations are often needed for usable Isan delivery.

**If the user asks for a duet / two singers:** put both genders in Styles (`mixed-gender vocals, male and female duet`); use `[Female Vocal]` / `[Male Vocal]` tags inside lyrics on the lines where each voice should lead. Vocal Gender toggle on whichever voice opens the song.

**If the user asks for a specific lyricist style** ("เขียนแบบฟองเบียร์ / ดี้ / ครูสลา / บอย / สุรักษ์"): load `thai-lyricist-signatures.md` and apply that lyricist's signature rules. Note in the output framing that the technique is being applied.

**If the user wants phonetic respelling**: only apply to words flagged in Step 7-A. Load `thai-phonetic-respelling.md`. Surface both original and respelled forms in `🎙️ Directives used` block so the user can choose.

**If the user wants Persona / Voices workflow**: see `suno-platform.md` §11. Persona-lock is the single most impactful technique for Thai series/EP work.

**Bilingual edge cases:**
- *Primarily-English song with one Thai word* — flag as same-line code-switching; suggest splitting or moving Thai to a (parens echo).
- *Title in one language, body in another* — fine, but anchor sections clearly.
- *User wants Korean/Japanese/Spanish mixed in* — the skill does not audit those languages. Apply the section-anchoring + echo-translation patterns from `bilingual-mixing.md`, but explain that no dedicated phonetic audit will run. **The "never romanize Thai" rule still applies** — only the bilingual languages mentioned in `bilingual-mixing.md` §6 use romanization, and that's a description of their conventions, not a Thai recommendation.

**Length adjustments:**
- Short (~2 min) — drop the second verse and bridge: `[Intro] [Verse 1] [Chorus] [Verse 2] [Chorus] [Outro]`
- Long (~5 min) — add `[Instrumental Break]` or `[Guitar Solo]` (2–8 bars) before the bridge; consider a modulated final chorus

## Communication style

Match the user's language. Most users come in Thai — answer in Thai. If the user uses informal register, match it; otherwise default to friendly polite Thai. If the user uses English, answer in English. The output template (Styles/Lyrics/Settings/audits) stays in the standard format above regardless of conversation language.

When showing the final output, lead with a 1-sentence framing in the user's language ("นี่คือชุด prompt สำหรับ Suno ครับ คัดลอกแต่ละช่องไปวางในแอปได้เลย" / "Here's your Suno prompt set — paste each block into the matching field"), then the template, then iteration tips. Don't re-explain why each choice was made unless asked.
