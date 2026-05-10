# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is a **Claude skill package** — not source code. There is no build, test, lint, runtime, or package manager. The deliverable is markdown that Claude itself loads and executes as instructions. "Running" the skill means Claude reading these files when a matching user request comes in.

The skill (`thai-suno-songwriter`) generates ready-to-paste prompts for Suno AI to produce Thai-language songs.

## Architecture

```
SKILL.md            ← entry point. Loaded eagerly when the skill triggers.
references/
  suno-fields-reference.md   ← Suno UI field limits, tag grammar, sliders
  tonal-melodic-rules.md     ← Thai tone-vs-melody rules (เพี้ยน theory)
  pian-risk-checklist.md     ← 10-pattern lint checklist applied to lyrics (pronunciation only)
  khlong-jong-rhyme.md       ← Thai rhyme craft: สัมผัสนอก/ใน, AABB/ABAB schemes, vowel families, rhyme audit
  style-templates.md         ← ready-made Styles strings per sub-genre
  examples.md                ← end-to-end worked outputs (1 & 2 model the rhyme audit format)
```

**Two-tier loading is intentional.** `SKILL.md` is short and always-loaded; `references/*.md` are loaded **on demand** per the workflow step that needs them (Step 2 of `SKILL.md`). When editing, preserve this split — do not inline reference content into `SKILL.md`, and do not add reference files that aren't pointed to from `SKILL.md`.

**`SKILL.md` frontmatter is contractual.** The `name` and `description` fields are how Claude's skill matcher decides whether to trigger this skill. The description is deliberately keyword-rich (Thai + English triggers, artist genres, common phrasings). Don't trim it for aesthetics — every phrase there is a discovery hook.

## Conventions specific to this skill

When editing `SKILL.md` or any `references/*.md`, these conventions are load-bearing:

- **Warn, don't auto-fix.** The skill flags เพี้ยน risks AND คำคล้องจอง (rhyme) issues, proposes rewrites, but lets the user choose. This is stated in `references/pian-risk-checklist.md`, `references/tonal-melodic-rules.md`, and `references/khlong-jong-rhyme.md` (Section 9). New rules must follow the same pattern — never add logic that silently rewrites user lyrics, even when the rhyme scheme is broken.
- **Two parallel audits, kept separate.** Pronunciation risk (เพี้ยน) and rhyme/song-craft (คำคล้องจอง) are different problems with different fixes. The Step 8 output template in `SKILL.md` shows them in two separate blocks (`### ⚠️ เพี้ยน Risk Flags` and `### 🎼 คำคล้องจอง Audit`) so the user can act on them independently. Don't merge or re-order these blocks.
- **No artist names, ever.** Suno silently filters real artist names (Thai or Western). All reference content must use sonic descriptors instead. If you add a new style template, follow the existing "no artist names" pattern in `style-templates.md`.
- **Bracket vs. parenthesis grammar is fixed by Suno itself.** `[brackets]` = directives, not sung. `(parentheses)` = sung as backing vocals. Any examples must respect this — getting it wrong in docs propagates to user output.
- **Use Thai script in lyric examples**, never romanization. Romanization confuses Suno's tokenizer; this is documented and the docs themselves should model it.
- **Slider tables must stay consistent.** The "Recommended values per Thai sub-genre" tables in `SKILL.md` and `references/suno-fields-reference.md` duplicate intentionally (one is summary, one is canonical). When changing a value, update both.
- **The Step 8 output template in `SKILL.md`** (the consolidated answer the user copies into Suno) is the user-visible contract. Section headers (`## 🎵 Title`, `### 📋 Styles`, etc.) and ordering should not be reorganized casually.

## Communication language

The skill answers users in Thai by default (most users come in Thai). Internal documentation (this file, file headers, structural prose) is in English; user-facing content inside `SKILL.md` and `references/` mixes Thai and English deliberately. Preserve that mix — Thai examples are not stylistic, they're functional (the skill output is Thai).
