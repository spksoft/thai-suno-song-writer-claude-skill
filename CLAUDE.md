# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is a **Claude skill package** — not source code. There is no build, test, lint, runtime, or package manager. The deliverable is markdown that Claude itself loads and executes as instructions. "Running" the skill means Claude reading these files when a matching user request comes in.

The skill (`thai-suno-songwriter`) generates ready-to-paste prompts for Suno AI to produce Thai-language songs (or English / bilingual). It is **Thai-first** — Thai content quality drives design decisions; English support is parallel but secondary.

## Architecture (v2 — directive-aware)

```
SKILL.md                              ← entry point. Loaded eagerly when the skill triggers. 9-step workflow.
references/
  # Always-on-first-compose (Suno platform mechanics)
  suno-platform.md                    ← Suno UI field limits, four directive layers,
                                        three-layer vocal spec, Persona/Voices/Extend/Song
                                        Editor Thai workflow, sliders, BPM, feature matrix
  # Thai content lane (load when Thai content)
  thai-tone-craft.md                  ← Tonal-melodic alignment, 10 เพี้ยน patterns,
                                        Rhyme × Tone risk matrix (Step 7-A2),
                                        commit-to-the-fall survival strategy
  thai-rhyme-craft.md                 ← Thai rhyme craft: สัมผัสนอก/ใน, vowel families,
                                        AABB/ABAB schemes, rhyme audit
  thai-phonetic-respelling.md         ← In-Thai-script disambiguation patterns
                                        (NOT romanization). Load only when Step 7-A flags
                                        problem words
  thai-genre-craft.md                 ← Thai sub-genre lyric conventions + Style templates +
                                        slider numbers, with 2024–2026 vocab refresh
  thai-lyricist-signatures.md         ← Optional: load when user asks "เขียนแบบ X"
  thai-hit-songs.md                   ← Optional: load when user names a song or asks
                                        for a sub-genre matching one. Fair-use commentary
                                        only — no full lyrics
  thai-examples.md                    ← Optional: worked Thai examples demonstrating
                                        all directive layers and audit blocks
  # English content lane (load when English content)
  english-prosody-rhyme.md            ← English stress, rhyme craft, diction audit
                                        (merger of prosody-meter + rhyme-craft + diction-checklist)
  english-genre-craft.md              ← English forms, frameworks (Pattison/Davis/Sondheim/
                                        Stolpe/Webb/Blume), genre conventions, Style templates
  english-examples.md                 ← Optional: worked English examples
  # Bilingual lane (load when both languages detected)
  bilingual-mixing.md                 ← Thai+English co-occurrence rules: language anchoring,
                                        echo translation, drift declaration, drift recovery
```

**File-count target: 11 reference files** (down from 18 in v1). Each file ≤500 lines. If a file exceeds 500 lines, split rather than compress further.

**Two-tier loading is intentional.** `SKILL.md` is short and always-loaded; `references/*.md` are loaded **on demand** per the workflow step that needs them (Step 2 of `SKILL.md`). When editing, preserve this split — do not inline reference content into `SKILL.md`, and do not add reference files that aren't pointed to from `SKILL.md`.

**`SKILL.md` frontmatter is contractual.** The `name` and `description` fields are how Claude's skill matcher decides whether to trigger this skill. The description is deliberately keyword-rich (Thai + English triggers, artist genres, common phrasings, directive layers, audit names). Don't trim it for aesthetics — every phrase there is a discovery hook.

## Conventions specific to this skill (load-bearing)

When editing `SKILL.md` or any `references/*.md`, these conventions are load-bearing:

- **Warn, don't auto-fix.** The skill flags เพี้ยน risks, คำคล้องจอง (rhyme) issues, Rhyme × Tone matrix risks, directive overload, and bilingual mixing issues. It proposes rewrites but lets the user choose. This is stated explicitly in `references/thai-tone-craft.md`, `references/thai-rhyme-craft.md` (§9), `references/thai-phonetic-respelling.md`, and `references/bilingual-mixing.md`. New rules must follow the same pattern — never add logic that silently rewrites user lyrics, even when the rhyme scheme is broken.

- **Four directive layers are first-class craft, not appendix.** Step 3.5 of `SKILL.md` is the dedicated step where the four layers (Layer 1 section directives, Layer 2 vocal performance + inline parens cues, Layer 3 v5+ meta tags, Layer 4 Thai phonetic respelling) are woven into the Lyrics field. The grammar lives in `references/suno-platform.md` §3–6. Output template Step 8 includes a `🎙️ Directives used` block surfacing which directives were applied and why.

