# English Genre Craft: Forms, Frameworks, Conventions & Templates

Unified English-side reference for **song forms**, **songwriting frameworks**, **per-genre conventions**, and **Style templates**. Used by Step 3 (composition), Step 4 (Styles), Step 7-D (form/density audit).

Replaces `song-structure-en.md` + `lyric-frameworks-en.md` + `genre-conventions-en.md` + `style-templates-en.md`.

**TOC:** 1. Song forms · 2. Frameworks (Pattison/Davis/Sondheim/Stolpe/Webb/Blume + show-don't-tell, hook, POV) · 3. Genre conventions (13 genres) · 4. Style templates.

**Cross-refs:** `english-prosody-rhyme.md` (stress/rhyme/diction), `suno-platform.md` (tags, sliders, directives), `bilingual-mixing.md` (code-switching).

---

## 1. Song forms

### 1.1 Dominant forms

**Verse-Chorus (V-C-V-C-B-C)** — Default in pop, rock, country, R&B, modern dance-pop.

```
Intro → Verse 1 → Pre-Chorus → Chorus
       → Verse 2 → Pre-Chorus → Chorus
       → Bridge  → Chorus  → Outro
```

Chorus repeats lyrically and musically every time; verses get new lyrics over the same melodic frame. **Mandatory:** ≥2 verses, ≥2 choruses, ≥1 bridge (for songs >2:30). **Optional:** pre-chorus, post-chorus.

**AABA (32-bar form)** — Older "American popular song form." Four 8-bar sections: A (verse with hook) · A (same melody, new lyric) · B (bridge — contrasting melody and lyric) · A (return). Cole Porter, Gershwin, Berlin, jazz standards, theatre songs, country ballads. Title typically lands at the first AND last line of every A section. Modern variations: 6-6-9-8 (Sondheim's "Send in the Clowns"); AABA-extended with a coda.

**12-bar blues / AAB** — Three 4-bar phrases per "verse": A (states a situation) · A or A' (repeats with slight variation) · B (answers/resolves and rhymes back to A). Harmonic frame: I–I–I–I / IV–IV–I–I / V–IV–I–I. Each "verse" is one 12-bar cycle; songs typically have 3–5 verses.

**Through-composed** — No repeating sections. Each part musically distinct, tied only by narrative. Rare. "Bohemian Rhapsody" is canonical. **Hard for Suno to handle reliably** — flag if user requests this; warn 2–3 regenerations typical; section anchors must be very clear (`[Section A]`, `[Section B]`, etc.).

**EDM / Drop-based** — Different vocabulary: A = intro/outro · B = verse · D = drop / chorus equivalent · E = bridge. Typical layout: `A B D B D A` or `A B D E D A`. The drop replaces the lyrical chorus as the energy peak; the lyrical hook often sits in a post-chorus around the drop. The drop itself is often **instrumental** with a sung tag.

**Hip-hop / Rap:**
```
Intro (4 bars) → Verse 1 (16 bars) → Hook (8 bars)
              → Verse 2 (16 bars) → Hook
              → Verse 3 (16 bars) → Outro
```
Modern radio rap often shrinks verses to 12 bars. The hook is the chorus in hip-hop — terms are interchangeable.

### 1.2 Section functions

- **Intro** (2–8 bars) — establishes key, tempo, mood, sometimes hook tease. Often instrumental; may include vocal hook preview ("oh oh oh"). Tag: `[Intro]`.
- **Verse** (8–16 bars) — story development. New lyrics each time over same melodic frame. Conversational register, narrower melodic range than chorus. Job: setup — concrete imagery, POV. First verse must hit hard in the first 5 seconds (Pattison + ครูสลา).
- **Pre-chorus / lift / B-section** (4–8 bars) — micro-build into chorus. Held chord, rising melody, lyric pivot. Often different rhymes from verse/chorus (hinge). Tempo quickens; shorter words (4–6 syll/line).
- **Chorus / Hook** (8–16 bars) — title and emotional thesis. Higher melodic register, biggest dynamics, densest rhyme. **Same lyric every repetition** — paste identically in every chorus slot. Hook position: line 1, last, both, or every line.
- **Post-chorus** (4–8 bars) — short tag extending chorus payoff. Often wordless "oh oh oh" or repeated title. Standard in modern EDM-pop, some K-pop.
- **Bridge / middle 8** (8–16 bars) — happens once, between chorus 2 and final chorus. Functions: contrast (new chords/key), perspective shift, emotional climax, or "rant bridge" of accumulated detail. Required for songs >2:30.
- **Outro** — wind-down; repeated chorus tag or vamp; optional `[Fade Out]`.

### 1.3 Tempo + section-length per genre

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

### 1.4 Bridges: when required, when to skip

- **Required** for songs >2:30 — without one the third chorus feels redundant.
- **Required** when the song has a perspective shift or emotional climax.
- **Optional** for songs ≤2:30 or genres that prefer hypnotic repetition (hip-hop with a third verse, EDM with longer drops).
- **Avoid** when the lyric has no third dimension. A forced bridge saying nothing new is worse than no bridge.

### 1.5 Form selection decision tree

```
User picks genre →

  Pop / R&B / modern country / dance-pop →
    V-PC-C-V-PC-C-B-C  (default)

  Story-driven country / folk / ballad →
    V-C-V-C-B-C without pre-chorus, OR AABA (especially ballads)

  Hip-hop →
    Intro + 16-bar verses + 8-bar hook × 3 verses
    OR replace bridge with a third verse / beat switch

  Blues →
    12-bar AAB cycled, 3–5 verses

  EDM →
    A-B-D-B-D-A (or A-B-D-E-D-A with bridge)

  Theatrical / unusual narrative →
    AABA or through-composed
    ⚠ Through-composed: warn user — hard for Suno; 2–3 regenerations typical
```

### 1.6 Section-anchor vocabulary in Suno

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

For bilingual songs, append `(English)` or `(Thai)` after each section header — see `bilingual-mixing.md`.

### 1.7 Form audit (Step 7-D form sub-section)

1. Song has ≥1 verse, ≥1 chorus, and (for >2:30) ≥1 bridge?
2. Chorus pasted identically in every chorus slot? (Suno requirement — `[Chorus]` without text gets improvised badly.)
3. Section tags from §1.6 vocabulary? Custom labels like `[My Cool Section]` are NOT understood by Suno; flag.
4. Section tags placed on their own lines?
5. Verse 1 opens with a concrete image / specific noun? (Pattison + ครูสลา.) Soft flag if all abstraction.
6. Bridge contrasting? A bridge identical in feel to the verse is wasted real estate.

### 1.8 Required structure quick reference

| Genre | Required | Optional |
|---|---|---|
| Pop ballad | V-PC-C-V-PC-C-B-C | post-chorus |
| Pop upbeat | V-PC-C-V-PC-C-B-C | post-chorus, 2nd bridge |
| Country | V-C-V-C-B-C | pre-chorus, post-chorus |
| Rock | V-C-V-C-B-C | pre-chorus, solo |
| Folk | V-C-V-C-B-C or AABA | bridge optional |
| Hip-hop | I-V-H-V-H-V-O | bridge replaced by 3rd verse |
| R&B | V-PC-C-V-PC-C-B-C | post-chorus |
| EDM | A-B-D-B-D-A | bridge |
| Blues | 12-bar AAB × 3–5 | turnaround |
| Indie | flexible | anything goes |

---

## 2. Songwriting frameworks

Named, citable frameworks distilled into operational rules for Step 3 (composition) and Step 7-D (hook/structure audit).

### 2.1 Pat Pattison (Berklee)

Most-cited modern songwriting academic. Four operational concepts:

**(a) Object writing — concrete sensory imagery.** Brainstorm in all 7 senses for the central scene: Sight (colors, shapes, light) · Sound · Taste · Touch (textures, temps) · Smell · Body (heartbeat, balance, dizziness) · Organic motion (breathing, growth, decay). When user describes a scene, generate 2–3 sensory candidates for verse 1 rather than starting with "I feel sad."

**(b) Prosody = unity.** Every craft choice — meter, rhyme, melody, dynamics — is evaluated by whether it makes the song MORE or LESS unified. Between two options, pick the one that more strongly supports the central idea.

**(c) Stable vs unstable — the master grid.** Match instability to instability in content.

| Element | Stable | Unstable |
|---|---|---|
| Lines per section | even (2, 4) | odd (3, 5) |
| Line length | equal | varied |
| Rhyme scheme | AABB, AABA | ABAB, ABCB, free |
| Rhyme type | perfect, family | additive, subtractive, assonance, consonance |
| Rhyme position | adjacent (couplets) | farther apart |
| Melody phrasing | on downbeat | back-phrased |
| Repeated chorus | exact repeat | varied repeat |

A heartbreak song shouldn't sit on perfectly stable structures — mismatches content with form. A bridge emotional climax should LEAN unstable.

**(d) Six rhyme types** — see `english-prosody-rhyme.md` §2.1 (perfect → family → additive → subtractive → assonance → consonance).

### 2.2 Sheila Davis (NYU)

*The Craft of Lyric Writing* (1985), *Successful Lyric Writing* (1988). Industry framework.

**(a) The title test.** Ira Gershwin (quoted by Davis): "Prove a title is worth using by making sure it's what your lyric is all about." If a one-sentence summary doesn't naturally contain the title, the title is wrong.

**(b) Singability.** Avoid consonant clusters on long held notes; favor open vowels on sustained notes; avoid sibilants on the highest chorus note. (Cross-refs `english-prosody-rhyme.md` §3 #7–8.)

**(c) Front-load OR end-load the hook.** Line 1 (front-loaded) · last line (end-loaded, most common) · both (bookended, strongest) · every line (chant). If title doesn't appear in chorus at all → flag.

### 2.3 Stephen Sondheim — three principles

From *Finishing the Hat* (2010):

1. **Content dictates form.** Subject decides structure, not vice versa. Stream-of-consciousness is wrong for 32-bar AABA.
2. **Less is more.** Every word earns its place. Cut adjectives and throat-clearing.
3. **God is in the details.** Concrete, specific images beat abstract ones.

All three serve a fourth: **Clarity** — lyric is heard once, in real time. Check form against content; during revision ask which words could be cut; replace abstract feeling-words with concrete images; read aloud and simplify if not comprehensible first hearing.

### 2.4 Andrea Stolpe — 10-step framework

*Popular Lyric Writing: 10 Steps to Effective Storytelling* (Berklee Press, 2007). Standard at Berklee, Belmont, USC Thornton.

1. Identify central idea in one sentence
2. Choose POV (1st/2nd/3rd person; direct address vs narrator)
3. Brainstorm sensory imagery (Pattison's object writing)
4. Pick form to fit content (Sondheim's first rule)
5. Decide sectional balance (verse heavy? chorus heavy?)
6. Write the chorus first
7. Write verses to set up the chorus payoff
8. Write the pre-chorus as a hinge
9. Write the bridge as a perspective shift
10. Audit: rhyme, prosody, singability, clarity

When composing from scratch, follow this 10-step order. Chorus first.

### 2.5 Jimmy Webb — marriage of music and lyric

*Tunesmith* (1998). **Melodic shape must reinforce lyric meaning** (precursor to Pattison's prosody = unity). For directional words (up/down/rise/fall), suggest matching melodic move in Styles. For dynamic contrast within a section, suggest production dynamics (`soft verse, building chorus`).

### 2.6 Jason Blume — six-step checklist

*Six Steps to Songwriting Success* (2004/2017). BMI Nashville workshop. Explicit lyric checklist during evaluation:

- Single, clear central idea?
- Every section serves that idea?
- Title appears in the chorus?
- Chorus pays off the verses?
- Imagery concrete and sensory?
- Rhymes natural or forced?
- Song holds attention for its full length?

Incorporated into the English rhyme & form audit (Step 7-D).

### 2.7 Show-don't-tell — three moves

- **Move 1. Concrete nouns over abstractions** — "Empty chairs at the table" not "I'm lonely." "The screen door slammed" not "He left in anger."
- **Move 2. Sensory detail** (Pattison's 7 senses) — specify how it looked, sounded, smelled, felt.
- **Move 3. Action verbs** — "She slammed the screen door" not "She was angry."

**Anti-pattern:** feeling words (love, sad, lonely, broken, free, alive, dead, alone, hurt, happy, joy, pain) on stressed positions. Audit: if a chorus line is >50% abstract feeling-words, suggest swapping one for a concrete image or action verb.

### 2.8 Hook construction — synthesized rules

Title phrase, typically 2–7 syllables. 1) Length: 2–4 most memorable; 5–7 acceptable; >8 risky. 2) Vowel: open (ah/oh/ee) projects better than closed (uh/ih/eh). 3) Placement: line 1, last, both (bookended), every (chant). 4) Repetition: ≥3× per chorus, ≥6× per song. 5) Melodic prominence: highest note or longest sustained note. 6) Singability: avoid consonant clusters and sibilants on high notes.

### 2.9 Point of view (POV)

- **1st person ("I")** — most intimate; pop/R&B/ballad default.
- **2nd person ("you")** — direct address; country love songs, pop confessionals.
- **3rd person ("he/she/they")** — narrator-removed; country story-songs, folk ballads, narrative pop.
- **1st-and-2nd combined** — most common in pop; singer addresses a beloved.

POV must be consistent unless the bridge intentionally shifts. **Audit:** if POV drifts without justification, flag.

### 2.10 Framework quick reference

| Question | Answer |
|---|---|
| How to start writing? | Object writing (Pattison) — 7 senses around the central image |
| What form? | Content dictates form (Sondheim) |
| Where does the title go? | Line 1, last, both, or every line of chorus (Davis) |
| How concrete? | Show, don't tell — concrete nouns, sensory detail, action verbs |
| What rhyme type? | Match instability to content (Pattison) |
| What POV? | 1st-and-2nd is the pop default; 3rd for stories; stay consistent |
| What to cut? | Anything that doesn't earn its place (Sondheim) |
| How to evaluate? | Blume's checklist (§2.6) |

---

## 3. Per-genre conventions

Lyrical and structural conventions per English genre. Used by Step 3 (composition) and Step 7-D (genre-appropriate density check).

### 3.1 Pop (upbeat & ballad)
**Structure:** V-PC-C-V-PC-C-B-C; pre-chorus near-mandatory. **BPM:** 100–130 upbeat (sweet 118–128); 60–85 ballad. **Themes:** love (new/ongoing/lost), self-empowerment, party/night-out, longing, friendship. **Rhyme:** ABAB/ABCB verses; AABB or repeated end-word chorus; perfect + family mix. **Line length:** 4–8 syll verse, 8–12 chorus. **Hook:** bookended or repeated last 2 syll. **Vocabulary:** conversational, present-tense, "you/I/we," short Anglo-Saxon. **Tropes:** "tonight," "forever," "lights," "dance," call-and-response. **Production:** polished, layered, radio-ready.

### 3.2 Rock
**Structure:** V-C-V-C-B-C or V-C-V-C with extended solos; classic rock often AABA-derived. **BPM:** 120–135; pop-punk 135+; ballad-rock 70–90. **Themes:** rebellion, freedom, road/travel, defiance, heartbreak-as-anger, social commentary. **Rhyme:** AABB or ABAB; less internal rhyme; memorable couplets. **Line length:** 6–12 syll, often unequal. **Hook:** chorus title-shout; single-word or short anthem phrases. **Vocabulary:** more polysyllabic Latinate allowed; gritty, plain-spoken. **Tropes:** roads, fire, breaking free, "tonight," loud/quiet dynamic contrast. **Production:** distorted guitars, big drums, wide stereo.

### 3.3 Country
**Structure:** V-C-V-C-B-C (58% of #1s per NSAI); occasionally AABA for ballads. **BPM:** 118–125 — remarkably tight band. **Themes:** nostalgia, small-town life, blue-collar pride, cheating/heartbreak, faith, drinking, trucks, family, weather, dogs. **Rhyme:** AABB or ABCB; perfect rhyme strongly preferred — country audiences notice forced rhyme more than other genres. **Line length:** 8–12 syll. **Hook:** title at end of chorus; story-driven, title as punchline or thematic resolution. **Vocabulary:** plain-spoken, present-tense, Anglo-Saxon, regional ("y'all," "ain't"), proper nouns (town names, brands). **Storytelling:** linear narrative beginning-middle-end is the Nashville norm. **Tropes:** trucks, beer, faith, hometown, momma, daddy, dirt road, summer night; "Yeah" appears in 62% of country songs. **Production:** acoustic + electric guitars, pedal steel, fiddle, slight twang.

### 3.4 Hip-hop / Rap
**Structure:** 4-bar intro, 16-bar verses, 8-bar hooks; 3 verses standard; modern radio rap shrinks verses to 12 bars. **BPM:** 70–100; trap 70–80 with double-time hi-hats; boom-bap 80–100. **Themes:** come-up story, struggle, flexing, romance, social/political commentary, place-as-identity, rivalry. **Rhyme:** dense — multisyllabic, internal, mosaic; modern elite rap stacks 4–6 syll per rhyme unit. **Line length:** measured in BARS; 8–14 syll/bar. **Hook:** separate from verses, often sung not rapped, often a guest vocalist; 8 bars. **Vocabulary:** largest of any genre; slang-heavy, proper nouns, internal references, wordplay/double-entendre prized. **Flow:** triplet, double-time, on-beat/off-beat shifts, pause-and-burst. **Regional accent control:** sub-genre tags (`Memphis trap`, `Atlanta trap`, `Compton hip-hop`, `West Coast g-funk`) — direct accent tags ("Southern accent") are weak; put slang in lyric text. **Production:** 808s, sub-bass, hi-hats, sample loops; trap = atmospheric pads + 808s; boom-bap = dusty drums + jazz samples.

### 3.5 R&B / Soul
**Structure:** V-PC-C-V-PC-C-B-C with more melodic embellishment. **BPM:** 70–100; slow-jam R&B 60–80. **Themes:** love, intimacy, longing, devotion, heartbreak — more directly sensual than pop. **Rhyme:** looser; slant rhymes, internal rhymes, repeating end-words for hypnotic effect; perfect rhyme optional. **Line length:** variable — melisma stretches one syllable across many notes. **Hook:** melisma-decorated title phrase; as much melodic gesture as lyric. **Vocabulary:** emotive, sensual, direct address ("you," "baby"); modern R&B uses sparser atmospheric imagery. **Melisma:** signature technique. **Production:** Rhodes piano, live warm bass, brushed drums (neo-soul) or sparse trap-influenced drums (modern R&B).

### 3.6 Folk / Singer-songwriter
**Structure:** V-C-V-C-B-C or AABA; often no pre-chorus. **BPM:** 60–100; acoustic-driven. **Themes:** introspection, place, memory, social commentary, character portraits, love; confessional voice. **Rhyme:** ABCB ballad-meter classic; ABAB for more formal songs; free for modern indie-folk. **Line length:** longer (8–14 syll); ballad meter alternates 4-stress (8 syll) and 3-stress (6 syll). **Hook:** title can be subtler; sometimes title doesn't appear in chorus (refrain-based). **Vocabulary:** poetic, image-rich, regional, archaic-ok; place names, weather, seasons, body details. **Storytelling:** narrative + reflection; 1st-person confessional or 3rd-person ballad. **Production:** fingerpicked acoustic guitar, intimate vocal, minimal layering; subtle cello/strings/harmonica.

### 3.7 Indie
**Structure:** V-C-V-C-B-C most common, but loosest genre — through-composed and irregular accepted. **BPM:** 90–125. **Themes:** introspection, ambivalence, irony, mundane detail elevated, post-romantic relationships, anxiety, identity. **Rhyme:** often ABCB or free; perfect rhyme can feel "too pop." **Line length:** variable, often deliberately uneven. **Hook:** may be melodic rather than lyrical — guitar hook or synth motif rather than title shout. **Vocabulary:** literate, often Latinate, references to literature/film/place, deliberately unusual or specific imagery. **Production:** jangly guitars, lo-fi tape saturation, bedroom-pop warmth, dreamy reverbs.

### 3.8 EDM / Dance
**Structure:** A-B-D-B-D-A or A-B-D-E-D-A. **BPM:** 120–140 typical; DnB/jungle 160–180; future bass 140–160; house 120–130; techno 125–150; trap 130–170 half-time. **Themes:** love-at-the-club, escape, transcendence, "tonight," catharsis; lyrics as emotional shorthand rather than narrative. **Rhyme:** simple — AABB or repeated end-word; the drop is often wordless or a single hook phrase. **Line length:** short (4–8 syll) — vocals fit between rhythmic synth stabs. **Hook:** single repeated phrase before each drop ("chant hook"); drop itself often instrumental. **Topline writing:** vocals usually written OVER a pre-existing instrumental — lyric accommodates production. **Production:** synth lead, side-chained pad, four-on-the-floor kick, festival reverb.

### 3.9 Blues
**Structure:** 12-bar AAB cycled (sometimes 8-bar or 16-bar); each "verse" = one 12-bar cycle. **BPM:** 60–120; slow blues 60–80; jump blues 120–180. **Themes:** hardship, loss, romantic betrayal, work, travel, mortality, defiance. **Rhyme:** AAB — A states a problem; A repeats with slight variation; B resolves and rhymes back to A. **Line length:** 8–12 syll. **Hook:** B-line resolution; often the title. **Vocabulary:** direct, colloquial, Southern US idiom, blues archetypes ("woman," "train," "road," "morning," "trouble"). **Production:** electric guitar (Telecaster, Strat), harmonica, walking bass, brushed drums (slow) or shuffle drums (jump).

### 3.10 Ballad (cross-genre form)
A SLOW song with strong narrative/emotional focus, across pop/country/rock/R&B/folk. **BPM:** 60–85. **Structure:** V-C-V-C-B-C or AABA. **Line length:** longer (10–14 syll) for story-detail. **Dynamics:** starts intimate, builds to chorus, peaks at bridge or final chorus. **Rhyme:** perfect or family preferred — slow tempo lets each rhyme land. **Singability:** open vowels on long sustained notes (Davis's rule applies heavily). **Production:** typically acoustic-led; piano and strings common; minimal drum kit, often brushes only.

### 3.11 Lo-fi / Chill
**Structure:** loose verse-chorus or no clear structure. **BPM:** 60–85. **Themes:** nostalgia, studying, late-night thoughts, urban melancholy. **Rhyme:** minimal — often free verse over a beat; "the song" is the vibe, not the lyric. **Line length:** short, conversational. **Hook:** vocal sample loop more often than lyric hook. **Vocabulary:** introspective, present-continuous tense, sensory detail. **Production:** tape hiss, vinyl crackle, pitched-down vocals, Rhodes piano, tape-saturated drums, warm analog bass.

### 3.12 Trap (modern hip-hop sub-genre)
**Structure:** I-V-H-V-H-V-O; sometimes I-V-H-V-H-Bridge-H. **BPM:** 130–170 reading (half-time feel = 65–85 perceived). **Themes:** street life, flexing, dark moods, paranoia, romance through autotune. **Rhyme:** looser than boom-bap; melodic-rap delivery; multisyllabic less critical. **Hook:** autotuned, melodic, repetitive — chant-like hooks dominate. **Vocabulary:** heavy slang, brand names, regional markers. **Production:** 808 sub-bass, atmospheric pads, hi-hats with rolls (16th and 32nd notes), reverb-heavy vocals.

### 3.13 Genre-mixing notes

When the user requests a hybrid (e.g., country-trap, indie-folk, pop-rock):

- Pick the **dominant** genre and use its structure.
- Borrow **vocabulary** and **production** from the secondary genre.
- Watch BPM — hybrid genres often pick a tempo at the overlap.

**Example: country-trap.** Structure: hip-hop intro-verse-hook (dominant). BPM: 130 half-time (overlap). Vocabulary: country imagery (horses, fields, trucks) + trap delivery (autotuned melodic-rap). Production: country instruments (acoustic guitar) + trap drums (808s, hi-hats).

### 3.14 Quick reference

| Genre | BPM | Chorus rhyme | Hook position | Line length |
|---|---|---|---|---|
| Pop ballad | 60–85 | AABB perfect | bookended | 8–12 |
| Pop upbeat | 100–130 | AABB or repeated | end + every line | 4–8 |
| Country | 118–125 | AABB perfect | end | 8–12 |
| Rock | 120–135 | AABB or ABAB | shouted at end | 6–12 |
| Folk | 60–100 | ABCB ballad meter | refrain | 8–14 |
| Hip-hop | 70–100 | AABB simple | full 8-bar hook | 8–14 / bar |
| R&B | 70–100 | repeated end-word | melismatic | variable |
| Indie | 90–125 | ABCB or free | optional | variable |
| EDM | 120–140 | repeated phrase | pre-drop | 4–8 |
| Blues | 60–120 | AAB | B-line resolution | 8–12 |
| Trap | 130–170 ½-time | chant | melodic hook | 8–14 / bar |
| Lo-fi | 60–85 | minimal | vocal loop | conversational |

---

## 4. Style templates (ready-to-paste)

Each template uses the **5-part formula** (Genre/Subgenre → Mood & Energy → Vocal Direction → Instrumentation → Production & Tempo) targeted at **8–15 tags**. All avoid artist names per the no-artist-names rule — recognized Western artists (Taylor Swift, Coldplay, Drake, etc.) are silently filtered by Suno just like Thai names. Diction cue at end of every template (`crisp English diction` or regional variant) parallels `clear native Thai diction` in Thai templates.

**Char-budget:** v5 hard-limits Style at 200 chars (silent truncation). v5.5/v4.5 = 1,000 chars. Front-load genre + mood + vocal tags so they survive truncation.

### 4.1 Modern pop (radio pop)
**Use for:** mainstream love songs, breakup ballads, modern singer-songwriter pop, OST-style tracks. **Sliders:** Weirdness 25–35% · Style Influence 70–85%.

- *Female lead, ballad:* `modern pop ballad, bittersweet hopeful, fingerpicked acoustic guitar, soft synth pads, intimate female alto, polished radio mix, 86 BPM, crisp English diction`
- *Male lead, ballad:* `modern pop ballad, melancholic intimate, soft piano, warm strings, gentle male tenor with subtle vibrato, polished radio mix, 78 BPM, crisp English diction`
- *Upbeat pop:* `modern upbeat pop, joyful confident, bright synth lead, four-on-floor drums, clean female vocals with layered harmonies, glossy modern mix, 118 BPM, crisp English diction`
- *Dream pop:* `dream pop, shimmering reverb-drenched guitars, airy ethereal female soprano, lush synth pads, nostalgic dreamy atmosphere, wide stereo, 98 BPM, crisp English diction`
- *Synth-pop (80s revival):* `synth-pop, 80s-inspired, euphoric nostalgic, powerful female vocals with layered harmonies, analog synth pads, punchy drum machine, shimmering arpeggios, polished retro mix, 118 BPM, crisp English diction`

### 4.2 Rock / Pop-Rock
**Use for:** anthemic rock, perseverance songs, stadium-rock energy, alternative. **Sliders:** Weirdness 35–50% · Style Influence 65–80%.

- *Anthemic stadium rock:* `stadium rock, anthemic and powerful, distorted electric guitars, driving drums, soaring male vocals with rasp, pro mixing, 110 BPM, crisp English diction`
- *Pop-rock high-energy:* `pop-rock, energetic anthemic, crunchy electric guitars, big drums, gritty male lead, polished modern rock mix, 132 BPM, crisp English diction`
- *Emotional rock ballad:* `rock ballad, melancholic powerful, clean electric guitar with reverb, soft drums building to big chorus, emotive male vocals, cinematic mix, 76 BPM, crisp English diction`
- *90s grunge:* `90s grunge rock, distorted guitars, gritty male baritone, pounding live drums, dark moody energy, raw garage production, 110 BPM, crisp English diction`
- *Pop-punk:* `pop-punk, 2000s alternative rock, energetic emotional, palm-muted electric guitars, four-on-floor drums, gritty male lead, polished radio mix, 158 BPM, crisp English diction`

### 4.3 Country
**Use for:** storytelling country, Nashville radio, modern country pop, outlaw country. **Sliders:** Weirdness 25–35% · Style Influence 75–88%.

- *Modern country (Nashville polish):* `modern country, acoustic and electric guitars, pedal steel accents, heartfelt male baritone with slight drawl, Nashville polish, storytelling cadence, 96 BPM, crisp English diction with country drawl`
- *Country ballad:* `country ballad, melancholic narrative, fingerpicked acoustic guitar, gentle fiddle, intimate female alto with slight drawl, warm Nashville mix, 82 BPM, crisp English diction with country drawl`
- *Outlaw country (70s-style):* `outlaw country, dusty acoustic guitar, upright bass, gravelly male baritone, vintage 70s tape warmth, sparse raw arrangement, 88 BPM, crisp English diction with country drawl`
- *Country-pop crossover:* `country-pop, polished crossover, acoustic guitar, banjo accents, layered female vocals, modern radio mix, 102 BPM, crisp English diction with light drawl`

### 4.4 Hip-hop / Rap
**Use for:** boom-bap, trap, melodic rap, conscious rap. **Sliders:** Weirdness 40–55% · Style Influence 60–75%. ⚠ Regional accent control: use sub-genre tags (`Memphis trap`, `Atlanta trap`, `Compton hip-hop`, `West Coast g-funk`) — direct accent tags are weak; put slang in lyric text.

- *Boom-bap hip-hop (East Coast 90s):* `boom-bap hip-hop, dusty sample loop, vinyl crackle, hard-knock drums, conversational male rap delivery, gritty street energy, 88 BPM, crisp English enunciation`
- *Melodic trap (Atlanta):* `Atlanta melodic trap, atmospheric pads, 808 sub-bass, autotuned melodic male rap delivery, reverb-heavy, dark moody aesthetic, 140 BPM half-time feel, clear English enunciation`
- *Conscious rap (jazz-influenced):* `conscious hip-hop, jazz-sample loop, dusty drums, upright bass, thoughtful male rap delivery with smooth flow, warm vinyl production, 84 BPM, crisp English enunciation`
- *West Coast g-funk:* `West Coast g-funk, smooth synth lead, funky bass, laid-back drums, melodic male rap delivery, sunny analog mix, 92 BPM, crisp English enunciation`

### 4.5 R&B / Soul
**Use for:** late-night R&B, neo-soul, slow jams, modern alternative R&B. **Sliders:** Weirdness 25–40% · Style Influence 70–85%.

- *Neo-soul:* `neo-soul, Rhodes piano, live warm bass, brushed drums, soulful female alto with jazzy phrasing, earthy organic production, 88 BPM, crisp English diction`
- *Modern R&B:* `modern R&B, sparse trap-influenced drums, lush pad layers, silky male tenor with melismatic runs, polished radio production, 78 BPM, crisp English diction`
- *Slow jam R&B:* `slow-jam R&B, smooth electric piano, sub bass, brushed snare, sensual female vocals with subtle ad-libs, late-night radio mix, 68 BPM, crisp English diction`
- *Funk-soul revival:* `funk-soul revival, tight rhythm guitar, punchy horns, driving bass, energetic male vocals with melismatic runs, retro analog mix, 102 BPM, crisp English diction`

### 4.6 Folk / Singer-songwriter
**Use for:** intimate folk, story-songs, acoustic singer-songwriter, modern indie folk. **Sliders:** Weirdness 30–45% · Style Influence 65–80%.

- *Indie folk:* `indie folk, fingerpicked acoustic guitar, intimate warm male tenor, subtle cello, brushed percussion, storytelling cadence, 88 BPM, crisp English diction`
- *Singer-songwriter ballad:* `singer-songwriter ballad, gentle reflective, fingerpicked acoustic guitar, soft piano, intimate female vocals, warm minimal mix, 76 BPM, crisp English diction`
- *Americana folk:* `Americana folk, dusty acoustic guitar, mandolin, harmonica, weathered male baritone, organic warm production, 92 BPM, crisp English diction with light drawl`
- *Modern folk-pop:* `folk-pop, fingerpicked acoustic guitar, layered group harmonies, kick-drum on quarters, warm female lead, glossy organic mix, 102 BPM, crisp English diction`

### 4.7 EDM / Dance
**Use for:** festival EDM, progressive house, synthwave, future bass, club tracks. **Sliders:** Weirdness 30–45% · Style Influence 70–85%.

- *Progressive house:* `progressive house, euphoric synth lead, side-chained pad, four-on-the-floor kick, soaring female vocal hook, festival energy, 124 BPM, crisp English diction`
- *Synthwave:* `synthwave, pulsing analog arpeggios, gated reverb drums, DX7 electric piano, wide stereo, nostalgic 80s futurism, 112 BPM, crisp English diction`
- *Future bass:* `future bass, bright vocal chops, wobbly synth lead, snappy drums, melodic female vocals with chopped tag, glossy modern mix, 148 BPM, crisp English diction`
- *Tropical house:* `tropical house, plucked tropical synth lead, organic percussion, light kick, breezy male vocals, summery polished mix, 110 BPM, crisp English diction`

### 4.8 Lo-fi / Chill
**Use for:** lo-fi hip-hop, chillhop, study beats, late-night vibe tracks. **Sliders:** Weirdness 35–50% · Style Influence 65–80%.

- *Lo-fi hip-hop:* `lo-fi hip-hop, chill nostalgic, pitched-down vocal sample, Rhodes piano, tape-saturated drums, vinyl crackle, warm analog bass, lo-fi tape hiss, 75 BPM, crisp English diction`
- *Chillwave:* `chillwave, dreamy hazy, lush synth pads, tape-saturated bass, soft brushed drums, breathy female vocals, vintage analog warmth, 88 BPM, crisp English diction`

### 4.9 Blues
**Use for:** slow blues, jump blues, blues-rock, Delta blues. **Sliders:** Weirdness 30–45% · Style Influence 70–85%.

- *Slow blues:* `slow blues, mournful expressive, electric guitar with vibrato, walking bass, brushed drums, soulful male vocals with grit, warm analog mix, 72 BPM, crisp English diction`
- *Blues-rock:* `blues-rock, driving energetic, distorted blues guitar, harmonica, pounding drums, gritty male vocals with rasp, raw live production, 116 BPM, crisp English diction`
- *Delta blues (acoustic):* `Delta blues, sparse haunting, acoustic slide guitar, foot-stomp percussion, weathered male baritone, raw room recording, 84 BPM, crisp English diction`

### 4.10 Cross-genre / Hybrid

- *Country-trap (Lil Nas X school — never named):* `country-trap, autotuned melodic rap, banjo loop, 808 sub-bass, trap hi-hats, male vocals with light drawl, modern hybrid production, 140 BPM half-time, crisp English diction`
- *Indie pop-rock:* `indie pop-rock, jangle electric guitars, driving bass, warm drums, layered male vocals with breathy delivery, lo-fi-tinged modern mix, 118 BPM, crisp English diction`
- *Folk-electronic (Bon Iver-school — never named):* `folk-electronic, fingerpicked acoustic guitar, vocoded falsetto, sparse electronic drums, lush pad, ambient warm production, 96 BPM, crisp English diction`
- *Cinematic pop (Lana-school — never named):* `cinematic pop, lush orchestration, soft piano, smoky female vocals with breathy delivery, melodramatic strings, vintage film-score mix, 80 BPM, crisp English diction`

### 4.11 Combining with code-switching cues

When the user wants English + Thai mix, append one of these:

- `English chorus with Thai verses, no in-line mixing` — for Thai verses + English chorus
- `bilingual English and Thai vocals, alternating sections` — for half-half
- `English verses with one Thai bridge` — for one Thai section only

This helps Suno avoid drifting between languages mid-line. See `bilingual-mixing.md` for full mixing rules.

### 4.12 Diction-cue variants (regional)

Default closer is `crisp English diction`. Variants for regional flavor:

| Region / register | Diction cue |
|---|---|
| Generic American | `crisp English diction` or `clear American English vocals` |
| British (RP) | `British accent leaning RP, clear diction` |
| Southern US | `crisp English diction with country drawl` or `Southern American drawl` |
| West Coast | `relaxed West Coast English delivery` |
| Caribbean / Reggae adjacent | `slight Caribbean lilt, clear diction` |
| Hip-hop conversational | `crisp English enunciation, conversational rap delivery` |

⚠ **Direct accent tags are weak in Suno.** Geographic sub-genre tags (`Atlanta trap`, `Nashville polish`, `Compton hip-hop`) pull accent better than `Southern accent` does directly. Combine BOTH for best results.

### 4.13 Reminders

- **No artist names.** Suno blocks recognized Western artists (Taylor Swift, Coldplay, Drake, Adele, Beyoncé, Ed Sheeran, Bruno Mars, etc.) just like Thai artists. Use sonic descriptors.
- **Char budget:** v5 truncates Style at 200 chars silently. v5.5 = 1,000 chars. Front-load.
- **Negative prompting:** `no autotune`, `no electric guitar`, `no drums` work. `don't add X` and `avoid X` do not.
- **Slider midpoints, not ranges:** when outputting to the user, state the chosen number, not a range. Pick the midpoint of the table unless the user said "experimental" or "very mainstream."
