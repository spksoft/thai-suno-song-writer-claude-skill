# Suno Platform Reference — Fields, Directives, Workflows (v4.5 / v5 / v5.5)

This is the always-loaded reference for Suno's UI fields, the four directive layers the skill weaves into the Lyrics field, the three-layer vocal spec used in the Styles field, and the advanced workflows (Persona / Voices / Extend / Song Editor) that matter especially for Thai work.

## Contents

1. Hard limits per model
2. The cardinal rule: brackets vs. parentheses vs. plain text
3. Directive grammar — Layer 1: Essential (sections + production)
4. Directive grammar — Layer 2: Vocal performance (brackets + inline parens) + Three-layer vocal spec
5. Directive grammar — Layer 3: v5+ meta tags (soft hints)
6. Directive grammar — Layer 4: Thai-specific directive patterns
7. Tag-count and directive-density budgets
8. The Styles field — 5-part formula
9. Creative Sliders and recommended values per genre
10. BPM ranges per genre (EN reference; TH genre BPM lives in `thai-genre-craft.md`)
11. Persona / Voices / Extend / Song Editor — Thai workflow
12. Vocal Gender, Title field, Audio Upload
13. Custom Mode vs. Simple Mode
14. v4.5+all family vs v5 / v5.5 — feature matrix
15. Common mistakes to avoid

---

## 1. Hard limits (verified Q4 2025–Q2 2026)

| Field | v4.5 family | v5 | v5.5 | Behavior past limit |
|---|---|---|---|---|
| Lyrics (Custom mode) | 5,000 chars | 5,000 | 5,000 | silently truncated; aim for ≤3,000 |
| Styles | 1,000 chars | **200 chars** | 1,000 | **silently truncated with no warning** — front-load critical tags |
| Title | 80 chars | 80 | 80 | truncated |
| Audio upload (Free) | 6–60 sec | 6–60 | 6–60 | rejected |
| Audio upload (Pro/Premier) | up to 8 min | up to 8 min | up to 8 min | — |
| Max song length | 8 min | 8 min | 8 min | — |

⚠ **v5's 200-char Style limit is the most consequential trap.** Tags after position 200 are dropped silently. When building Styles strings for v5, put genre + mood + vocal + BPM tags first; production details and Thai diction cues last. v5.5 restores the 1,000-char budget.

The v4.5 sub-models (v4.5, v4.5+, v4.5-all) share identical character limits and slider behavior. They differ only in tier access and which co-creation features (Add Vocals, Add Instrumentals, Inspire) are exposed.

---

## 2. The cardinal rule: brackets vs. parentheses vs. plain text

| Notation | Suno reads it as | Use case |
|---|---|---|
| `[ ... ]` on its own line | Section header / structural marker — **NOT sung** | `[Intro]`, `[Verse 1]`, `[Chorus]`, `[Bridge]`, `[Outro]` |
| `[ ... ]` inline before a section | Performance / production directive — **NOT sung** | `[Belted]`, `[Soft piano]`, `[Female Vocal]`, `[Khaen]` |
| `( ... )` on its own line, before a sung line | **Inline performance cue** — **NOT sung**, modifies the line that follows | `(whispered)`, `(building intensity)`, `(stripped back)` |
| `( ... )` after a sung line, same/next line | Sung as **backing vocals / harmony / echo / ad-lib** | "I'm gone (gone, gone away)" |
| Plain text | Sung literally as lead vocal | Main lyric line |

Suno does NOT understand prose instructions. Writing "make this part louder" inside the lyrics field will be sung as a literal lyric. Always use the bracket/parens grammar above.

**Disambiguating the two parens uses:** a paren on its own line BEFORE the sung line is a performance cue (Suno reads it as direction). A paren on the same line as the sung line, or immediately after, is a backing vocal that gets sung. The position decides which.

---

## 3. Directive grammar — Layer 1: Essential (every song uses these)

