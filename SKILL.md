---
name: thai-suno-songwriter
description: Generate ready-to-paste prompts for Suno AI to create Thai-language songs, English-language songs, or bilingual Thai+English songs. Use this skill whenever the user mentions Suno, AI music generation, แต่งเพลงด้วย AI, สร้างเพลงไทย, write a song for Suno, generate song lyrics for AI, T-pop/Thai pop/Thai rock songwriting, English pop/rock/country/hip-hop/R&B/folk songwriting, or wants to produce the full Lyrics + Styles + Title + slider settings (Vocal Gender, Weirdness, Style Influence) for Suno v4.5/v4.5+/v4.5-all/v5/v5.5. Trigger this skill on any phrase like "ช่วยแต่งเพลง suno", "อยากทำเพลงไทย AI", "เขียน prompt สำหรับ suno", "Thai song lyrics for Suno", "write me an English song for Suno", "Suno prompt for a country ballad", "make a bilingual T-pop song", or any request that combines songwriting with an AI music generator — even if Suno isn't named explicitly. The skill produces output formatted for direct paste into Suno's Custom Mode fields, follows Thai pop/rock conventions (tonal-melodic alignment, ฉันทลักษณ์, common chord-progression-friendly phrasing) AND English pop/rock/country/hip-hop conventions (Pattison-style prosody, English rhyme types, hook bookending, genre-specific structure), warns about likely tone-mispronunciation (เพี้ยน) risks for Thai, English homograph and singability risks for English, runs rhyme audits in both languages with their respective phonetic rules (สัมผัสนอก/ใน for Thai, perfect/family/assonance for English), enforces language anchoring for bilingual songs, and gives iteration tips.
---

# Thai + English Suno Songwriter (bilingual)

Help the user create a complete, ready-to-paste prompt set for Suno AI in Thai, English, or a Thai+English mix. The output goes into four Suno fields plus three sliders.

## What Suno needs (the target output)

The user will paste the skill's output into Suno's Advanced/Custom mode, which has these fields:

| Field | What it is | Limit (v5) | Limit (v4.5/v5.5) |
|---|---|---|---|
| **Lyrics** | Lyrics with `[Section]` headers and `(backing vocals)` in parens | 5,000 chars | 5,000 chars |
| **Styles** | Comma-separated genre/mood/instrument tags | **200 chars (silent truncation)** | 1,000 chars |
| **Song Title** | Cosmetic name | 80 chars | 80 chars |
| **Vocal Gender** | Male / Female toggle | binary | binary |
| **Weirdness** | 0–100% slider | recommend per genre | recommend per genre |
| **Style Influence** | 0–100% slider | recommend per genre | recommend per genre |

The skill always asks the user about their concept first, then produces all six in one consolidated answer.

## Workflow (do these steps in order)

### Step 1 — Elicit the concept (always ask)

Even if the user gives a one-line request, ask the questions below before writing anything. Use the `ask_user_input_v0` tool when available so the user can tap answers on mobile; otherwise ask in prose with numbered options.

Ask these (combine into one tool call — split into 2 calls only if more than 3 questions are needed):

