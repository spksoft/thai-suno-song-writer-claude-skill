# Bilingual Mixing — Thai + English in the Same Suno Song

Single source of truth for cross-language mechanics. Loaded only when the lyric contains both Thai and English content. See `tonal-melodic-rules.md` and `pian-risk-checklist.md` for Thai-specific phonetics; see `prosody-meter-en.md` and `english-diction-checklist.md` for English-specific phonetics; this file only covers the **interface** between them.

## 1. The language-anchoring rule (load-bearing)

**Every section header in a bilingual lyric must declare its language** via a parenthetical anchor after the bracketed tag:

```
[Verse 1] (Thai)
[Pre-Chorus] (Thai)
[Chorus] (English)
[Verse 2] (Thai)
[Bridge] (English)
[Chorus] (English)
```

Why: Suno's tokenizer and vocal model can drift language mid-song when the script and phonology change without warning. The language anchor in `(parentheses)` after the section header is read as a directive (not sung — it's grouped with bracket-style metadata) and biases the model's phonology choice for that section.

**Sub-rules:**
- Anchor on EVERY section, not just the first. Suno restarts language detection per section.
- The anchor word is literally `(Thai)` or `(English)` — do not substitute "ไทย" / "อังกฤษ" / "TH" / "EN".
- For sections that contain both languages by design (rare; usually a bridge or outro): use `(Thai + English)`. Use sparingly.

## 2. The no-mix-per-line rule

