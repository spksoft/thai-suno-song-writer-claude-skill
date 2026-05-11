# Architecture Design — Bilingual Refactor of `thai-suno-songwriter`

> **Design document only — no implementation.** When this design is approved, run `/sc:implement` to build it.

**Date**: 2026-05-11 · **Author**: Claude (sc:design) · **Source research**: [`research_songwriting_2026-05-11.md`](./research_songwriting_2026-05-11.md)

## Locked design decisions

User-confirmed at design start:

1. **Big-bang refactor** — one cohesive change. All new reference files and rules ship together.
2. **Auto-detect language from lyric content** — no new question at Step 1. Skill inspects script: Thai script present → Thai audits; Latin script present → English audits; both → bilingual audits.
3. **Keep the skill name `thai-suno-songwriter`** — only the `description` frontmatter broadens to include English triggers. Skill discovery for existing Thai users stays intact.

These decisions cascade through every part of the design below.

---

## 1. Executive summary

The current skill is a Thai-only Suno prompt generator with two audit tracks (เพี้ยน, คำคล้องจอง). The refactor doubles the audit surface (adding English Prosody + English Rhyme & Form) while keeping all existing Thai logic and invariants in place. The skill output grows to render up to four parallel audit blocks; the skill workflow gains an auto-detection step that decides which audits to run; reference files split into language-tagged siblings (`*-th.md` / `*-en.md`) plus a shared bilingual-mixing file.

**What changes:**
- New: 8 English-language reference files; 1 bilingual-mixing reference file; 2 Thai-deepening reference files (genre conventions, lyricist signatures); 1 new workflow step (auto-detection).
- Modified: `SKILL.md` (description, Step 2, Step 7, Step 8 template); `suno-fields-reference.md` (v5.5 limits, English BPM table, English slider table).
- Renamed: `style-templates.md` → `style-templates-th.md`; `examples.md` → `examples-th.md` (so the naming convention is uniform).

**What stays exactly the same:**
- Thai phonetic tone rules and the 10 เพี้ยน risk patterns.
- Thai rhyme phonetics, สัมผัสนอก/ใน, vowel-family tables.
- Bracket-vs-parenthesis grammar.
- "Warn, don't auto-fix" invariant.
- Two-tier loading (eager `SKILL.md`, lazy `references/*.md`).
- Section-tag vocabulary (`[Verse]`, `[Chorus]`, etc.).
- No-artist-names rule.
- "Use Thai script, never romanize" rule for Thai content.

**Non-goals (explicitly out of scope for this design):**
- Building a router/dispatcher to multiple Suno-compatible models (Udio, etc.).
- Persisting a "Persona library" or user lyric history.
- Auto-rewriting (still warn-only).
- Bilingual lyrics in languages other than Thai+English (future extension).

---

## 2. File structure (final)

```
SKILL.md                                   [modified: description, Step 2, Step 7, Step 8]

references/
  # Shared / Suno-side
  suno-fields-reference.md                 [modified: v5.5 limits, English BPM table, English slider rows]
  bilingual-mixing.md                      [NEW]
  
  # Thai (existing — minor renames)
  tonal-melodic-rules.md                   [unchanged]
  pian-risk-checklist.md                   [unchanged]
  khlong-jong-rhyme.md                     [unchanged]
  style-templates-th.md                    [RENAMED from style-templates.md, content unchanged]
  examples-th.md                           [RENAMED from examples.md, content unchanged]
  genre-lyric-conventions-th.md            [NEW]
  lyricist-signatures-th.md                [NEW]
  
  # English (all new)
  song-structure-en.md                     [NEW]
  lyric-frameworks-en.md                   [NEW]
  rhyme-craft-en.md                        [NEW]
  prosody-meter-en.md                      [NEW]
  english-diction-checklist.md             [NEW]
  genre-conventions-en.md                  [NEW]
  style-templates-en.md                    [NEW]
  examples-en.md                           [NEW]

claudedocs/
  research_songwriting_2026-05-11.md       [exists]
  design_bilingual_skill_2026-05-11.md     [this file]
```

**Total reference files: 16** (was 6). Each loads on demand per Step 2.

**Why renames** — Even though renaming is a small disruption, leaving `style-templates.md` and `examples.md` un-namespaced while their English siblings are named `style-templates-en.md` is asymmetric and will confuse readers. The Thai pair gets the `-th` suffix for clarity. No external systems reference these paths; the only consumer is `SKILL.md` Step 2, which we're updating anyway.

---

## 3. Component model

Each reference file is a self-contained module with a clear contract. The contracts below define inputs/outputs at the conceptual level — the LLM consumes them as plain markdown, but the design treats them as functions.

### 3.1 Shared/Suno-side