Section headers and basic production cues. Place each on its own line.

### Section structure tags

```
[Intro]
[Verse]  [Verse 1]  [Verse 2]  [Verse 3]
[Pre-Chorus]
[Chorus]
[Post-Chorus]
[Hook]            ← unreliable; prefer [Chorus] with the hook line
[Bridge]
[Refrain]
[Interlude]
[Instrumental]    [Instrumental Break]
[Solo]  [Guitar Solo]  [Piano Solo]  [Sax Solo]
[Break]
[Build]           [Drop]    ← work in EDM contexts; often ignored elsewhere
[Outro]
[End]             ← works best as the only content of a final clip
[Fade Out]        ← cooperates with the editor's Fade Out icon
[Tag]
```

Custom labels like `[My Special Section]` are NOT understood. Stick to the tokens above.

### Basic production cues

```
[Soft piano]
[Acoustic guitar arpeggio]
[Distorted guitar riff]
[Harmonica solo]
[Synth pad fade]
[Drum machine]
```

These are descriptive instrument calls; they cue the model to lean a section's arrangement toward the named instrument(s).

---

## 4. Directive grammar — Layer 2: Vocal performance

Two notations for vocal direction:

### 4a. Bracket vocal cues (one per section maximum)

Place on its own line, before the section it modifies. Suno applies the cue to the whole section.

```
[Soft]          [Whispered] / [Whisper]
[Spoken] / [Spoken Word]
[Belted] / [Belting]
[Falsetto]
[Vocal Run]
[Harmony]       [Stacked Vocals]
[Choir]         [A cappella]
[Chant]
[Rap]
[Cry]           [Laugh]    [Shout]
[Staccato]      ← crisp syllable separation; useful for Thai pronunciation clarity
[Operatic]
[Ad-libs]
[Female Vocal]  [Male Vocal]   ← force a voice change mid-song
```

**Rule: max ONE bracket vocal cue per section.** Stacking `[Belted]` + `[Whispered]` on the same section confuses Suno — pick one.

### 4b. Inline parenthetical performance cues (one per section maximum) — NEW in 2025+

Place on its own line, before the sung line it modifies. These are line-level rather than section-level — finer-grained control. v5/v5.5 support these reliably; v4.5 family interprets them inconsistently.

```
(whispered)
(belted)
(spoken word)
(harmonized)
(ad-lib)
(falsetto)
(building intensity)
(stripped back)
(key change)
(half-time feel)
(breath)
(hold)
```

**Example use** (in lyrics field):

```
[Verse 1]
(whispered) In the silence of the night
I feel you close to me
(building intensity) And I can't let go
(belted) OF YOU
```

**Rule: AT MOST one inline cue per section.** Multiple inline cues per section dilute Suno's interpretation. If you need two different cues in one section, use a bracket vocal cue for the broad characterization and reserve the one inline cue for the climax line.

### 4c. The three-layer vocal spec (used in Styles field, not Lyrics)

Every Suno vocal direction has three slots. Pick one entry from each. Output as a comma-separated phrase in the Vocal Direction bucket of the Styles 5-part formula (see §8).

| Slot | Examples |
|---|---|
| **Character** | raspy male tenor, clean female soprano, gritty baritone, breathy alto, weathered tenor, youthful male, sultry contralto, melismatic female with vibrato |
| **Delivery** | belted full-voice, breathy whispered, spoken word, melismatic with vibrato, falsetto, half-spoken half-sung, conversational, theatrical anthemic |
| **Effects** | reverb-drenched close-mic, dry studio, tape saturation, doubled with octave, wide stereo gated reverb, lo-fi vinyl crackle, polished radio mix, intimate close-mic |

Combined examples:

- `"raspy male tenor, breathy whispered, reverb-drenched close-mic"` → bedroom-pop / GUNGUN-adjacent archetype
- `"clean female soprano, belted full-voice, polished radio mix"` → modern T-pop ballad chorus
- `"weathered male tenor, melismatic with vibrato, dry organic mix"` → phleng phuea chiwit / Carabao-adjacent
- `"breathy female alto, intimate conversational, lo-fi vinyl crackle"` → indie/The Toys-cover-adjacent

**Stack one per Styles field.** Do NOT stack two characters or two deliveries — Suno picks one and discards the other, often unpredictably.

For Thai vocals: `melismatic with vibrato + Isan flavor` is the only combination that produces convincing lukthung/morlam delivery.

### 4d. Backing-vocal echoes (in-line parens — unchanged from earlier skill versions)

Place a `( )` after a sung line, or on a new line directly under it. Suno sings these as harmony / echo / ad-lib.

```
อยากบอกเธอว่ารัก
(ว่ารัก ว่ารัก)
```

The echo in Thai chorus should rhyme with the line above it (per `thai-rhyme-craft.md` §4).

---

## 5. Directive grammar — Layer 3: v5+ meta tags (soft hints, optional)

Available in v5 and v5.5 only. Place at the very top of the Lyrics field, one per line. Suno interprets them as soft guidance, not guarantees.

```
[Tempo: 92 BPM]
[Key: A minor]
[Mood: Melancholic]
[Mood: Euphoric]
[Energy: High]
[Energy: Building]
[Vocal Style: Soft Male]
[Vocal Style: Breathless]
[Instrument: Piano-led]
[Texture: Sparse → Full]    ← describes dynamic arc across the song
[Texture: Grainy]
[Callback: chorus melody]   ← references a previously-defined melodic idea
```

**Rule: max 3 meta tags.** Stacking beyond 3 dilutes effect; pick the ones most central to the song's identity.

**When to use:** songs with a specific mood/texture target where the user wants Suno to lean strongly into it. The meta tags reinforce the Styles field's tags from a different angle.

**When NOT to use:** when the Styles field already carries 12+ tags. Meta tags are additive guidance, not substitutes.

---

## 6. Directive grammar — Layer 4: Thai-specific patterns

Cross-link: `thai-phonetic-respelling.md` for in-Thai-script disambiguation. Cross-link: `thai-tone-craft.md` §8 for commit-to-the-fall strategy.

### Bracket cues that work especially well for Thai

```
[Staccato]            — crisp syllable separation; clarifies clusters and short vowels
[Belted]              — gives falling-tone hooks dynamic shape (see commit-to-the-fall)
[Female Vocal]        — vowel rendering is slightly cleaner in Suno's current Thai pipeline
[Khaen]   [Phin]      — Thai instruments; Suno recognizes both
[Spoken]              — for rap/talking sections; useful for เพื่อชีวิต narrative bridges
```

### Thai Suno weakness — set expectations early

Thai is NOT in Suno's official "best languages" list (English, Spanish, Portuguese, French, Japanese, Korean, Mandarin). Thai falls in the "lesser-represented" tier with these documented behaviors:

- Take 1 will often have at least one เพี้ยน line, drifted accent, or flattened tone
- v4.5+all renders Thai noticeably worse than English; v5/v5.5 improving but imperfect
- Female voices render Thai vowels slightly more clearly than male voices in current models
- Slow ballads (60–80 BPM) handle tones better than fast pop (>120 BPM)
- Pasting the full chorus 3× (rather than relying on `[Chorus]` reference) measurably improves consistency

The skill always surfaces this framing in Step 8's output when Thai content is detected. The user should expect 2–3 regenerations as the cost of doing business in Thai with Suno today.

---

## 7. Tag-count and directive-density budgets

### Styles field tag count

| Range | Behavior |
|---|---|
| <5 tags | Too vague; Suno underspecifies the result |
| 5–7 tags | Acceptable for simple genres; risky for hybrids |
| **8–15 tags** | **Optimal sweet spot** (2026 community-validated) |
| 16–20 tags | Diminishing returns; still works |
| >20 tags | Dilution — Suno ignores some tags non-deterministically |