**Within a single sung lead line, use ONE language.** This rule already exists for Thai (in `pian-risk-checklist.md` #8); it generalizes to all bilingual cases.

Forbidden:
```
รักเธอ forever                  ← mid-line drift
Bangkok ในคืนนี้                ← mid-line drift
I love เธอ มากๆ                ← mid-line drift
```

Sanctioned:
```
รักเธอตลอดไป                    ← Thai lead line
Forever in my heart            ← English lead line
(forever, forever)             ← parenthetical echo, see §3
```

Why: Suno applies one phonology per line. Mid-line script changes cause the model to apply English phonology to Thai or vice versa — output drifts unpredictably.

**The only sanctioned exception** is the parenthetical echo (§3).

## 3. The echo-translation pattern

**Parenthetical text in lyrics becomes a backing/ad-lib vocal layer, not a sung lead.** This is the canonical bilingual translation device.

```
I'll wait forever (รอเธออยู่)
ฉันจะรอตลอดไป (forever and ever)
อยากให้เธอกลับมา (come back home)
```

The line's lead vocal sings the lead language; the echo is overlaid as a backing harmony in the other language. This works because the echo is shorter, sung lower in the mix, and the model treats it as a non-lead element.

**Echo design rules:**
- Keep the echo short: 1–5 syllables. Long echos lose their backing quality.
- The echo should rhyme with or otherwise sonically reinforce the lead line (same as Thai (parens) echo rule in `khlong-jong-rhyme.md`).
- Echoes follow their lead — language-anchor follows the section header for the lead language; the echo is in the other.
- Do NOT stack more than one echo per line.

## 4. The drift declaration

For songs that are predominantly one language with brief excursions, add a **stability pin** to the Suno Style field:

```
Thai pop, modern T-pop ballad, … , All lyrics in Thai, no English drift
```

```
modern country, … , All lyrics in English, no other languages
```

The drift declaration is community-validated as one of the more reliable global hints when the model wants to drift to its trained-dominant language (English). For Thai-primary bilingual songs, this is especially load-bearing.

**Apply when:** the lyric is >70% one language (the dominant language). For 50/50 bilingual songs, do not pin — let the section anchors do the work.

**Wording variants that work:**
- `All lyrics in Thai, no English`
- `Thai vocals primary with English chorus echoes` (when there's a small English chorus)
- `Predominantly Thai, with English bridge only`
- `Primarily English, with one Thai verse`

**Wording that does NOT work:**
- `Don't drift to English` — Suno doesn't parse "don't" reliably.
- `Avoid English` — same problem.
- `100% Thai` — too prescriptive; Suno often ignores percentages.

## 5. Drift recovery procedure

If a generated take drifts mid-song (Thai section ends up in English-accented Thai, or English chorus drifts toward Thai pronunciation), follow this 3-step recovery on the next regeneration:

1. **Remove mixed-language lines** until the base version is stable. Strip parenthetical echoes from the section that drifted. Regenerate.
2. **Re-add code-switches one section at a time.** If the chorus is the problem, add the English chorus back only; leave verses pure Thai. Regenerate.
3. **Keep recurring hooks letter-identical** across all repetitions. Suno locks pronunciation on first encounter; mismatched spellings of the same hook line cause drift.

Steps 1 and 2 are useful for debugging which section is causing the issue. Step 3 is the structural fix once the issue is found.

## 6. Precedent patterns from other bilingual genres

The Thai+English case is one instance of a broader pattern. Other genres with established bilingual conventions:

### K-pop (Korean + English)
- Korean usually romanized in early Suno versions; v5+ handles Hangul better but romanization remains safer.
- Hyphenate Korean for syllabic control: `Sa-rang-hae` not `Saranghae`.
- English chorus is canonical — section-anchor explicitly: `[Chorus] (English)`.
- Group-vocal tags critical: `Mixed group vocals`, `Layered harmonies`, `Gang vocals`, `Group Chant`.

### Spanglish (Latin pop, reggaeton)
- Spanish in native orthography is fine in v5+.
- Section-anchor for switches; same pattern as Thai+English.
- Reggaeton 88–100 BPM; dembow rhythm tag for genre signal.

### J-pop (Japanese + English title chunks)
- Japanese romanized (romaji) over kana — v4.5 era requirement; v5 is more forgiving but romanization remains the safer default.
- English title chunks in chorus are a common pattern.

The Thai+English patterns in §1–§5 apply identically to these cases; substitute the language pair. The skill does NOT audit non-Thai-non-English content — for J-pop / K-pop / Spanish, use the section-anchoring + echo-translation patterns above and accept that no dedicated phonetic audit will run.

## 7. The bilingual mixing audit (used in Step 7-E)

When both Thai and English content are detected, the skill runs these checks. Output flags in the same format as other audits:

```
- Line "…": [issue], suggest "…"
```

### Check 1. Same-line code-switching
Any sung lead line (not a parenthetical echo) containing both Thai script AND Latin letters? Flag with a split suggestion.

**Example flag:**
```
- บรรทัด "Bangkok ในคืนนี้มันเหงาเกินไป" — same-line code-switching, มีทั้งภาษาไทยและอังกฤษในบรรทัดเดียว เสี่ยง drift; แนะนำแยกเป็น 2 บรรทัด หรือย้าย "Bangkok" ลงเป็น echo "(Bangkok tonight)"
```

### Check 2. Section header missing language anchor
Any `[Section]` header not followed by `(Thai)`, `(English)`, or `(Thai + English)`?

**Example flag:**
```
- Section header "[Chorus]" missing language anchor — add "(English)" or "(Thai)" so Suno applies consistent phonology
```

### Check 3. Drift declaration missing on dominant-language song
Lyric is >70% one language AND the Style field lacks a drift declaration like `All lyrics in [X]`?

**Example flag (soft — suggestion not hard flag):**
```
- เพลงเป็นไทย >70% แต่ Style field ยังไม่มี "All lyrics in Thai, no English"; แนะนำเพิ่มท้าย Style field เพื่อลดโอกาส drift
```

### Check 4. Echo translation grammar
Any parenthetical translation that has incorrect grammar (e.g., extra brackets, nested parens, content >5 syllables when it should be short)?

**Example flag:**
```
- บรรทัด "ฉันรักเธอ (I have loved you for so long now and forever)" — echo ยาวเกินไป (>5 พยางค์), เสียงจะไม่เป็น backing harmony; แนะนำย่อเป็น "(I love you so)" หรือยกขึ้นเป็นบรรทัด lead แยก
```

## 8. Output severity (parallel to other audits)

| Flag count from §7 audit | Summary |
|---|---|
| 0 | `clean` |
| 1–2 | `minor` — bilingual mixing largely correct |
| 3–5 | `rework_recommended` — language anchoring needs attention |
| 6+ | `redraft_needed` — bilingual structure not yet coherent |

Counted independently from other audits.

## 9. When NOT to flag

- Section headers in single-language songs (Thai-only or English-only) do not need anchors — the language is unambiguous.
- A single English word that is also a Thai loanword (e.g., "online", "love" in some pop contexts) on a Thai line is a judgment call — flag only if it appears in a stressed downbeat position.
- Parenthetical sound effects ("oh oh oh", "la la la", "yeah", "uh") are not translation echoes — don't audit them as such.
- Title/intro text containing a non-Thai-non-English chunk (e.g., a Japanese title) — note but don't flag, since the skill doesn't audit those languages.

## 10. Quick reference card

For the LLM during composition:

| If lyric is… | Do this |
|---|---|
| Pure Thai | No anchoring needed. Skip this file. Apply Thai audits. |
| Pure English | No anchoring needed. Skip this file. Apply English audits. |
| Thai with English chorus echoes in parens | Anchor each section with `(Thai)`. Add drift declaration to Style. |
| Bilingual section-anchored (Thai verses + English chorus, or vice versa) | Anchor EVERY section. Drift declaration optional. |
| 50/50 bilingual alternating | Anchor every section. No drift declaration (it would be self-contradictory). |
| Bilingual line-mixed | Refuse — split into two lines or move one to a parenthetical echo. |