1. **หัวข้อ/เรื่อง / Topic** — what is the song about? (free text, encourage 1 sentence)
2. **อารมณ์ / Mood** — pick one: `เศร้า/อกหัก` · `รัก/หวาน` · `ฮึกเหิม/สู้ชีวิต` · `เหงา/คิดถึง` · `สนุก/ปาร์ตี้` · `โกรธ/ระบาย` · `อื่นๆ (ระบุ)`
3. **แนวเพลง (sub-genre)** — Thai: `T-pop ballad` · `Thai pop-rock / stadium rock` · `Thai indie / bedroom pop` · `City pop / 80s synth` · `Phleng phuea chiwit / folk-rock` · `Pop-punk` · `R&B / city ballad` · `Luk thung / mor lam fusion`. English: `pop ballad` · `pop upbeat` · `rock / pop-rock` · `country / Nashville` · `hip-hop / trap` · `R&B / neo-soul` · `folk / singer-songwriter` · `indie` · `EDM / dance` · `lo-fi / chill` · `blues`
4. **ภาษา / Language** — pick one: `ไทยล้วน (Thai only)` · `ไทยเป็นหลัก + อังกฤษบางท่อน (Thai primary + English echoes/bridge)` · `ครึ่งไทยครึ่งอังกฤษ (50/50 bilingual)` · `อังกฤษล้วน (English only)`
5. **เพศนักร้อง / Vocal** — `Male` / `Female` / `ดูเอ็ท / Duet`
6. **ความยาว / Length** — `สั้น (~2 นาที)` / `มาตรฐาน (~3:30)` / `ยาว (~5 นาที)`

Skip a question only if the user already answered it explicitly. If unsure, ask. **Don't guess on language ratio** — that decision changes the lyric structure and which reference files to load.

The user's language pick is a *hint*. Auto-detection in Step 6.5 is the *authority* — if produced lyric ends up containing a language the user didn't ask for, the relevant audits still run, with a soft warning.

### Step 2 — Read the relevant reference files

Before writing, view files based on language and sub-genre choices. **Read only what's needed** — two-tier loading is intentional.

**Always read:** `references/suno-fields-reference.md` (tags, sliders, formatting rules).

**If Thai content (ไทยล้วน / ไทยเป็นหลัก / ครึ่งไทยครึ่งอังกฤษ):**
- `references/tonal-melodic-rules.md` (เพี้ยน prevention principles)
- `references/pian-risk-checklist.md` (10-pattern เพี้ยน audit)
- `references/khlong-jong-rhyme.md` (สัมผัสนอก/ใน, vowel families, rhyme audit)
- `references/genre-lyric-conventions-th.md` (Thai genre lyrical conventions, vocabulary banks)
- `references/style-templates-th.md` (Thai sub-genre Style strings)

**If English content (อังกฤษล้วน / ไทยเป็นหลัก / ครึ่งไทยครึ่งอังกฤษ):**
- `references/song-structure-en.md` (forms, section functions, BPM per genre)
- `references/lyric-frameworks-en.md` (Pattison, Davis, Sondheim, Stolpe — frameworks)
- `references/rhyme-craft-en.md` (six rhyme types, schemes, hook placement)
- `references/prosody-meter-en.md` (English stress-timing, foot, word painting)
- `references/english-diction-checklist.md` (10-pattern English pronunciation audit)
- `references/genre-conventions-en.md` (English genre lyrical conventions)
- `references/style-templates-en.md` (English sub-genre Style strings)

**If bilingual (ไทยเป็นหลัก / ครึ่งไทยครึ่งอังกฤษ):**
- `references/bilingual-mixing.md` (language anchoring, echo translation, drift declaration)

**Optional — only on user request:**
- `references/lyricist-signatures-th.md` (when user asks "เขียนแบบดี้ / ฟองเบียร์ / ครูสลา / บอย / สุรักษ์")
- `references/examples-th.md` (Thai worked examples — only when user asks for example or skill is unsure of format)
- `references/examples-en.md` (English/bilingual worked examples — same condition)

Reading these is fast and avoids guessing on tag names, slider numbers, pronunciation pitfalls, and rhyme scheme construction.

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