The skill's default target is **8–12 tags**, leaving room for a Thai diction cue at the end without busting the v5 200-char limit.

### Lyrics field directive density

Directives in the Lyrics field (bracket section headers + bracket vocal cues + inline parens cues + meta tags) should stay **≤30% of total Lyrics-field characters**. The remaining 70%+ is sung text.

When directive density approaches 30%, drop in this order:
1. Meta tags (Layer 3) — least essential
2. Inline parens cues (Layer 2b) — keep at most one per critical section
3. Bracket vocal cues (Layer 2a) — keep only for sections that genuinely need them

Never drop section headers (Layer 1) or backing-vocal echoes (Layer 2d) — those are structural, not decorative.

---

## 8. The Styles field — 5-part formula

Comma-separated tags consistently outperform prose. Order tags in these five buckets:

```
1. Genre / Subgenre
2. Mood & Energy
3. Vocal Direction (three-layer spec: Character + Delivery + Effects)
4. Instrumentation (2–3 instruments)
5. Production & Tempo
```

### Worked example

```
Thai rock ballad,                                ← 1. Genre / Subgenre
anthemic stadium rock, emotional building,        ← 2. Mood & Energy
soaring male tenor with vibrato, belted full-voice, cinematic close-mic, ← 3. Vocal Direction
piano with strings, distorted electric guitars, driving rock drums, ← 4. Instrumentation
polished mix with dynamic verse-to-chorus contrast, 80 BPM, clear Thai pronunciation ← 5. Production & Tempo
```

That's 11 tags — squarely in the 8–15 sweet spot.

### Always include a Thai diction cue at the end

When the song contains Thai content, the last tag should be one of:

- `clear native Thai diction`
- `Thai vocals in Bangkok accent, no English drift`
- `central Thai with Isan flavor` (for luk thung/mor lam)
- `Thai vocals primary with English chorus echoes` (for Thai-primary bilingual)

For v5 (200-char limit), this single tag costs ~25–30 chars — budget for it. Drop a less-essential production tag if needed.

---

## 9. Creative Sliders and recommended values per genre

### The three sliders

| Slider | Range | What it does | Default |
|---|---|---|---|
| **Weirdness** | Safe → Chaos | How far Suno deviates from conventional patterns | 50% |
| **Style Influence** | Loose → Strong | How strictly Suno follows the Styles text | 50% |
| **Audio Influence** | Loose → Strong | How strictly Suno follows uploaded reference audio (appears only when Audio is uploaded) | 50% |

### Recommended values per Thai sub-genre

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
| Worship / orchestral / cinematic | 25–40% | 70–85% |
| Experimental / avant-garde | 70–85% | 35–55% |

### Recommended values per English sub-genre

| Sub-genre | Weirdness | Style Influence |
|---|---|---|
| Mainstream pop (ballad or upbeat) | 25–35% | 70–85% |
| Rock / pop-rock | 35–50% | 65–80% |
| Indie (folk-pop / bedroom-pop) | 50–65% | 55–70% |
| Modern country / Nashville radio | 25–35% | 75–88% |
| Hip-hop / boom-bap / conscious | 40–55% | 60–75% |
| Trap / melodic trap | 40–55% | 60–75% |
| R&B / neo-soul / slow jam | 25–40% | 70–85% |
| Folk / singer-songwriter | 30–45% | 65–80% |
| EDM / progressive house / synthwave | 30–45% | 70–85% |
| Lo-fi / chill / chillwave | 35–50% | 65–80% |
| Blues / blues-rock | 30–45% | 70–85% |

For both tables, **state a single number, not a range, in the final output**. Pick the midpoint unless the user said "experimental" or "very mainstream." This same table appears in `SKILL.md` Step 5 — keep both in sync if either is edited.

### Edge behavior

