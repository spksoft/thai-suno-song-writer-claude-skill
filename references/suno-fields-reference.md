# Suno v4.5 / v4.5+ / v4.5-all / v5 / v5.5 — Complete Field Reference

## Hard limits (verified Q4 2025–Q2 2026)

| Field | v4.5 family | v5 | v5.5 | Behavior past limit |
|---|---|---|---|---|
| Lyrics (Custom mode) | 5,000 chars | 5,000 | 5,000 | silently truncated; aim for ≤3,000 |
| Styles | 1,000 chars | **200 chars** | 1,000 | **silently truncated with no warning** — front-load critical tags |
| Title | 80 chars | 80 | 80 | truncated |
| Audio upload (Free) | 6–60 sec | 6–60 | 6–60 | rejected |
| Audio upload (Pro/Premier) | up to 8 min | up to 8 min | up to 8 min | — |
| Max song length | 8 min | 8 min | 8 min | — |

⚠ **v5's 200-char Style limit** is the most consequential trap. Tags after position 200 are dropped silently. When building Styles strings for users on v5, put genre + mood + vocal + BPM tags first; production details and diction cues last. v5.5 restores the 1,000-char budget.

The v4.5 sub-models (v4.5, v4.5+, v4.5-all) share identical character limits and slider behavior. They differ only in tier access and which co-creation features (Add Vocals, Add Instrumentals, Inspire) are exposed.

## The cardinal rule: brackets vs. parentheses

| Notation | Suno reads it as | Use case |
|---|---|---|
| `[ ... ]` | Direction / metadata — **NOT sung** | Section headers, instrument calls, FX, vocal style cues |
| `( ... )` | Sung as **backing vocals / harmony / echo / ad-lib** | "I'm gone (gone, gone away)" |
| Plain text | Sung literally as lead vocal | Main lyric line |

Suno does NOT understand prose instructions. Writing "make this part louder" inside the lyrics field will be sung as a literal lyric. Always use the bracket grammar.

## Section structure tags (most reliable)

Place each on its own line. Recognized tokens:

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

## Vocal performance tags

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

## Instrumentation tags

```
[Acoustic Guitar]   [Electric Guitar]   [Distorted Guitar]
[Piano]   [Strings]   [Drums]   [808s]   [Bass]
[Synth Pad]   [Saxophone]   [Brass]
[Khaen]   [Phin]   ← Thai instruments; Suno recognizes these
```

## Production / FX tags

```
[Reverb]   [Reverb Heavy]
[Lo-fi]
[Distorted]
[Auto-tuned]
[Echoing Vocals]
[Whispered Backing]
```

## Meta tags (soft hints, not guarantees)

These are interpreted loosely:

```
[Tempo: 92 BPM]
[Key: A minor]
[Mood: Melancholic]
[Energy: High]
[Vocal Style: Soft Male]
[Instrument: Piano]
```

## The Styles field — composition order

Comma-separated tags consistently outperform prose. Order:

```
[Genre] → [Sub-genre / Era] → [Mood] → [2–3 instruments] → [Vocal cue] → [Production / mix] → [BPM] → [Thai diction cue]
```

**Limits:** 4–8 tags total. 1–2 genre tags. 2–3 instrument tags. 1–2 mood tags. **Do NOT exceed 3–4 instruments** — confuses the model.

**Always include** a Thai-pronunciation cue at the end:
- `clear native Thai diction`
- `Thai vocals in Bangkok accent, no English drift`
- `central Thai with Isan flavor` (for luk thung/mor lam)

## Avoiding artist-name violations

Suno blocks recognized artist names (and many lookalikes). Generations may fail or be silently filtered.

**Never write:**
- "in the style of [Bodyslam / Polycat / Bird Thongchai / Carabao / Loso / etc.]"
- "[Artist Name] vibe"
- Western artist references (Taylor Swift, Coldplay) — also blocked

**Replace with sonic descriptors:**
- "Bodyslam-style" → `Thai stadium rock, anthemic, soaring male vocals, distorted electric guitars, big drums, 90 BPM`
- "Polycat-style" → `Thai retro city pop, 80s synth, jangly chorus guitar, breathy male falsetto, gated reverb drums, 110 BPM`
- "Carabao-style" → `phleng phuea chiwit, Thai folk-rock, acoustic guitar, harmonica, weathered male vocals, narrative ballad, 95 BPM`

## Negative prompting

Two methods:

1. **Inline `no X` in Styles field** (works on free tier): `Thai pop, soft female vocals, 90 BPM, no autotune, no electric guitar`
2. **Exclude field** (Pro/Premier — Advanced Options): same syntax, dedicated field