- **Use the script of the language**: Thai script for Thai content; Latin script for English content. Never romanize Thai (confuses Suno's tokenizer).
- **Repeat the chorus identically** when it appears 2nd/3rd time. Suno doesn't loop a labeled section by reference; if `[Chorus]` is empty after a verse, Suno improvises (badly).
- **Backing vocals/echoes in `(parentheses)`** — they get sung as harmony/echo, lower in the mix.
- **Section directives in `[brackets]`** — NOT sung. Use for `[Soft piano]`, `[Guitar solo]`, etc.
- **First-5-Seconds rule**: verse 1 must open with a concrete image or specific noun, not abstract emotion. Pattison's "show, don't tell"; ครูสลา's lukthung principle.

**Thai-specific composition rules** (from `references/tonal-melodic-rules.md` + `references/khlong-jong-rhyme.md`):

- **6–12 syllables per line**. More than 12 forces compression and tones collapse.
- **Apply tonal-melodic alignment**: the chorus hook line is most important — pick title words whose tones flow with a singable melodic shape.
- **คำคล้องจอง (Thai rhyme) — load-bearing, not optional.** Compose the chorus end-rhyme first (pick vowel family with many partners: ใจ-family /ai/, มา-family /aː/, รัก-family /ak/ are workhorses). Apply AABB / ABAB / AABA schemes per section.
- **สัมผัสใน (internal rhyme):** at least one per chorus line.
- **(Parens echoes)** in Thai chorus must rhyme with the line above.

**English-specific composition rules** (from `references/rhyme-craft-en.md` + `references/prosody-meter-en.md` + `references/lyric-frameworks-en.md`):

- **Line length**: verse 8–10 syllables; chorus 10–12. Hard ceiling 15.
- **Stress-to-downbeat**: stressed syllables on strong beats (1 and 3); function words off strong beats.
- **Six rhyme types** (Pattison): perfect → family → additive → subtractive → assonance → consonance. Match closure to lyric content.
- **Chorus rhyme density**: 50–75% (lower than verse). Dense rhyme breaks Suno's melodic phrasing.
- **Hook placement**: title in chorus line 1, last line, both (bookended), or every line.
- **Avoid cliché pairs**: fire/desire, heart/apart, eyes/lies, love/above — switch to family or assonance.
- **Show, don't tell**: concrete nouns, sensory detail, action verbs. Avoid feeling-words (love, sad, lonely, broken) in stressed positions.

**Bilingual composition rules** (from `references/bilingual-mixing.md`):

- **Anchor every section** with `(Thai)` or `(English)`.
- **No same-line code-switching**: within a single sung lead line, use ONE language. The only sanctioned cross-language device is the parenthetical echo: `Lead line (echo translation)`.
- For Thai-primary songs with English chorus echoes: keep echoes short (1–5 syllables) and rhyming with the line above.
- If the lyric is >70% one language, add a drift declaration to the Style field (`All lyrics in [X], no [Y]`).

### Step 4 — Compose the Styles description

Format: comma-separated tags, in this order:

```
[Genre], [Sub-genre/Era], [Mood], [2–3 instruments], [Vocal cue], [Production], [BPM], [Diction cue]
```

Target 4–8 tags total, ≈150–250 chars.

**⚠ Character budget warning**: v5 hard-limits Style at 200 chars (silent truncation). v5.5 and v4.5 allow 1,000. If targeting v5 and the string is >200, either trim or recommend switching to v5.5. Front-load critical tags (genre, mood, vocal) so they survive truncation.

**Always include a diction cue at the end:**
- **Thai**: `clear native Thai diction` or `Thai vocals in Bangkok accent, no English drift` (for luk thung: `central Thai with Isan flavor`).
- **English**: `crisp English diction`, `clear American English vocals`, or regional variant (`country drawl`, `British accent leaning RP`).
- **Bilingual**: append `Thai verses with English chorus, no in-line mixing` or similar drift declaration.

**Never use real artist names** — Suno blocks Thai AND Western artists silently. Use sonic descriptors. For Thai sub-genres see `references/style-templates-th.md`; for English see `references/style-templates-en.md`.

### Step 5 — Recommend slider settings

Based on the chosen sub-genre, look up Weirdness + Style Influence values in `references/suno-fields-reference.md` (separate Thai and English tables).

Always state the chosen number, not a range, in the final output. Pick the midpoint of the range unless the user specified "experimental" or "very mainstream."

### Step 6 — Generate the Song Title

The title is cosmetic in Suno (does not influence audio), but the user will see it.

- 2–6 Thai words (or short English / Thai+English mix) for Thai songs
- 2–6 English words for English songs
- Echoes the chorus hook phrase, OR uses a memorable image from the lyrics
- ≤30 Thai chars / ≤40 English chars is comfortable

### Step 6.5 — Auto-detect language for audit routing (NEW)

After composing, scan the produced lyric to determine which audits to run. **Auto-detection is the authority** — even if the user picked "ไทยล้วน" at Step 1.4, if the lyric ends up containing English content, the English audits still run.

**Detection algorithm:**

1. Strip `[bracket directives]` (they don't count).
2. Strip pure ad-lib `(parens)` echoes ("oh oh oh", "la la la", "yeah", "uh").
3. For each remaining sung line, count Thai script chars (U+0E00–U+0E7F) and Latin letters.
4. Sum across all lines (excluding section markers like `Verse`, `Chorus`, `Bridge`, `Intro`, `Outro`, and language anchors `Thai`, `English`).
5. Set flags:
   - `audit_thai_pian` = (thai_chars ≥ 20)
   - `audit_thai_khlong` = (thai_chars ≥ 20)
   - `audit_english_prosody` = (latin_chars ≥ 20)
   - `audit_english_rhyme` = (latin_chars ≥ 20)
   - `audit_bilingual_mixing` = (thai_chars ≥ 20 AND latin_chars ≥ 20)

**If the user's Step 1.4 choice contradicts detection** — e.g., they picked "ไทยล้วน" but the lyric has substantial English — surface a soft warning in Step 8's framing: "พบเนื้อหาภาษาอังกฤษในเพลงทั้งที่เลือก 'ไทยล้วน' — รัน English audit เพิ่มเติมให้ด้วย."

### Step 7 — Run the audits (one per detected language, plus bilingual)

Each audit follows the "warn, don't auto-fix" rule: state the line, the issue, suggest a rewrite — let the user choose. Each audit is run independently and rendered as a separate block in Step 8.

**7-A. Thai เพี้ยน Risk** (if `audit_thai_pian`) — apply `references/pian-risk-checklist.md`:
- Lines >12 syllables → split
- Pali/Sanskrit compounds on fast sections → relocate or substitute
- Initial consonant clusters (ปร, กล, คว, ปฏ) on stressed beats → hyphenate or rewrite
- Mai-tho falling tone on long held notes → flag
- Numbers, English acronyms → write as Thai words
- Same-line code-switching → split or move English to (echo)
- Short vowels (อิ, อะ, อุ) on long held notes → switch to long vowels

**7-B. English Pronunciation Risk** (if `audit_english_prosody`) — apply `references/english-diction-checklist.md`:
- Homographs (read/live/lead/bass/tear/wind/wound/close/refuse/present/object/conduct/desert/produce/record/contract) → suggest contextual rewrite or synonym
- Silent letters (knight/queue/colonel/choir/Wednesday) → phonetic respell or synonym
- Loanwords (genre/fiancé/café) → flag if on stressed downbeat
- Acronyms (AI/JR/ATM) → force the form you want (`A I` spaced or `aye`)
- Numbers/dates → spell out
- Lines >15 syllables → split
- Closed vowels (uh/ih/eh) at line-end on chorus → swap for open vowel
- Sibilant clusters on highest chorus note → rephrase
- Function words on inferred downbeats → start with content word
- Multi-syllable words with wrong dictionary stress → swap or restructure

**7-C. Thai คำคล้องจอง Audit** (if `audit_thai_khlong`) — apply Section 7 of `references/khlong-jong-rhyme.md`:
- Chorus hook rhymes with partner? Title on rhyme position?
- (Parens echoes) rhyme with line above?
- At least one สัมผัสใน per chorus line?
- Verse scheme present (AABB / ABAB / AABA)?
- Verse 2 shares rhyme family with Verse 1?
- ขัดสัมผัส anywhere?
- Chorus rhyme family constant across repeats?
- Forced rhymes hurting meaning?

**7-D. English Rhyme & Form Audit** (if `audit_english_rhyme`) — apply Section 8 of `references/rhyme-craft-en.md`:
- Detect chorus scheme; rhyme density 50–75%?
- Title appears in chorus (line 1, last, both, every line)?
- Cliché pairs (fire/desire, heart/apart, etc.) — flag with family alternatives
- Verse scheme detected? Verse 1 / Verse 2 share rhyme family?
- Hook repetition count (≥3× per chorus)?
- Bridge present for songs >2:30?
- Show-don't-tell: chorus >50% feeling-words? Suggest concrete swap.

**7-E. Bilingual Mixing Audit** (if `audit_bilingual_mixing`) — apply `references/bilingual-mixing.md` §7:
- Same-line code-switching? Flag with split suggestion.
- Section headers missing language anchor? Flag.
- Drift declaration missing on dominant-language song? Soft flag.
- Echo translation grammar issues? Flag.

**Severity → summary mapping** (each audit independently):

| Flag count | Summary |
|---|---|
| 0 | `clean` |
| 1–2 | `minor` |
| 3–5 | `rework_recommended` |
| 6+ | `redraft_needed` |

Never aggregate counts across audits — keep them independent. The user reads each block separately.

### Step 8 — Output the consolidated answer

Use this exact template. Section headers and ordering are load-bearing — do not reorganize casually.

```
## 🎵 [Song Title]

### 📋 Styles (paste into Styles field)

```
[comma-separated tags here]
```
[⚠ N chars · note v5 budget warning if N > 200]

### 📝 Lyrics (paste into Lyrics field)

```
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

[If audit_thai_pian AND NOT audit_english_prosody — original Thai-only header for bit-identical regression with pre-refactor skill:]
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

[If audit_thai_khlong AND NOT audit_english_rhyme — original Thai-only header:]
### 🎼 คำคล้องจอง Audit

- บรรทัด "...": [rhyme issue], แนะนำเปลี่ยนเป็น "..."
- (or `scheme คำคล้องจอง ครบ — [details]` if clean)

[If audit_thai_khlong AND audit_english_rhyme — bilingual case, disambiguate:]
### 🎼 Rhyme Audit (Thai — คำคล้องจอง)

- บรรทัด "...": [rhyme issue], แนะนำเปลี่ยนเป็น "..."
- (or `scheme คำคล้องจอง ครบ — [details]` if clean)

[If audit_english_rhyme:]
### 🎼 Rhyme Audit (English)

- Line "...": [rhyme/form issue], suggest "..."
- (or `Rhyme scheme: [X]; hook placement: line [N]; no major issues` if clean)

[If audit_bilingual_mixing:]
### 🌐 Bilingual Mixing Audit

- Line "...": [issue], suggest "..."
- (or `Section anchors present; no same-line code-switching detected` if clean)

### 🔁 Iteration Tips

If take 1 isn't right:
- ถ้า vibe ไม่ใช่ / If vibe is off: เพิ่ม Style Influence เป็น [Y+10]%, ลด Weirdness เป็น [X-10]%
- [language-aware tips per detected audits]
- ถ้าอยากให้ track จำเสียงนี้: กด ⋮ → Make Persona ก่อน iterate
- ถ้าเพลงดีแล้วแต่อยากยาวขึ้น: ใช้ Extend จากท้าย outro
```

**Rendering rules:**
- Audit blocks render in this order: Thai-pron → English-pron → Thai-rhyme → English-rhyme → Bilingual mixing. The order is fixed.
- When no flags found for a language's audit, the block still renders with the "clean" message (so the user knows the audit was run and passed).
- When no content for a language exists, the block is **omitted entirely**, not rendered empty.
- The `⚠ [N] chars` budget line on Styles renders only when the Styles string is >150 chars.
- Section anchors `(Thai)` / `(English)` after `[Verse 1]` etc. ONLY appear in bilingual songs.

## Edge cases and special handling

**If the user already has lyrics they wrote:** skip Step 3 (composition). Auto-detect language in Step 6.5. Run all applicable audits in Step 7. Produce the rest of the prompt set. If a rhyme scheme is systematically absent (Thai: no คำคล้องจอง scheme; English: no detectable end-rhyme in a melodic genre), say so explicitly and offer to refactor — wait for user approval before rewriting.

**If the user wants only instrumental:** check Suno's "Instrumental" toggle; Lyrics field stays empty (or only `[Instrumental]` tags). Still produce Styles, Title, sliders. No audits run.

**If the user gives a reference song** ("ทำเพลงให้คล้าย ABC ของศิลปิน X" or "make it sound like song Y by artist Z"): NEVER copy lyrics; NEVER name the artist in Styles. Translate the *sonic descriptors* (era, instruments, mood, BPM) into the Styles field. Apply the no-artist-names rule from `references/suno-fields-reference.md`.

**If the user is on Free tier:** they're on v4.5-all (the free variant). Output works identically — but warn if they're trying to use v5 features they don't have.

**Targeting v5 (200-char Style limit):** if the composed Styles string is >200 chars, either trim or recommend switching to v5.5. Don't silently let truncation happen.

**For luk thung / mor lam fusion:** Suno's Thai-Isan diction is weakest here. Add aggressive pronunciation cues (`central Thai with Isan flavor, melismatic vocals with wide vibrato`), and warn the user that 2–3 regenerations are often needed for usable Isan delivery.

**If the user asks for a duet / two singers:** put both genders in Styles (`mixed-gender vocals, male and female duet`); use `[Female Vocal]` / `[Male Vocal]` tags inside lyrics on the lines where each voice should lead. Vocal Gender toggle on whichever voice opens the song.

**If the user asks for a specific lyricist style** (e.g., "เขียนแบบฟองเบียร์ / ดี้ / ครูสลา / บอย / สุรักษ์"): load `references/lyricist-signatures-th.md` and apply that lyricist's signature rules. Note in the output framing that the technique is being applied.

**Bilingual edge cases:**
- *Primarily-English song with one Thai word* (e.g., "I miss you สวัสดี") — flag as same-line code-switching; suggest splitting into two lines or moving Thai to a (parens echo).
- *Title in one language, body in another* — fine, but anchor sections clearly.
- *User wants Korean/Japanese/Spanish mixed in* — the skill does not audit those languages. Apply the section-anchoring + echo-translation patterns from `references/bilingual-mixing.md`, but explain that no dedicated phonetic audit will run.

**Length adjustments:**
- Short (~2 min) — drop the second verse and bridge: `[Intro] [Verse 1] [Chorus] [Verse 2] [Chorus] [Outro]`
- Long (~5 min) — add `[Instrumental Break]` or `[Guitar Solo]` (2–8 bars) before the bridge; consider a modulated final chorus

## Communication style

Match the user's language. Most users come in Thai — answer in Thai. If the user uses informal register (กู/มึง or casual), match it; otherwise default to friendly polite Thai. If the user uses English, answer in English. The output template (Styles/Lyrics/Settings/audits) stays in the standard format above regardless of conversation language.

When showing the final output, lead with a 1-sentence framing in the user's language ("นี่คือชุด prompt สำหรับ Suno ครับ คัดลอกแต่ละช่องไปวางในแอปได้เลย" / "Here's your Suno prompt set — paste each block into the matching field"), then the template, then iteration tips. Don't re-explain why each choice was made unless asked.