- **Weirdness >80%**: genuinely chaotic — sometimes brilliant, often unusable.
- **Style Influence at 100%**: can flatten creativity.
- **Two sliders interact**: high Weirdness + high Style Influence = stays inside genre but explores; high Weirdness + low Style Influence = full chaos.

---

## 10. English BPM ranges per genre

| Genre | Range | Sweet spot |
|---|---|---|
| Lo-fi / Chill | 60–85 | 72 |
| R&B / Soul / Neo-soul | 65–90 | 78 |
| Hip-Hop (boom-bap) | 80–100 | 88 |
| Reggaeton | 88–100 | 95 |
| Indie folk / acoustic | 85–110 | 95 |
| Country (modern) | 85–110 | 96 |
| Pop | 100–130 | 118 |
| Rock | 110–140 | 128 |
| House | 120–130 | 124 |
| Techno | 125–150 | 135 |
| Trap | 130–170 | 140 (half-time feel) |
| Drum & Bass | 160–180 | 174 |

Thai sub-genre BPM ranges live in `thai-genre-craft.md` to avoid duplication.

---

## 11. Persona / Voices / Extend / Song Editor — Thai workflow

### Why this matters more for Thai than for English

Suno's Thai phonology is unstable take-to-take. The same lyric on two regenerations can have different vowel lengths, different tone realizations, different consonant cluster fidelity. Persona and Voices exist primarily to LOCK these decisions once Suno has gotten them right on a take.

### Workflow A — Persona-lock for series/EP work

1. Generate the song. Iterate Style + sliders until take N feels right.
2. On the good take: ⋮ → Create → Make Persona.
3. Next song in the EP: attach the Persona in Custom Mode (above the Lyrics field). The Persona inherits vocal identity + accent realization + diction fidelity.
4. For Thai specifically: this is the single most reliable way to keep a series consistent in Thai pronunciation. Without Persona, regenerations drift between Bangkok Thai, Central Thai, English-accented Thai unpredictably.

**Limitations:**
- Personas cannot be combined with Extend in v4.5 (was allowed in earlier versions)
- v5+ allows Persona + Cover
- Personas cannot be created from your own voice — for that, use Voices (v5.5)

### Workflow B — Voices for dialect lock-in (v5.5 only)

v5.5 Voices = clone a voice from an uploaded sample. For Thai:

- Upload 30+ sec of clean Thai vocal in the target dialect (Bangkok, Isan, Northern, Southern)
- Voices preserves the dialect; the Style field's "central Thai with Isan flavor" cue is then redundant — drop it from Style to free character budget
- Voices override the Vocal Gender toggle