**`suno-fields-reference.md` (modified)**
- Purpose: All Suno field/tag/slider knowledge.
- New content: v5.5 character limits, English-genre BPM table (10 rows), English-genre slider table (10 rows).
- Modified content: model-version table extended; "silent truncation" warning expanded to call out v5's 200-char Style limit.
- Consumed by: Step 4 (Styles composition), Step 5 (slider recommendation), Step 8 (output template's `⚙️ Settings` block).

**`bilingual-mixing.md` (NEW)**
- Purpose: Single source of truth for cross-language mechanics.
- Contract:
  - The language-anchoring rule (`(English)` / `(Thai)` section headers).
  - The no-mix-per-line rule (lead lines are one language; parenthetical echoes are the only sanctioned cross-language device).
  - Echo-translation pattern (`Lead line (echo translation)`).
  - Drift declaration heuristic (`All lyrics in [X], no [Y]` in Style field).
  - Drift recovery procedure (3 steps).
  - K-pop / Spanglish / J-pop precedent patterns (brief reference only).
- Consumed by: Step 3 (composition, when bilingual lyric is being written); Step 4 (Styles, when adding drift declaration); Step 7-D (the bilingual-cross-cutting audit, see §6).

### 3.2 Thai modules

**`tonal-melodic-rules.md` · `pian-risk-checklist.md` · `khlong-jong-rhyme.md`** — unchanged. Continue to be the canonical Thai-phonetic and Thai-rhyme references. Consumed by Step 3 (composition) and Step 7-A / 7-C (Thai audits).

**`style-templates-th.md` (renamed)** — content unchanged; 9 Thai sub-genres × 1–3 templates. Consumed by Step 4 (Styles composition for Thai genres).

**`examples-th.md` (renamed)** — content unchanged. End-to-end worked examples for Thai output. Loaded only when the user explicitly asks for an example or when Claude is unsure of output format.

**`genre-lyric-conventions-th.md` (NEW)**
- Purpose: Lyrical conventions per Thai sub-genre — what makes lyrics signature.
- Contract:
  - Per sub-genre (ลูกทุ่ง / หมอลำ / เพื่อชีวิต / T-pop / Thai rock / indie / R&B / hip-hop / folk / BL-OST): vocabulary pool, must/must-not words, narrative arc, hook position, line-count guide.
  - First-5-Seconds rule (concrete image / specific noun in verse 1).
  - Vocabulary banks per era: retro/ลูกกรุง, เพื่อชีวิต, อีสานลูกทุ่ง, BL/วาย, bedroom/indie.
- Consumed by: Step 3 (composition, after sub-genre is chosen).
- Independent of: phonetics, rhyme — those stay in their own files.

**`lyricist-signatures-th.md` (NEW)**
- Purpose: Signature techniques of major Thai lyricists, optional style modifier.
- Contract:
  - One section each for: ดี้ นิติพงษ์ ห่อนาค, สุรักษ์ สุขเสวี, ฟองเบียร์ (ปฏิเวธ), บอย โกสิยพงษ์, ครูสลา คุณวุฒิ, ปั่น ไพบูลย์เกียรติ.
  - Each section: 3–5 rules in actionable form (e.g., ฟองเบียร์ → "ใช้คำซ้ำที่หัวบรรทัด ≥3 ครั้งต่อ chorus"; ครูสลา → "verse 1 ต้องมีคำเฉพาะที่เห็นได้").
  - Phrased as optional style modifiers — user can ask "เขียนแบบฟองเบียร์" and the skill will apply that section's rules on top of the base composition.
- Consumed by: Step 3 (composition, only when user requests a specific lyricist style).
- Not load-bearing for default operation — pure optional polish.

### 3.3 English modules

**`song-structure-en.md` (NEW)**
- Purpose: English song forms and section functions.
- Contract:
  - Forms: V-C-V-C-B-C, AABA, 12-bar AAB, through-composed, EDM A-B-D, hip-hop verse-hook.
  - Section functions: intro, verse, pre-chorus, chorus, post-chorus, bridge, outro — each with bar-count and lyric-role.
  - Two-verse + bridge convention.
  - BPM × structure table per genre (10 rows).
- Consumed by: Step 3 (composition planning), Step 7-B (form-validation part of English rhyme audit).

**`lyric-frameworks-en.md` (NEW)**
- Purpose: Named English songwriting frameworks distilled to operational rules.
- Contract:
  - Pattison: object writing (7 senses), prosody-as-unity, stable-vs-unstable grid, six rhyme types.
  - Davis: title test, singability rules, hook bookending.
  - Sondheim: content dictates form, less is more, god is in the details, clarity.
  - Stolpe: 10-step commercial-songwriting checklist (condensed).
  - Show-don't-tell: 3 concrete moves with examples.
  - Hook construction: 4 placement positions, length hierarchy, repetition target, vowel choice.
- Consumed by: Step 3 (composition, for English content); Step 7-D (English rhyme audit, for hook-placement and show-don't-tell checks).

**`rhyme-craft-en.md` (NEW)**
- Purpose: English rhyme types, schemes, and the rhyme-cheating problem.
- Contract:
  - Six rhyme types in stable→unstable order (perfect / family / additive / subtractive / assonance / consonance), each with examples.
  - Identity rhyme + eye rhyme as anti-patterns.
  - Rhyme-scheme reference table (AABB, ABAB, ABCB, AABA, ABABCDCD, AAAA, AABBA, free).
  - Genre defaults (which scheme fits which genre).
  - Internal / multisyllabic / mosaic rhyme — what they are, where they fit.
  - Rhyme-cheating diagnostics: inverted syntax, filler lines, cliché pairs, meaning twisting.
  - Cliché-pair starter list (fire/desire, heart/apart, eyes/lies, love/above, time/mine, baby/maybe, …).
- Consumed by: Step 3 (English composition); Step 7-D (English rhyme audit).

**`prosody-meter-en.md` (NEW)**
- Purpose: English stress-timing and stress-to-downbeat matching.
- Contract:
  - English is stress-timed; difference from Thai's syllable-timed.
  - Foot vocabulary (iamb, trochee, anapest, dactyl, spondee) with songwriting use cases.
  - Stress-to-downbeat rule with test procedure.
  - Common violations (function words on downbeats, wrong-stressed multi-syllable words).
  - Back-phrasing technique.
  - Word painting list (directional words → melodic-shape hints).
  - Line-length / syllable-count guidance per section (verse 8–10, chorus 10–12, max 15).
- Consumed by: Step 3 (English composition); Step 7-B (English prosody audit).

**`english-diction-checklist.md` (NEW)** — *the English parallel to `pian-risk-checklist.md`*
- Purpose: Pronunciation-risk checklist for English. Same shape as `pian-risk-checklist.md`.
- Contract: 10 risk patterns, each with detection rule + suggested fix + example flag string:
  1. **Homograph** (read/live/lead/bass/tear/wind/wound/close/refuse/present/object/conduct/desert/produce/record/contract) — flag + suggest contextual rewrite or synonym.
  2. **Silent letters / irregular spelling** (knight/queue/colonel/choir/Wednesday) — flag + suggest phonetic respell.
  3. **Loanwords** (genre/fiancé/café/façade) — flag + suggest English equivalent or accept-as-is.
  4. **Acronyms** (AI/JR/ATM) — flag + force `A I` spaced or word-form.
  5. **Numbers/dates** — flag + force spelled-out form (`twenty twenty-six`).
  6. **Lines >15 syllables** — flag + suggest split.
  7. **Closed vowels on long held notes** (uh/ih/eh end-of-line) — flag + suggest open-vowel swap.
  8. **Sibilant clusters on the highest chorus note** (sshh, sss, zzh) — flag.
  9. **Function words on inferred downbeats** (the/of/a/to/and at line-start with stress) — flag.
  10. **Multi-syllable words with wrong dictionary stress** in fixed positions — flag (best-effort detection).
- Output format mirrors `pian-risk-checklist.md`: each flag is `- Line "…": [issue], suggest rewriting as "…"`.
- Consumed by: Step 7-B (English prosody audit).

**`genre-conventions-en.md` (NEW)** — *the English parallel to `genre-lyric-conventions-th.md`*
- Purpose: 10-genre English lyric conventions.
- Contract: One section per genre (pop / rock / country / hip-hop / R&B / folk / indie / EDM / blues / ballad). Each section: typical structure, BPM range, themes, rhyme scheme defaults, line-length range, hook placement, vocabulary register, named tropes.
- Consumed by: Step 3 (composition, after sub-genre is chosen).

**`style-templates-en.md` (NEW)** — *the English parallel to `style-templates-th.md`*
- Purpose: Paste-ready Suno Styles strings per English sub-genre.
- Contract: ≥2 templates per genre across pop, rock, country, hip-hop, R&B, folk, indie, EDM, lo-fi, ballad. Same composition order as Thai templates (genre → sub-genre → mood → instruments → vocal cue → production → BPM → diction cue).
- Diction cue conventions: `crisp English diction`, `clear American English vocals`, `British accent leaning RP`, `Southern American drawl`, etc. (with warning that direct accent tags are weak — see `bilingual-mixing.md` for the indirect-tag workaround).
- No artist names. Same rule as Thai.
- Consumed by: Step 4 (Styles composition for English genres).

**`examples-en.md` (NEW)** — *the English parallel to `examples-th.md`*
- Purpose: 2–3 end-to-end worked examples for English output.
- Contract: At minimum (a) English pop ballad, (b) English country uptempo, (c) bilingual T-pop with English chorus. Each shows the full Step 8 output template populated, including both audit blocks for the language(s) used.
- Consumed by: Loaded only when the user asks for an example or when Claude is uncertain of output format.

---

## 4. Workflow design

### 4.1 Updated workflow diagram

```
User request
   │
   ▼
[Step 1] Elicit concept (Thai prose) — unchanged from current skill
   │   ├─ 1.1 หัวข้อ
   │   ├─ 1.2 อารมณ์
   │   ├─ 1.3 แนวเพลง (sub-genre)
   │   ├─ 1.4 ภาษา — ไทยล้วน / ไทยเป็นหลัก+อังกฤษบางท่อน / ครึ่งไทยครึ่งอังกฤษ / อังกฤษล้วน [NEW option]
   │   ├─ 1.5 เพศนักร้อง
   │   └─ 1.6 ความยาว
   │
   ▼
[Step 2] Read relevant references — UPDATED routing
   │   Always: suno-fields-reference.md
   │   If lyric will be Thai-only or bilingual:
   │     tonal-melodic-rules.md, pian-risk-checklist.md, khlong-jong-rhyme.md,
   │     genre-lyric-conventions-th.md, style-templates-th.md
   │   If lyric will be English-only or bilingual:
   │     song-structure-en.md, lyric-frameworks-en.md, rhyme-craft-en.md,
   │     prosody-meter-en.md, english-diction-checklist.md,
   │     genre-conventions-en.md, style-templates-en.md
   │   If bilingual:
   │     also bilingual-mixing.md
   │   Optional (only on user request):
   │     lyricist-signatures-th.md, examples-th.md, examples-en.md
   │
   ▼
[Step 3] Compose lyrics — UPDATED for language
   │   - Choose form per genre conventions
   │   - Apply rhyme craft per language
   │   - Apply prosody per language (Thai tonal, English stress)
   │   - For bilingual: anchor sections with (Thai) / (English) per bilingual-mixing.md
   │
   ▼
[Step 4] Compose Styles — UPDATED
   │   Pick template from style-templates-th.md OR style-templates-en.md
   │   Append diction cue for the dominant language
   │   For bilingual: append drift-declaration phrase
   │   ⚠ Check char budget against model version (v5 → 200 char hard limit)
   │
   ▼
[Step 5] Recommend slider settings
   │   Use Thai slider table OR English slider table from suno-fields-reference.md
   │
   ▼
[Step 6] Generate title
   │
   ▼
[Step 6.5] AUTO-DETECT LANGUAGE — NEW
   │   Scan composed/pasted lyric:
   │     - Has Thai script chars? → Thai content present
   │     - Has Latin letters in sung lines (excluding [bracket directives])? → English content present
   │   Set audit flags:
   │     audit_thai_pian = Thai-present
   │     audit_thai_khlong = Thai-present
   │     audit_english_prosody = English-present
   │     audit_english_rhyme = English-present
   │     audit_bilingual_mixing = (Thai-present AND English-present)
   │
   ▼
[Step 7] Run audits — RESTRUCTURED
   │   7-A. Thai เพี้ยน         (if audit_thai_pian)
   │   7-B. English Prosody     (if audit_english_prosody)
   │   7-C. Thai คำคล้องจอง       (if audit_thai_khlong)
   │   7-D. English Rhyme & Form (if audit_english_rhyme)
   │   7-E. Bilingual mixing    (if audit_bilingual_mixing)
   │
   ▼
[Step 8] Output consolidated answer
   │   Render only audit blocks whose flag was set.
   │   See §5 for exact template.
```

### 4.2 Step-1 question 1.4 — explicit options

The existing question 1.4 has 3 options for language. Add a fourth:

| Option | Audits that will run |
|---|---|
| `ไทยล้วน` | 7-A, 7-C |
| `ไทยเป็นหลัก + อังกฤษบางท่อน (chorus echoes / bridge)` | 7-A, 7-B (light), 7-C, 7-D (light), 7-E |
| `ครึ่งไทยครึ่งอังกฤษ` | 7-A, 7-B, 7-C, 7-D, 7-E |
| `อังกฤษล้วน` [NEW] | 7-B, 7-D |

The user's pick is a *hint*. The auto-detection in Step 6.5 is the *authority* — if the user said "ไทยล้วน" but the produced lyric has English in it, English audits still run and a soft warning is shown ("Detected English content in lyric despite ไทยล้วน selection — running English audits as well").

### 4.3 Auto-detection rule (Step 6.5)

```
INPUT: composed or pasted lyric (multi-line string)
PROCEDURE:
  1. Strip [bracket directives] — they don't count.
  2. Strip (parenthetical echoes) — they DO count if they contain content
     in the target language and are not pure ad-libs ("oh oh oh", "la la la").
  3. For each remaining sung line:
       a. Count Thai script characters (Unicode U+0E00–U+0E7F)
       b. Count Latin letters [A-Za-z]
  4. thai_chars_total = sum across all lines
  5. latin_chars_total = sum across all lines (excluding tags that look like
     section markers — Verse, Chorus, Bridge, Pre-Chorus, Intro, Outro, Post-Chorus,
     Solo, Break, Build, Drop, Interlude, Refrain, Tag, End, Fade Out;
     also exclude language markers Thai, English)
  6. RETURN:
       thai_present  = (thai_chars_total ≥ 20)
       english_present = (latin_chars_total ≥ 20)
```

Thresholds (20 chars each) prevent stray English glyphs ("AI" in a Thai song's title) from triggering the English audit and vice versa. Both flags can be `true` simultaneously → bilingual.

### 4.4 Audits — input/output contracts

All five audit functions share the same shape:

```
INPUT:
  lyric_text       (the sung content)
  song_metadata    (sub-genre, BPM, vocal gender, language tags)
  context          (relevant reference files already loaded)

OUTPUT:
  flags: list of {
    line:        "…",
    issue:       "what's wrong, in human language",
    suggestion:  "…",      (the proposed rewrite or fix)
    severity:    "low" | "medium" | "high"
  }
  summary: "clean" | "minor" | "rework_recommended" | "redraft_needed"
```

Severity-to-summary mapping (mirrors existing `pian-risk-checklist.md` rule):

| Flag count | Summary |
|---|---|
| 0 | `clean` |
| 1–2 | `minor` |
| 3–5 | `rework_recommended` |
| 6+ | `redraft_needed` |

Counted **per audit independently**. The skill output never aggregates across audits — that's the "two parallel audits, kept separate" invariant.

### 4.5 The new 7-E audit (Bilingual mixing)

Only runs when both `thai_present` and `english_present` are true. Specific checks:

1. **Same-line code-switching** — any sung line containing both Thai and Latin characters? Flag.
2. **Section headers missing language anchor** — any `[Section]` header not followed by `(Thai)` or `(English)`? Flag, suggest adding anchor.
3. **Drift declaration absent** — Styles field lacks `All lyrics in [X], no [Y]` or equivalent? Suggestion only (not a hard flag) — only when the lyric is >70% one language.
4. **Echo translation grammar** — any parenthetical containing a translation but missing the `(text)` form? Should be rare; soft flag.

Output style identical to other audits (line + issue + suggestion).

---

## 5. Step 8 output template (concrete spec)

This is the user-visible contract — the most important deliverable of the design. Below is the exact spec; layout and ordering are load-bearing.

```
## 🎵 [Song Title]

### 📋 Styles (paste into Styles field)

```
[comma-separated tags here]
```
⚠ [N] chars · [v5 budget warning if N > 200 · v5.5 hard limit at 1000]

### 📝 Lyrics (paste into Lyrics field)

```
[Intro]
[Verse 1] [(Thai) or (English) — only emitted when bilingual]
…
[Pre-Chorus]
…
[Chorus]
…
[Verse 2]
…
[Bridge]
…
[Chorus]
…
[Outro]
[Fade Out]
```

### ⚙️ Settings

- **Vocal Gender:** Male / Female / Duet
- **Weirdness:** [X]%
- **Style Influence:** [Y]%
- **Model:** v4.5+all (or v5 / v5.5 if user has Pro / Premier)

[If audit_thai_pian:]
### ⚠️ Pronunciation Risk Flags (Thai — เพี้ยน)

- บรรทัด "…": [issue], แนะนำเปลี่ยนเป็น "…"
- (or `ไม่พบจุดเสี่ยงสำคัญ` if clean)

[If audit_english_prosody:]
### ⚠️ Pronunciation Risk Flags (English)

- Line "…": [issue], suggest rewriting as "…"
- (or `No major risks detected` if clean)

[If audit_thai_khlong:]
### 🎼 Rhyme Audit (Thai — คำคล้องจอง)

- บรรทัด "…": [rhyme issue], แนะนำเปลี่ยนเป็น "…"
- (or `scheme คำคล้องจอง ครบ — [details]` if clean)

[If audit_english_rhyme:]
### 🎼 Rhyme Audit (English)

- Line "…": [rhyme/form issue], suggest rewriting as "…"
- (or `Rhyme scheme: [detected]; hook placement: line [N]; no major issues` if clean)

[If audit_bilingual_mixing:]
### 🌐 Bilingual Mixing Audit

- Line "…": [issue], suggest "…"
- (or `Section anchors present; no same-line code-switching detected` if clean)

### 🔁 Iteration Tips

- ถ้า vibe ไม่ใช่: เพิ่ม Style Influence เป็น [Y+10]%, ลด Weirdness เป็น [X-10]%
- [language-aware tips based on which audits ran]
- ถ้าอยากให้ track จำเสียงนี้: กด ⋮ → Make Persona ก่อน iterate
- ถ้าเพลงดีแล้วแต่อยากยาวขึ้น: ใช้ Extend จากท้าย outro
```

**Rendering rules:**

- Section headers (`### ⚠️ …`, `### 🎼 …`) and ordering: **fixed**. Don't reorder.
- Audit blocks render in order: Thai-pron → English-pron → Thai-rhyme → English-rhyme → Bilingual mixing. The user reads top-to-bottom and the pronunciation-first / rhyme-second / bilingual-last sequence mirrors the production sequence (pronunciation is the lowest-level concern, bilingual mixing is highest-level).
- When no flags found for a language's audit, the block still renders with the "clean" message (so the user knows the audit was run and passed).
- When no content for a language exists, the block is **omitted entirely**, not rendered empty.
- The `⚠ [N] chars` budget line on Styles renders only when the Styles string is >150 chars (otherwise it's noise).

---

## 6. Audit interface specs

### 6.1 Audit 7-A — Thai เพี้ยน (unchanged behavior)

Defers entirely to `pian-risk-checklist.md` Section "The 10 risk patterns" and the quick-scan algorithm. No changes from current skill.

### 6.2 Audit 7-B — English Prosody (NEW)

Source rules: `english-diction-checklist.md` (10 patterns) + `prosody-meter-en.md` (stress matching).

Detection passes (in order):

1. Homograph scan (regex match against the homograph list)
2. Silent-letter scan (against the explicit list)
3. Loanword scan
4. Acronym scan (any all-caps 2–4 letter sequence)
5. Number/digit scan (regex `\d+`)
6. Long-line scan (syllables > 15 — approximated as words > 14 for fast scan; refine with syllable estimator if available)
7. Closed-vowel end-of-line scan (line ends in word with /ʌ/, /ɪ/, /ɛ/ as last sound — approximate by suffix)
8. Sibilant cluster on chorus highest note (heuristic: line containing the title in chorus, with ≥2 sibilant chars in the title word)
9. Function-word at line start (the/of/a/to/and as first word) — flag only when on stressed downbeat position (often line 1 of chorus)
10. Wrong dictionary stress (best-effort using a stress lexicon if accessible; otherwise skip silently)

Each pass emits flags in the standard shape. Stops at flag count = 6 (to keep output actionable, matching the current Thai audit's behavior).

### 6.3 Audit 7-C — Thai คำคล้องจอง (unchanged behavior)

Defers entirely to `khlong-jong-rhyme.md` Section 7 audit checklist. No changes from current skill.

### 6.4 Audit 7-D — English Rhyme & Form (NEW)

Source rules: `rhyme-craft-en.md` + `song-structure-en.md` + `lyric-frameworks-en.md` (hook placement section).

Detection passes:

1. **Detect rhyme scheme** in each section — emit "Scheme detected: AABB / ABAB / ABCB / etc." or "no scheme detected".
2. **Rhyme density check** — % of chorus lines with end-rhyme. >75% → soft flag ("dense rhyme may break Suno melodic phrasing").
3. **Cliché-pair scan** against the starter list — fire/desire, heart/apart, eyes/lies, love/above, time/mine, baby/maybe, night/light, day/way, true/you, soul/whole. Flag with suggestion to switch to family or assonance.
4. **Hook placement** — does the title phrase appear in chorus line 1, last line, both, or every line? If not in chorus at all → flag.
5. **Forced rhyme heuristic** — line ends with a word that's an unusual choice for the surrounding semantic context (best-effort, low-confidence). Often skipped; if confident → flag.
6. **Section count** — does song have at least one verse, one chorus, and (for >2:30 songs) one bridge? Flag missing.
7. **Verse 2 / Verse 1 rhyme-family cohesion** (parallel to Thai check) — do verses share at least one rhyme family? Soft flag if entirely different.
8. **Show-don't-tell pass** — if chorus has >50% abstract feeling-words (love/sad/lonely/broken/free/alive/dead/alone), suggest swapping one for concrete imagery. Soft flag.

### 6.5 Audit 7-E — Bilingual mixing (NEW)

Source rules: `bilingual-mixing.md`. Four checks listed in §4.5.

---

## 7. Cross-file invariants

Non-negotiable rules every reference file and `SKILL.md` change must respect:

1. **"Warn, don't auto-fix"** — every audit produces flags + suggestions; never rewrites the user's lyric without consent.
2. **Two-tier loading** — `SKILL.md` stays eager; everything in `references/` stays lazy.
3. **No artist names** — applies to Thai AND Western artists in all Style templates and examples.
4. **Bracket vs parenthesis grammar** — `[directives]` not sung; `(echoes)` sung as backing. Same rule across both languages.
5. **Thai script for Thai content** — never romanize Thai lyrics or Thai vocabulary in examples.
6. **Section header vocabulary** — only use Suno-recognized tokens (`[Verse]`, `[Chorus]`, `[Pre-Chorus]`, `[Bridge]`, `[Intro]`, `[Outro]`, `[Solo]`, etc.). Custom labels NOT understood by Suno.
7. **Two parallel audits stay visually separate** — never merge a Thai audit into an English audit or vice versa. Headers stay distinct. Ordering stays fixed.
8. **Slider tables stay consistent across files** — the per-genre slider rows in `suno-fields-reference.md` are the canonical truth; `style-templates-*.md` may reference them but must not contradict.
9. **Frontmatter discoverability** — the `description` field in `SKILL.md` must contain trigger phrases in both Thai and English; every phrase has a purpose.
10. **The Step 8 output template's header text and ordering** — the user-visible contract. Modify with care; document changes.

---

## 8. Migration path (big-bang execution)

Since the user picked big-bang, all changes ship in one cohesive edit. Recommended sequence within the single change:

```
Phase A: Build the new reference files in isolation
  1. genre-lyric-conventions-th.md
  2. lyricist-signatures-th.md
  3. song-structure-en.md
  4. lyric-frameworks-en.md
  5. rhyme-craft-en.md
  6. prosody-meter-en.md
  7. english-diction-checklist.md
  8. genre-conventions-en.md
  9. style-templates-en.md
  10. examples-en.md
  11. bilingual-mixing.md
  
  (These can all be created in parallel; they reference each other minimally.)

Phase B: Modify the existing shared file
  12. suno-fields-reference.md
      - add v5.5 row to model table
      - add English BPM column / table
      - add English slider rows
      - extend "silent truncation" warning to call out v5's 200-char limit

Phase C: Rename existing files
  13. style-templates.md → style-templates-th.md (git mv preferred)
  14. examples.md → examples-th.md

Phase D: Update SKILL.md
  15. Frontmatter description: add English triggers, keep all Thai triggers
  16. Step 1.4: add the "อังกฤษล้วน" option
  17. Step 2: rewrite the routing per §4.1
  18. Step 3: add language-aware composition guidance (delegate to new ref files)
  19. Step 4: add the "diction cue per dominant language" rule and drift-declaration mention
  20. Step 5: reference both Thai and English slider tables
  21. Step 6.5: add the new auto-detection step (entire new section)
  22. Step 7: restructure into 7-A through 7-E
  23. Step 8: replace the output template with the §5 spec
  24. Edge cases section: add bilingual edge cases (drift, primarily-English song with one Thai word, etc.)

Phase E: Validation (manual)
  25. Re-test the existing Thai-only worked example in examples-th.md — should still produce identical Step 8 output (only the Thai audit blocks render).
  26. Run a fresh English-only worked example — verify only English audit blocks render.
  27. Run a bilingual worked example — verify all 5 audit blocks render and the section anchors are in place.
```

Since the change is large, the implementer should not break it into multiple commits unless explicitly asked — the bilingual contract is only coherent when all pieces land together. If the implementer hits a wall on one reference file, they should pause and clarify, not partially ship.

---

## 9. Test plan / acceptance criteria

Manual test plan (the skill has no automated test infrastructure — its tests are scenario walk-throughs):

| Test | Input | Expected output |
|---|---|---|
| **T1 — Thai-only regression** | Existing example 1 in `examples-th.md` (เศร้า, รอคอย, female lead) | Identical output to current — Thai เพี้ยน + Thai คำคล้องจอง audits only; no English blocks |
| **T2 — English-only happy path** | Request: "Write me an English pop ballad about long-distance love, female lead, ~3:30" | Step 8 with: English Style, English lyrics with section tags, English Prosody audit, English Rhyme audit; no Thai blocks |
| **T3 — Bilingual section-anchored** | Request: "T-pop with Thai verses and English chorus, male lead, 3:30" | All 5 audit blocks render; section headers carry `(Thai)` / `(English)` anchors; bilingual mixing audit detects clean |
| **T4 — Bilingual line-mixed (anti-pattern)** | Paste lyric with "รักเธอ forever" on one line | Bilingual mixing audit flags the same-line code-switch with rewrite suggestion |
| **T5 — Homograph trigger** | Compose English lyric containing "tear" (intended noun) on a chorus line | English Prosody audit flags homograph with suggestion to use synonym or context-disambiguation |
| **T6 — Cliché-pair trigger** | Compose English chorus rhyming "fire/desire" | English Rhyme audit flags the cliché with family-rhyme alternatives |
| **T7 — Auto-detect override** | User picks ไทยล้วน at Step 1.4 but lyric contains "I love you" line | Skill softly warns "Detected English content despite ไทยล้วน selection" and runs English audits anyway |
| **T8 — Char budget warning** | Compose English song with Styles string of 215 chars; user on v5 model | Step 8 Styles block shows "215 chars — exceeds v5's 200-char limit, will be truncated. Consider switching to v5.5 or trimming." |
| **T9 — Pasted user lyrics with no rhyme scheme** | User pastes 16 lines of free-verse English | English Rhyme audit emits "no scheme detected" and suggests refactor for melodic genres; for indie/spoken-word genres, soft pass |
| **T10 — Lyricist style modifier** | "เขียนแบบฟองเบียร์ เพลงรักผู้หญิงร้อง" | `lyricist-signatures-th.md` is loaded; chorus uses anaphora at line heads; first-5-seconds rule applied to verse 1 |

**Acceptance criteria for the refactor:**

- All 10 tests above pass on manual walkthrough.
- Existing skill behavior for pure-Thai requests (T1) is **bit-identical** to pre-refactor output, except for the file-rename trail (which is internal).
- No reference file exceeds ~500 lines (load efficiency).
- `SKILL.md` stays under 350 lines (eager-load budget).
- All cross-references between reference files resolve.

---

## 10. Open issues / judgment calls deferred to implementation

These don't block the design but will need decisions during build:

- **Syllable counting for English**: a perfect English syllable counter is complex (silent e, dipthongs, etc.). The design accepts a word-count approximation (1 word ≈ 1.2 syllables average) for the long-line check. Acceptable accuracy for warn-only.
- **Stress-lexicon dependency for prosody pass 10**: ideal would be CMU Pronouncing Dictionary lookup. The LLM can approximate from its own English knowledge. If accuracy is poor, this pass can be silently skipped — the other 9 passes cover most cases.
- **Cliché-pair list size**: the starter list in §6.4 has 10 pairs. Could grow to 30–50 with research. Bigger list = more flags but also more noise. Start at 10–15 and expand based on user feedback.
- **Homograph list size**: same calibration tradeoff. Start with the 16-word HookGenius list; expand if needed.
- **Examples file budget**: `examples-en.md` should have at least 2 examples (English-only and bilingual). Adding more increases load cost when the file is consulted. Cap at 4–5 examples; if more variety needed, split into `examples-en-pop.md`, `examples-en-country.md`, etc. (not needed at MVP).
- **Bilingual edge cases for non-English-non-Thai languages** (Japanese romaji, Spanish, Korean romanization): the bilingual-mixing file should briefly mention that the patterns generalize, but the skill is not equipped to audit non-Thai-non-English content. Users who want J-pop/K-pop/Spanish should be told: "the patterns in `bilingual-mixing.md` apply; the language-specific Prosody/Rhyme audits do not."

---

## 11. Out of scope (for this refactor)

- A "Suno output critic" — taking an actual generated audio file and analyzing it. The skill is text-only.
- A "compare two takes" workflow — beyond scope.
- Multi-language beyond Thai+English. The bilingual-mixing file mentions the precedent (K-pop, Spanglish, J-pop) for completeness but does not equip the skill to audit those.
- Genre-mixing (e.g., "country-rap" hybrid) — handled by user picking dominant genre. Future improvement.
- An "auto-rewrite mode" — repeatedly rejected by the warn-don't-auto-fix invariant. If the user later wants this, it would be a separate skill or a different command.

---

## 12. Approval gate

To accept this design and proceed to implementation:

- Confirm that the file structure in §2 is acceptable.
- Confirm that the Step 8 output template in §5 looks right (this is the user-visible contract).
- Confirm that the auto-detection rule in §4.3 is the right behavior (vs requiring an explicit answer).
- Confirm that the 10 acceptance tests in §9 cover the cases that matter.

If all four confirm, run `/sc:implement` and the implementer will execute Phases A–D in §8 as one cohesive change.

If any answer is "no" or "let's revise X", we can iterate this design before implementation begins. The cost of revising a design doc is ~1 hour; the cost of implementing then revising is days.
