# English Song Structure & Form

Reference for English song forms, section functions, and structural conventions per genre. Used by Step 3 (composition planning) and Step 7-D (form-validation in the English rhyme audit).

## 1. The dominant forms

### Verse-Chorus (V-C-V-C-B-C)

The default form in pop, rock, country, R&B, and modern dance-pop. The full pop template:

```
Intro → Verse 1 → Pre-Chorus → Chorus
       → Verse 2 → Pre-Chorus → Chorus
       → Bridge  → Chorus  → Outro
```

The chorus repeats lyrically and musically every time; verses get new lyrics over the same melodic frame.

**Mandatory**: at least 2 verses, at least 2 choruses, at least 1 bridge (for songs >2:30).
**Optional**: pre-chorus, post-chorus.

### AABA (32-bar form)

The older "American popular song form." Four 8-bar sections:
- A (verse with the hook)
- A (verse — same melody, new lyric)
- B (bridge — contrasting melody and lyric)
- A (verse — return)

Cole Porter, Gershwin, Berlin, jazz standards, theatre songs, country ballads, some folk. Title typically lands at the first AND last line of every A section.

Modern variations: 6-6-9-8 (Sondheim's "Send in the Clowns"), AABA-extended with a coda.

### 12-bar blues / AAB

Three 4-bar phrases per "verse":
- A — states a situation
- A or A' — repeats with slight variation
- B — answers/resolves and rhymes back to A

Harmonic frame: I–I–I–I / IV–IV–I–I / V–IV–I–I. Each "verse" is one 12-bar cycle; songs typically have 3–5 verses.

### Through-composed

No repeating sections. Each part musically distinct, tied only by narrative. Rare. "Bohemian Rhapsody" is the canonical example. **Hard for Suno to handle reliably** — flag if user requests this and warn that 2–3 regenerations are typical, and that the section anchors must be very clear (`[Section A]`, `[Section B]`, etc.).

### EDM / Drop-based

Different vocabulary:
- A = intro/outro
- B = verse
- D = drop / chorus equivalent
- E = bridge

Typical layout: `A B D B D A` or `A B D E D A`.

The drop replaces the lyrical chorus as the energy peak; the lyrical hook often sits in a post-chorus around the drop. The drop itself is often **instrumental** with a sung tag.

### Hip-hop / Rap

```
Intro (4 bars) → Verse 1 (16 bars) → Hook (8 bars)
              → Verse 2 (16 bars) → Hook
              → Verse 3 (16 bars) → Outro
```

Modern radio rap often shrinks verses to 12 bars. The hook is the chorus in hip-hop — terms are interchangeable.

## 2. Section functions

### Intro
- Establishes key, tempo, mood, and (sometimes) the hook tease.
- 2–8 bars typical.
- Often instrumental in pop; may include a vocal hook preview ("oh oh oh").
- Suno tag: `[Intro]` or `[Soft fingerpicked guitar intro]`.

### Verse
- Story development. New lyrics each time over the same melodic frame.
- Conversational register, narrower melodic range than chorus.
- 8–16 bars.
- Lyric job: setup. Concrete imagery, specifics, point-of-view.
- First verse must hit hard in the first 5 seconds (Pattison's "show", ครูสลา's "5-second rule").

### Pre-chorus ("lift" / "climb" / "B-section")
- Micro-build into chorus. Creates anticipation.
- 4–8 bars.
- Held chord, rising melody, lyric pivot.
- Often uses different rhymes than the verse and chorus to act as a hinge.
- Tempo here often quickens; shorter words (4–6 syllables/line) work well.

### Chorus / Hook
- Title and emotional thesis. The song's argument in compressed form.
- 8–16 bars.
- Higher melodic register, biggest dynamics, densest rhyme.
- **Same lyric every repetition** — paste identically in every chorus slot for Suno.
- Hook position: line 1, last line, both, or every line.

### Post-chorus
- Short tag extending chorus payoff.
- Often a wordless "oh oh oh" or repeated title phrase.
- Standard in modern EDM-pop, Weeknd-era pop, some K-pop.
- 4–8 bars.

### Bridge ("middle 8")
- Happens once, between chorus 2 and the final chorus.
- 8–16 bars.
- Functions: contrast (new chords/key), perspective shift, emotional climax, or "rant bridge" of accumulated detail.
- Taylor Swift's bridges are the modern canonical case — list-style accumulation peaking on the most vulnerable line.
- Required for songs >2:30. Skippable for shorter songs.

### Outro
- Wind-down.
- Often a repeated chorus tag or vamp on the final chord.
- Optional fade-out via Suno's `[Fade Out]` tag.

## 3. Tempo + section-length per genre

| Genre | BPM range | Default structure | Verse bars | Chorus bars |
|---|---|---|---|---|
| Pop ballad | 60–85 | V-PC-C-V-PC-C-B-C | 16 | 8–16 |
| Pop upbeat | 100–130 (sweet 118–128) | V-PC-C-V-PC-C-B-C | 8–16 | 8 |
| Country | 118–125 | V-C-V-C-B-C (58% of #1s) | 8–16 | 8 |
| Rock | 120–135 (punk 135+) | V-C-V-C-B-C | 8–16 | 8 |
| Folk / singer-songwriter | 60–100 | V-C-V-C-B-C or AABA | 8–16 | 8 |
| Hip-hop / rap | 70–100 | I-V-H-V-H-V-O | 16 (12 modern) | 8 |
| R&B | 70–100 | V-PC-C-V-PC-C-B-C | 16 | 8–16 |
| EDM / dance | 120–140 (DnB 153+) | A-B-D-B-D-A | 8–16 | 8 (drop) |
| Indie | 90–125 | flexible | 8–16 | 8 |
| Blues | 60–120 | 12-bar AAB cycled | n/a | n/a |
| Lo-fi / Chill | 60–85 | loose verse-chorus | 8–16 | 8 |
| Trap | 130–170 half-time | I-V-H-V-H-O | 16 | 8 |
| Drum & Bass | 160–180 | A-B-D-B-D-A | 8–16 | 8 |

## 4. The "two-verse" convention and when bridges are required

- **Required** when the song crosses 2:30 — without a bridge, the third chorus feels redundant.
- **Required** when the song has a perspective shift or emotional climax to deliver.
- **Optional** for songs ≤2:30 or for genres that prefer hypnotic repetition (hip-hop with a third verse instead, EDM with longer drops).
- **Avoid** when the lyric idea doesn't have a third dimension. A forced bridge that says nothing new is worse than no bridge.

## 5. Form selection decision tree

```
User picks genre →

  Pop / R&B / modern country / dance-pop →
    V-PC-C-V-PC-C-B-C  (default)
    
  Story-driven country / folk / ballad →
    V-C-V-C-B-C without pre-chorus
    OR AABA (especially for ballads)
    
  Hip-hop →
    Intro + 16-bar verses + 8-bar hook, 3 verses
    OR replace bridge with a third verse / beat switch
    
  Blues →
    12-bar AAB cycled, 3–5 verses
    
  EDM →
    A-B-D-B-D-A (or A-B-D-E-D-A with bridge)
    
  Theatrical / unusual narrative →
    AABA or through-composed
    ⚠ Through-composed: warn user this is hard for Suno; 2–3 regenerations typical
```

## 6. Section-anchor conventions in Suno

The skill's existing rules apply, with one bilingual addition. From `suno-fields-reference.md`:

```
[Intro]
[Verse]  [Verse 1]  [Verse 2]  [Verse 3]
[Pre-Chorus]
[Chorus]
[Post-Chorus]
[Bridge]
[Refrain]
[Interlude]
[Instrumental]   [Instrumental Break]
[Solo]  [Guitar Solo]  [Piano Solo]  [Sax Solo]
[Break]
[Build]    [Drop]
[Outro]
[End]
[Fade Out]
[Tag]
```

For bilingual songs, append `(English)` or `(Thai)` after each section header. See `bilingual-mixing.md`.

## 7. The form audit (used inside Step 7-D)

When reviewing English lyrics for form (alongside rhyme), check:

1. **Does the song have at least one verse, one chorus, and (for >2:30) one bridge?**
2. **Is the chorus pasted identically in every chorus slot?** (Suno requirement — referencing `[Chorus]` without text gets improvised badly.)
3. **Are section tags from the recognized vocabulary?** Custom labels like `[My Cool Section]` are NOT understood by Suno; flag.
4. **Are section tags placed on their own lines?**
5. **Does verse 1 open with a concrete image / specific noun?** (Pattison's show-don't-tell, ครูสลา's first-5-seconds rule.) Soft flag if verse 1 is all abstraction.
6. **Is the bridge contrasting?** A bridge identical in feel to the verse is wasted real estate.

Flags emit in the standard format `- Line "…" or Section "…": [issue], suggest "…"`.

## 8. Quick reference

| Genre | Required structure | Optional |
|---|---|---|
| Pop ballad | V-PC-C-V-PC-C-B-C | post-chorus |
| Pop upbeat | V-PC-C-V-PC-C-B-C | post-chorus, second bridge |
| Country | V-C-V-C-B-C | pre-chorus, post-chorus |
| Rock | V-C-V-C-B-C | pre-chorus, solo |
| Folk | V-C-V-C-B-C or AABA | bridge optional |
| Hip-hop | I-V-H-V-H-V-O | bridge replaced by 3rd verse |
| R&B | V-PC-C-V-PC-C-B-C | post-chorus |
| EDM | A-B-D-B-D-A | bridge |
| Blues | 12-bar AAB × 3–5 | turnaround |
| Indie | flexible | anything goes |