**When you have a Voice attached:** drop `male vocals` / `female singer` / `young female alto` tags from the Styles field. The Voice locks vocal identity; tags waste character budget (especially critical for v5's 200-char Style limit).

### Workflow C — Extend with Thai tone preservation

Extend resumes a song from a chosen timestamp. For Thai, two failure modes are common:

- **Tone drift** — the model "forgets" the established tone realization of the hook word and sings it differently in the extended section
- **Accent drift** — Bangkok Thai drifts toward Central/Isan or vice versa across the seam

Mitigations:

- **Extend from a timestamp BEFORE the hook word**, not after. The model needs the hook in its short context to maintain it.
- **Re-paste the hook lyric** in the Extend lyrics field, even if it appeared in the original. Suno's Extend context window is smaller than people expect.
- For dialect-critical sections, prefer Persona + new song over Extend.

### Workflow D — Song Editor (Replace Section) for fixing เพี้ยน

When a single Thai line is mispronounced but the rest of the take is good:

1. Highlight the broken section on the timeline
2. Right-click → Replace Section
3. In the popup: paste the SAME lyric line with phonetic respelling applied (see `thai-phonetic-respelling.md`)
4. Generate 2 variants. Keep the better one.

This is faster and cheaper than re-rolling the whole song. For Thai songs, Replace Section is the canonical fix path for the 1–2 line problems that survive Step 7 audits.

### Cross-tier behavior

| Tier | Persona | Voices | Extend | Song Editor |
|---|---|---|---|---|
| Free (v4.5-all) | No | No | Yes | Limited |
| Pro / Premier (v4.5+ / v5 / v5.5) | Yes | v5.5 only | Yes | Yes |

The skill's default iteration tips assume Pro/Premier. For Free-tier users, add the caveat: "ถ้ามีสิทธิ์ Pro แล้วเพลงนี้ดี — กด Make Persona ก่อนแต่งเพลงต่อไปในชุดเดียวกัน. ถ้าไม่มี Pro ใช้ Replace Section ได้ แต่ Persona ใช้ไม่ได้."

---

## 12. Vocal Gender, Title field, Audio Upload

### Vocal Gender toggle

A binary Male/Female switch. Suno honors it well in v4.5+. Edge cases:

- **Duet/multi-vocal:** the toggle picks the *primary* lead. Force a switch via lyric tag `[Female Vocal]` or `[Male Vocal]` at the section where the second voice should enter.
- **Backing vocals:** may inherit the opposite gender automatically for harmonic richness.
- **Persona overrides:** if a Persona is attached, the Persona's vocal identity outranks the Vocal Gender toggle.

For Thai songs, female voices render vowels slightly more clearly in v4.5/v4.5+. Both work.

### Title field

Per Suno's official docs and community testing, **the title does NOT meaningfully influence audio output**. Use it for catalog organization. Pick something memorable that echoes the chorus hook or a key image.

### Audio Upload (the "+ Audio" button)

| Tier | Upload length | Workflows |
|---|---|---|
| Free / Basic | 6–60 sec (or in-browser recording) | Extend, Cover |
| Pro / Premier | up to 8 min uploads, up to 120 sec in-browser | Cover, Extend, **Add Vocals**, **Add Instrumentals** |

Three workflows after upload:

1. **Extend** — start from a timestamp, generate continuation in the chosen style
2. **Cover** — same melody/structure, new style and/or vocal. Does NOT change lyrics unless you replace them
3. **Add Vocals / Add Instrumentals** (v4.5+ exclusive) — layer AI vocals onto your instrumental, or AI backing onto your vocal

When audio is in play, the **Audio Influence** slider appears:
- High (75–100%) — keeps groove/melody/timing close to upload
- Low (10–30%) — treats upload as loose inspiration only

Copyrighted material is auto-blocked. Uploads with vocals are kept private and unsearchable.

---

## 13. Custom Mode vs. Simple Mode

Always use **Custom Mode** (the "Advanced" tab in mobile app, "Custom" toggle on web). Simple Mode strips:
- Section tags
- Slider controls
- Vocal Gender toggle
- Persona attachment
- Negative prompts

The skill always assumes Custom Mode.

---

## 14. v4.5+all family vs v5 / v5.5 — feature matrix

### What "v4.5+all" means

The label "v4.5+all" is the unified family containing three sub-models:

| Model | Tier | Notes |
|---|---|---|
| v4.5 | Pro/Premier (beta) | Original v4.5 |
| v4.5+ | Pro/Premier | Adds Add Vocals, Add Instrumentals, Inspire |
| v4.5-all | Free | Free-tier replacement; slightly less powerful but full-featured |

### Newer models in the dropdown

- **v5 (chirp-crow)** — Sept 23, 2025 — studio-grade fidelity, more natural vocals, 12-stem separation, Persona Voices, Sample-to-Song, 4-min Extends, powers Suno Studio. **⚠ 200-char Style limit (down from 1,000)**.
- **v5.5** — Mar 26, 2026 — Voice Cloning ("Voices"), Custom Models (train on your catalog, up to 3), "My Taste" passive personalization. **Style limit restored to 1,000 chars.** No prompt-syntax change.

### Feature matrix

| Feature | v4.5 | v4.5+ | v4.5-all | v5 | v5.5 |
|---|---|---|---|---|---|
| Lyrics field | 5,000 | 5,000 | 5,000 | 5,000 | 5,000 |
| Styles field | 1,000 | 1,000 | 1,000 | **200** | 1,000 |
| Inline parens cues (Layer 2b) | inconsistent | inconsistent | inconsistent | yes | yes |
| v5+ meta tags (Layer 3) | no | no | no | yes | yes |
| Persona | yes | yes | no | yes | yes |
| Voices (clone) | no | no | no | no | yes |
| Cover | yes | yes | yes | yes | yes |
| Extend | yes | yes | yes | yes | yes |
| Stems (2-stem) | yes | yes | yes | yes | yes |
| Stems (12-stem) | no | no | no | yes | yes |
| Song Editor (Replace Section) | yes | yes | limited | yes | yes |
| Add Vocals / Add Instrumentals | no | yes | no | yes | yes |
| Add Vocals + Persona | no | yes | no | yes | yes |
| Custom Models | no | no | no | no | yes |

The skill's output works identically across all v4.5+ and v5+ — only Persona/Voice features, audio fidelity, and Style character budget change.

---

## 15. Avoiding artist-name violations

Suno blocks recognized artist names (and many lookalikes). Generations may fail or be silently filtered.

**Never write:**
- "in the style of [Bodyslam / Polycat / Bird Thongchai / Carabao / Loso / etc.]"
- "[Artist Name] vibe"
- Western artist references (Taylor Swift, Coldplay) — also blocked

**Replace with sonic descriptors:**
- "Bodyslam-style" → `Thai stadium rock, anthemic, soaring male vocals, distorted electric guitars, big drums, 90 BPM`
- "Polycat-style" → `Thai retro city pop, 80s synth, jangly chorus guitar, breathy male falsetto, gated reverb drums, 110 BPM`
- "Carabao-style" → `phleng phuea chiwit, Thai folk-rock, acoustic guitar, harmonica, weathered male vocals, narrative ballad, 95 BPM`

For more Thai sub-genre templates, see `thai-genre-craft.md`. For English, see `english-genre-craft.md`.

---

## 16. Negative prompting

Two methods:

1. **Inline `no X` in Styles field** (works on free tier): `Thai pop, soft female vocals, 90 BPM, no autotune, no electric guitar`
2. **Exclude field** (Pro/Premier — Advanced Options): same syntax, dedicated field

Reliable patterns: `no autotune`, `no drums`, `no electric guitar`, `no choir`.
Less reliable: `don't add X`, `avoid X` (Suno doesn't parse "don't").

Negatives are guidance, not bans — excluded elements may still appear ~10–20% of the time.

Order: positives first, exclusions last. Max 1–2 negatives.

---

## 17. Common mistakes to avoid

- Putting structure tags `[Verse]` in the Styles field (gets sung)
- Using artist names in Styles (silently filtered)
- Writing >3,000 chars of lyrics (Suno rushes/skips)
- Romanizing Thai instead of Thai script (worse pronunciation) — see `thai-phonetic-respelling.md` for the in-Thai-script alternative
- Mixing Thai+English in same line without anchoring — see `bilingual-mixing.md` §2
- Stacking 6+ instrument tags
- Conflicting moods ("calm" + "aggressive")
- Using `[Hook]` and expecting verbatim repeat (write the lyric out)
- Leaving Weirdness at default 50% for radio-pop expectations (too unpredictable)
- Forgetting Custom Mode (Simple Mode strips controls)
- Stacking multiple bracket vocal cues per section (`[Belted]` + `[Whispered]` on same section)
- Stacking multiple inline parens cues per section (more than one `(whispered)` / `(belted)` / etc. in the same Verse/Chorus)
- Stacking >3 v5+ meta tags
- Letting directives exceed 30% of Lyrics field character count
- Using v5 with Style strings >200 chars (silent truncation)