Reliable patterns: `no autotune`, `no drums`, `no electric guitar`, `no choir`
Less reliable: `don't add X`, `avoid X` (Suno doesn't parse "don't")

Negatives are guidance, not bans — excluded elements may still appear ~10–20% of the time.

Order: positives first, exclusions last. Max 1–2 negatives.

## The Creative Sliders (official Suno terminology)

| Slider | Range | What it does | Default |
|---|---|---|---|
| **Weirdness** | Safe → Chaos | How far Suno deviates from conventional patterns | 50% |
| **Style Influence** | Loose → Strong | How strictly Suno follows the Styles text | 50% |
| **Audio Influence** | Loose → Strong | How strictly Suno follows uploaded reference audio (only appears when Audio is uploaded) | 50% |

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

For both tables, **state a single number, not a range, in the final output**. Pick the midpoint unless the user said "experimental" or "very mainstream."

### English BPM ranges per genre (community-validated)

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

### Edge behavior

- **Weirdness >80%**: genuinely chaotic — sometimes brilliant, often unusable.
- **Style Influence at 100%**: can flatten creativity.
- **Two sliders interact**: high Weirdness + high Style Influence = stays inside genre but explores; high Weirdness + low Style Influence = full chaos.

## Vocal Gender toggle

A binary Male/Female switch. Suno honors it well in v4.5+. Edge cases:

- **Duet/multi-vocal:** the toggle picks the *primary* lead. Force a switch via lyric tag `[Female Vocal]` or `[Male Vocal]` at the section where the second voice should enter.
- **Backing vocals:** may inherit the opposite gender automatically for harmonic richness.
- **Persona overrides:** if a Persona is attached, the Persona's vocal identity outranks the Vocal Gender toggle.

For Thai songs, female voices tend to render vowels slightly more clearly in v4.5/v4.5+, but both work.

## Title field

Per Suno's official docs and community testing, **the title does NOT meaningfully influence audio output**. Use it for catalog organization. Pick something memorable that echoes the chorus hook or a key image.

## Audio Upload (the "+ Audio" button)

| Tier | Upload length | Workflows |
|---|---|---|
| Free / Basic | 6–60 sec (or in-browser recording) | Extend, Cover |
| Pro / Premier | up to 8 min uploads, up to 120 sec in-browser | Cover, Extend, **Add Vocals**, **Add Instrumentals** |

Three workflows after upload:

1. **Extend** — start from a timestamp, generate continuation in the chosen style.
2. **Cover** — same melody/structure, new style and/or vocal. Does NOT change lyrics unless you replace them.
3. **Add Vocals / Add Instrumentals** (v4.5+ exclusive) — layer AI vocals onto your instrumental, or AI backing onto your vocal.

When audio is in play, the **Audio Influence** slider appears:
- High (75–100%) — keeps groove/melody/timing close to upload
- Low (10–30%) — treats upload as loose inspiration only

Copyrighted material is auto-blocked. Uploads with vocals are kept private and unsearchable.

## Personas, Covers, Stems — advanced workflow

- **Persona** = saved "DNA" of a song's vocal+aesthetic. Pro/Premier. ⋮ menu → Create → Make Persona, then attach in Custom Mode above Lyrics. Cannot be used with Extend in v4.5; cannot be created from your own voice (until v5.5 Voice Cloning).
- **Cover** = re-skin melody/structure with new style; preserves more melodic detail than v4.
- **Persona + Cover** combined = the v4.5 flagship workflow for series/EP work.
- **Stem extraction** = 2-stem (Vocal + Instrumental) or 12-stem (drums, bass, lead, harmony, etc.). ⋮ menu → Get Stems. Export: MP3, WAV, Tempo-Locked WAV, MIDI.
- **Song Editor** = inpainting on the timeline. Highlight a region → "Replace Section" → new lyrics/style → preview two variants → Commit or Regenerate. Best way to fix individual broken Thai lines without re-rolling the whole track.

## Custom Mode vs. Simple Mode

Always use **Custom Mode** (the "Advanced" tab in mobile app, "Custom" toggle on web). Simple Mode strips:
- Section tags
- Slider controls
- Vocal Gender toggle
- Persona attachment
- Negative prompts

The skill always assumes Custom Mode.

## What "v4.5+all" means in the UI

The label "v4.5+all" is the unified family containing three sub-models:

| Model | Tier | Notes |
|---|---|---|
| v4.5 | Pro/Premier (beta) | Original v4.5 |
| v4.5+ | Pro/Premier | Adds Add Vocals, Add Instrumentals, Inspire |
| v4.5-all | Free | Free-tier replacement; slightly less powerful but full-featured |

Newer alternatives in the dropdown:
- **v5 (chirp-crow)** — Sept 23, 2025 — studio-grade fidelity, more natural vocals, 12-stem separation, Persona Voices, Sample-to-Song, 4-min Extends, powers Suno Studio. **⚠ 200-char Style limit (down from 1,000)**.
- **v5.5** — March 26, 2026 — Voice Cloning ("Voices"), Custom Models (train on your catalog, up to 3), "My Taste" passive personalization. **Style limit restored to 1,000 chars.** No prompt-syntax change.

The skill's output works identically across all v4.5+ and v5+ — only Persona/voice features, audio fidelity, and Style character budget change.

**When user has a Voice attached (v5.5)**: drop `male vocals` / `female singer` / `young female alto` tags from the Style field. The Voice locks vocal identity; the tag wastes character budget.

## Common mistakes to avoid

- Putting structure tags `[Verse]` in the Styles field (gets sung)
- Using artist names in Styles (silently filtered)
- Writing >3,000 chars of lyrics (Suno rushes/skips)
- Romanizing Thai instead of Thai script (worse pronunciation)
- Mixing Thai+English in same line without anchoring
- Stacking 6+ instrument tags
- Conflicting moods ("calm" + "aggressive")
- Using `[Hook]` and expecting verbatim repeat (write the lyric out)
- Leaving Weirdness at default 50% for radio-pop expectations (too unpredictable)
- Forgetting Custom Mode (Simple Mode strips controls)