- **Rhyme × Tone matrix is single-source, never duplicated.** The matrix (9 rhyme families × 5 tones) lives in `references/thai-tone-craft.md` §7. `references/thai-rhyme-craft.md` cross-references it but does NOT duplicate the table. If the matrix changes, edit one place.

- **Suno-Thai weakness disclosure is in three places.** (1) `SKILL.md` opening "Reality check" framing block; (2) `references/suno-platform.md` Layer 4 / §11 platform workflow notes; (3) `SKILL.md` Step 8 output template `🇹🇭 ความคาดหวังกับ Suno สำหรับเพลงไทย` block, always emitted when Thai content is detected. The framing must say Suno's documented "best languages" are English/Spanish/Portuguese/French/Japanese/Korean/Mandarin, and Thai is in the lesser-represented tier with 2–3 regenerations expected.

- **Step 8 output template legacy headers are preserved bit-identical for pure-Thai output.** The headers `### ⚠️ เพี้ยน Risk Flags` and `### 🎼 คำคล้องจอง Audit` (with exactly that punctuation, emoji, and Thai/English mix) appear in the Thai-only case — no regression for users of the v1 skill. New blocks are additive between existing ones; never reorder existing blocks.

- **No artist names, ever.** Suno silently filters real artist names (Thai or Western). All reference content must use sonic descriptors instead. The rule lives in `references/suno-platform.md` §15. Style templates in `references/thai-genre-craft.md` and `references/english-genre-craft.md` follow this rule rigorously.

- **Bracket vs. parenthesis grammar is fixed by Suno itself.** `[brackets]` = directives (section headers + vocal cues + meta tags) — NOT sung. `(parens)` after a sung line = sung as backing vocals/harmony/echo. `(parens)` ON ITS OWN LINE BEFORE a sung line = inline performance cue, NOT sung. Any examples must respect this — getting it wrong in docs propagates to user output.

- **Use Thai script in lyric examples, never romanization.** Romanization confuses Suno's tokenizer. For problem syllables that need disambiguation, use the in-Thai-script techniques in `references/thai-phonetic-respelling.md` — พินทุ ◌ฺ for clusters, hyphens for syllable lock-in, full-form spelling for numerals/acronyms. The K-pop/J-pop romanization examples in `references/bilingual-mixing.md` §6 are described as **external precedents only** — not a recommendation for Thai.

- **Slider tables must stay consistent across two files.** The "Recommended values per Thai/English sub-genre" tables in `SKILL.md` Step 5 and `references/suno-platform.md` §9 duplicate intentionally (one is summary, one is canonical). When changing a value, update both. This is the ONE exception to the "no duplicate tables" rule — preserved because both views are useful in different contexts.

- **Tag count budget**: 8–15 tags optimal for Styles field (raised from 4–8 per 2026 community-validated practice). Hard ceiling 20. v5's 200-char limit is the effective ceiling for that model. Documented in `references/suno-platform.md` §7.

- **Directive density cap**: directives stay ≤30% of Lyrics-field character count. Step 7-F audit enforces. If the density is too high, drop in order: meta tags (Layer 3) first, then inline parens cues (Layer 2), then bracket vocal cues. Never drop section headers (Layer 1) or backing-vocal echoes.

- **The Step 8 output template in `SKILL.md`** (the consolidated answer the user copies into Suno) is the user-visible contract. Section headers (`## 🎵 Title`, `### 📋 Styles`, etc.) and ordering must not be reorganized casually. New blocks are additive; existing block order is fixed.

- **Fair-use commentary stance in `thai-hit-songs.md`.** Hit-song analysis uses 1-line hook excerpts + structural skeletons + source URLs only. Never reproduce full lyrics. This is the established stance from v1 — preserved.

## Communication language

The skill answers users in Thai by default (most users come in Thai). Internal documentation (this file, file headers, structural prose) is in English; user-facing content inside `SKILL.md` and `references/` mixes Thai and English deliberately. Preserve that mix — Thai examples are not stylistic, they're functional (the skill output is Thai).

## Build artifact

The repository builds a `.skill` zip via a Makefile (filename-agnostic — no Makefile changes needed for the file restructure). The bundled artifact contains `SKILL.md` and all of `references/*.md`.
