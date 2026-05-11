# Songwriting Craft Research — Bilingual (English + Thai) Asset Library for Suno Skill Refactor

> **Research report only — no implementation.** This document is the basis for a future build/refactor of the `thai-suno-songwriter` skill into a bilingual (Thai + English) Suno prompt-engineering skill. Decisions on what to ship are deferred to the user. After this report, use `/sc:design` for architecture or `/sc:implement` for coding.
>
> **Compiled**: 2026-05-11 · **Depth**: Deep · **Scope**: Add full English mode (bilingual skill) · **Confidence**: High on frameworks/structure (well-established craft theory + multiple independent sources); Medium on community-reported Suno behavior (anecdotal but consistent across multiple authoritative blogs).

---

## Executive Summary

The existing `thai-suno-songwriter` skill is mature on the Thai side: it covers Thai phonetic tones, เพี้ยน prevention (10 risk patterns), Thai rhyme craft (สัมผัสนอก/ใน, AABB/ABAB/AABA schemes, vowel-family tables), and Suno field grammar in detail. **It has zero English-language coverage.** A bilingual refactor is roughly a doubling exercise — every Thai craft module needs an English parallel — plus a small set of cross-cutting bilingual mechanics (language anchoring, parenthetical echo translation).

The five highest-impact additions, ranked:

1. **English Prosody Audit** — parallel to the Thai เพี้ยน audit. Flags stress-mismatch, function-words-on-downbeats, closed-vowels-on-held-notes, homographs (read/live/lead/bass…), and English-specific singability problems.
2. **English Rhyme & Form Audit** — parallel to the Thai คำคล้องจอง audit. Uses Pattison's six rhyme types (perfect / family / additive / subtractive / assonance / consonance), genre-appropriate schemes, hook-placement check, "rhyme cheating" anti-patterns.
3. **Bilingual language-anchoring rule** — every section header in a bilingual lyric carries `(English)` or `(Thai)`; the existing Thai "no same-line code-switching" rule generalizes; parenthetical-echo translation is the canonical pattern.
4. **Genre Lyrical Conventions reference** — for *both* languages. Existing Thai work covers ลูกทุ่ง/หมอลำ/เพื่อชีวิต/T-pop/Thai rock/indie/R&B/hip-hop/folk/BL-OST; English additions: pop/rock/country/hip-hop/R&B/folk/indie/EDM/blues/ballad. Includes BPM ranges, line lengths, hook patterns, vocabulary banks.
5. **First-5-Seconds rule + Hook Placement Lint** — both languages share the principle that the opening must hit with a concrete image and the title must land in chorus line 1 or last line. Encode as a new pre-output check.

Beyond these, three structural additions: an **English-genre Style-Templates file**, an **English-Sub-Genre BPM/slider table** mirroring the existing Thai table, and an updated **Step 8 output template** that supports up to four parallel audit blocks (Thai-pronunciation, English-pronunciation, Thai-rhyme, English-rhyme) — only rendering blocks for languages present in the lyric.

The Suno model itself reached v5.5 in March 2026 (Voice Cloning, Custom Models, "My Taste" personalization). **No prompt-syntax changes** — same bracket/parenthesis grammar, same field limits — but English fidelity took a real generational step at v5 (Sept 2025). The skill should track this and surface character-budget warnings (v5 has a 200-char Style limit; v5.5 = 1,000 char; both silently truncate without warning).

---

## Table of Contents

1. [Baseline — What the existing skill already covers](#1-baseline)
2. [English songwriting craft (deep)](#2-english-craft)
   - 2.1 Song structure & form
   - 2.2 Lyric craft frameworks (Pattison, Davis, Sondheim, Stolpe, Blume, Webb)
   - 2.3 Rhyme craft — six rhyme types and schemes
   - 2.4 Meter, prosody, and melody-lyric fit
   - 2.5 Genre conventions (10 genres)
   - 2.6 Real-song reference notes (12+ examples)
   - 2.7 Public-domain illustrations
3. [Thai songwriting craft — additions beyond the existing skill](#3-thai-deepening)
   - 3.1 Genre lyrical conventions (ลูกทุ่ง/หมอลำ/เพื่อชีวิต/T-pop/rock/indie/R&B/hip-hop/folk/BL-OST)
   - 3.2 Annotated Thai lyric samples
   - 3.3 Modern Thai lyric trends (post-2020)
   - 3.4 ฉันทลักษณ์ echoes in modern song design
   - 3.5 Singability pitfalls beyond the 10 เพี้ยน risks
   - 3.6 Signature techniques of major Thai lyricists
4. [Suno bilingual prompt behavior (2025–2026)](#4-suno-bilingual)
   - 4.1 Model timeline (v4.5 → v5.5)
   - 4.2 English-language behavior in v5/v5.5
   - 4.3 Language-mixing strategies
   - 4.4 Tag vocabulary — English vs other languages
   - 4.5 Genre-specific English Styles strings
   - 4.6 Thai vs English behavior comparison table
5. [Synthesis — implications for the bilingual skill refactor](#5-synthesis)
   - 5.1 Architecture preservation
   - 5.2 New rules to encode
   - 5.3 New reference files to add
   - 5.4 Updated output template (Step 8)
   - 5.5 Slider/Styles updates
   - 5.6 Model-version awareness
   - 5.7 What NOT to change
6. [Sources](#6-sources)

---

## 1. Baseline — What the existing skill already covers <a id="1-baseline"></a>

Established before launching research, by reading every file in `references/` and `SKILL.md`. Findings:

**Thai phonetics & เพี้ยน (in `references/tonal-melodic-rules.md` + `references/pian-risk-checklist.md`):**
- All 5 Thai phonetic tones (สามัญ/เอก/โท/ตรี/จัตวา) with contour notation
- The mapping rule (melodic direction must match tonal direction)
- 10 risk patterns: long lines, Pali/Sanskrit compounds, initial clusters on stressed beats, mai-tho on long notes, real names, numbers, English acronyms, same-line code-switching, short vowels on long notes, end-of-phrase tone restrictions
- Fix techniques ranked 1–5 (substitute / reorder / rewrite / move position / accept)
- Suno-specific weaknesses (v4.5 worse than English; female voices slightly clearer; slow tempo better)

**Thai rhyme craft (in `references/khlong-jong-rhyme.md`):**
- Phonetic rule: same vowel + same final-consonant class (มาตราตัวสะกด)
- Tone irrelevant for rhyme (สามัญ/เอก/โท/ตรี/จัตวา freely rhyme)
- มาตราตัวสะกด table (8 classes)
- สัมผัสนอก (AABB / ABAB / AABA / interlocking กลอนแปด)
- สัมผัสใน (vowel echo + alliteration, at least one per chorus line)
- Common pop rhyme families (ใจ-family, เธอ-family, รัก-family, etc.)
- Anti-patterns (ขัดสัมผัส / สัมผัสซ้ำคำเดียวกัน / เพี้ยนสัมผัส / สัมผัสเลื่อน / forced absurd rhyme)
- Audit checklist (Section 7) with 11 questions
- Composition workflow (Section 8) — chorus rhyme word first, then verse, then pre-chorus

**Suno field reference (in `references/suno-fields-reference.md`):**
- Hard limits (Lyrics 5,000ch, Styles 1,000ch, Title 80ch)
- Bracket vs parenthesis grammar (load-bearing)
- All section/vocal/instrumentation/production/meta tags
- Styles field composition order
- "No artist names" rule
- Negative prompting
- Creative sliders (Weirdness / Style Influence / Audio Influence) with per-Thai-sub-genre tables
- v4.5/v4.5+/v4.5-all vs v5/v5.5 differences

**Thai style templates (in `references/style-templates.md`):** 9 sub-genres × 1–3 templates each. Mainstream T-pop / Thai rock / indie / city pop / phleng phuea chiwit / pop-punk / R&B / luk thung-mor lam / hybrids.

**Worked example (in `references/examples.md`):** Example 1 is a full Thai ballad demo with rhyme blueprint, full lyric, audits.

**The skill's invariants (in `CLAUDE.md` + `SKILL.md`):**
- Two-tier loading (SKILL.md eager, references lazy)
- "Warn, don't auto-fix" for both audits
- Two parallel audits kept separate (`### ⚠️ เพี้ยน Risk Flags` vs `### 🎼 คำคล้องจอง Audit`)
- No artist names ever
- Bracket vs parenthesis grammar fixed by Suno
- Thai script in lyric examples, never romanization
- Slider tables stay consistent across files
- Step 8 output template is the user-visible contract — section headers and ordering must not be reorganized casually

**Gaps for the bilingual refactor (the rest of this report):**
- No English-language coverage at all
- No English prosody / stress-matching theory
- No English rhyme types (perfect/family/additive/subtractive/assonance/consonance)
- No English genre conventions
- No English style templates
- No English example songs
- No bilingual section-anchoring guidance for mixed-language outputs
- No English-specific Suno tips (homographs, regional accent issues, post-v5 behavior)

---

## 2. English songwriting craft (deep) <a id="2-english-craft"></a>

### 2.1 Song structure & form

#### The dominant forms

**Verse-Chorus (V-C-V-C-B-C)** — default in pop, rock, country, R&B, and modern dance pop. Full template: `intro → verse → pre-chorus → chorus → verse → pre-chorus → chorus → bridge → chorus → outro`. Chorus repeats lyrically and musically every time; verses get new lyrics over the same melodic frame. ([Wikipedia – Song structure](https://en.wikipedia.org/wiki/Song_structure); [MasterClass – Common Song Structures](https://www.masterclass.com/articles/songwriting-101-learn-common-song-structures))

**AABA (32-bar form)** — older "American popular song form." Four 8-bar sections: two verses (A), a contrasting bridge (B), final verse (A). Cole Porter, Gershwin, Berlin era. Still used today in jazz standards, theatre songs, country ballads, some folk. Title typically lands at the first AND last line of every A section. Variations like Sondheim's 6-6-9-8 ("Send in the Clowns") exist. ([Songstuff – AABA](https://www.songstuff.com/songwriting/article/aaba-song-form/))

**12-bar blues / AAB lyric form** — three 4-bar phrases. Line 1 (A) states a situation, line 2 (A or A') repeats with slight variation, line 3 (B) answers/resolves with the rhyme. Harmonic underpinning: I–I–I–I / IV–IV–I–I / V–IV–I–I. Question-question-answer structure; the form itself is call-and-response. ([Songstuff – AAB](https://www.songstuff.com/songwriting/article/aab-song-form/); [Wikipedia – 12-bar blues](https://en.wikipedia.org/wiki/Twelve-bar_blues))

**Through-composed** — no repeating sections, each part musically distinct. Rare. "Bohemian Rhapsody" is canonical: piano ballad → guitar solo → operatic midsection → hard rock → ballad coda, unified only by lyric narrative. ([Slave to Music – Bohemian Rhapsody](https://slavetomusic.com/the-secret-architecture-of-queens-bohemian-rhapsody-meaning-structure-and-studio-secrets/))

**EDM / Drop-based** — different vocabulary: A = intro/outro, B = verse, D = drop/chorus, E = bridge. Typical layout `A B D B D A` or `A B D E D A`. The "drop" replaces the lyrical chorus as energy peak; the lyrical hook often lands in a post-chorus around the drop. ([EDM Tips – Song Structure](https://edmtips.com/edm-song-structure/); [Unison – EDM Structure](https://unison.audio/edm-song-structure/))

**Hip-hop / Rap structure** — typically `intro (4 bars) → verse 1 (16 bars) → hook (8 bars) → verse 2 (16 bars) → hook → verse 3 (16 bars) → outro`. Modern radio rap often shrinks verses to 12 bars. Hook = chorus in hip-hop. ([Rap Authority – 16 bars](https://rapauthority.com/16-bars-in-rap/))

#### Section functions

- **Intro** — establishes key, tempo, hook tease. 2–8 bars.
- **Verse** — story development. New lyrics each time. Conversational register, narrower melodic range than chorus. 8–16 bars.
- **Pre-chorus ("lift" / "climb" / "B-section")** — micro-build into chorus. Anticipation: held chord, rising melody, lyric pivot. 4–8 bars. Often uses different rhymes than the verse and chorus to act as a hinge. ([Producer Hive – Pre-chorus](https://producerhive.com/songwriting/what-is-a-pre-chorus/))
- **Chorus / Hook** — title and emotional thesis. Higher melodic register, biggest dynamics, densest rhyme. Same lyric every repetition. 8–16 bars.
- **Post-chorus** — short tag (often wordless "oh oh oh" or repeated title phrase) extending chorus payoff. Standard in modern EDM-pop and Weeknd-era pop.
- **Bridge ("middle 8")** — happens once between chorus 2 and the final chorus. Functions: contrast (new chords/key), perspective shift, emotional climax, or "rant bridge" of accumulated detail. Taylor Swift's bridges are the modern canonical case. ([Switched on Pop – Taylor Swift Songwriting School](https://switchedonpop.substack.com/p/the-taylor-swift-songwriting-school))
- **Outro** — wind-down. Often a repeated chorus tag or vamp.

#### Tempo + section-length conventions per genre

| Genre | Typical BPM | Typical structure | Verse bars | Chorus bars |
|---|---|---|---|---|
| Pop ballad | 60–85 | V-PC-C-V-PC-C-B-C | 16 | 8–16 |
| Pop upbeat | 100–130 (sweet spot 118–128) | V-PC-C-V-PC-C-B-C | 8–16 | 8 |
| Country | 118–125 | V-C-V-C-B-C (58% of #1s) | 8–16 | 8 |
| Rock | 120–135 (punk 135+) | V-C-V-C-B-C | 8–16 | 8 |
| Folk / singer-songwriter | 60–100 | V-C-V-C-B-C or AABA | 8–16 | 8 |
| Hip-hop / rap | 70–100 | I-V-H-V-H-V-O | 16 (12 modern) | 8 |
| R&B | 70–100 | V-PC-C-V-PC-C-B-C | 16 | 8–16 |
| EDM / dance | 120–140 (DnB 153+) | A-B-D-B-D-A | 8–16 | 8 (drop) |
| Indie | 90–125 | flexible | 8–16 | 8 |
| Blues | 60–120 | 12-bar AAB cycled | n/a | n/a |

Sources: [Orphiq – BPM by Genre](https://orphiq.com/resources/bpm-tempo-guide); [Chosic – BPM by Genre](https://www.chosic.com/bpm-by-genre-list/); [NSAI – Structure of Number Ones](https://www.nashvillesongwriters.com/structure-number-ones).

#### Two-verse convention and bridge necessity

In modern V-C-V-C-B-C songs, the bridge is optional but expected once a song crosses ~2:30. NSAI's analysis of country #1s found 58% use V-C-V-C-B-C — the bridge is essentially industry-standard for full-length country radio singles. In hip-hop, the "bridge" is more often replaced by a third 16-bar verse or by a beat switch. A bridge is required when: the song needs a perspective shift, the chorus has repeated 2× and a third repeat would feel stale, or the artist needs an emotional climax point. ([NSAI – Structure of Number Ones](https://www.nashvillesongwriters.com/structure-number-ones); [Rap Authority – Structure](https://rapauthority.com/rap-song-structure/))

### 2.2 Lyric craft frameworks (named, citable)

#### Pat Pattison (Berklee)

Pattison is the most-cited modern songwriting academic. Books: *Writing Better Lyrics*, *Songwriting Without Boundaries*, *Essential Guide to Rhyming*. Four key concepts:

**(a) Object writing** — daily 10-minute exercise using all 7 senses (sight, sound, taste, touch, smell, body, organic motion) to gather sensory imagery before drafting. Trains the writer to think in concrete sense-bound images rather than abstract emotion words. Berklee Lyric Writing 1 is built around this. ([Berklee Online – Take Note](https://online.berklee.edu/takenote/prosody-in-music-and-songwriting/))

**(b) Prosody = unity** — Pattison defines prosody not narrowly as "stress matching" but as "everything in the song supporting the central idea." Every craft choice — meter, rhyme, melody, dynamics — is evaluated by whether it makes the song MORE or LESS unified.

**(c) Stable vs unstable** — Pattison's master grid. Every element of a song can be assessed as stable (resolved, expected, restful) or unstable (motion, tension, unresolved). Rule: **match instability to instability in content.** A song about heartbreak should not sit on stable structures.

Stable vs unstable applies to:
- **Line length** — equal/even-numbered lines = stable; uneven = unstable. Paul Simon shortens the 4th line of the "Still Crazy" bridge to create instability. ([songwriting.net – Size Matters](https://www.songwriting.net/blog/size-matters-a-study-in-prosody))
- **Number of lines per section** — even (2, 4) = stable; odd (3, 5) = unstable.
- **Rhyme scheme** — perfect rhyme = stable; assonance/consonance = unstable.
- **Rhyme position** — couplet AABB = stable; rhymes farther apart (ABAB, ABCB) = less stable.
- **Phrase placement** — melody starting on the downbeat = stable; back-phrased = unstable.

**(d) The six rhyme types** — covered in §2.3.

#### Sheila Davis (NYU; *The Craft of Lyric Writing*, 1985; *Successful Lyric Writing*, 1988)

Davis's framework is older but still load-bearing for industry songwriting:

- **The title is everything.** The hook (title phrase) must be the song's argument in compressed form. Ira Gershwin's rule, which Davis quotes: "Prove a title is worth using by making sure it's what your lyric is all about." ([Blinkist – Davis summary](https://www.blinkist.com/en/books/the-craft-of-lyric-writing-en))
- **Singability** — every syllable should be physically singable. Avoid clusters of consonants on long notes; favor open vowels on sustained notes; avoid sibilants on the highest note of the chorus.
- **Front-load OR end-load the hook.** Title goes in line 1 of the chorus, line last of the chorus, or BOTH (bookending). ([Berklee Online – Killer Hooks](https://online.berklee.edu/takenote/how-to-write-songs-with-killer-hooks/); [LinkedIn Learning – Hook at end of chorus](https://www.linkedin.com/learning/one-minute-songwriting-tips/try-the-hook-at-the-end-of-the-chorus))

#### Stephen Sondheim — three principles (*Finishing the Hat*, 2010)

Sondheim's distilled rules:

1. **Content dictates form** — subject decides structure, not the other way around.
2. **Less is more** — every word earns its place. Cut adjectives, cut throat-clearing.
3. **God is in the details** — concrete, specific images beat abstract ones every time.

All three serve a fourth meta-principle: **Clarity.** The lyric is heard once, in real time, without re-reading — unlike poetry. ([Advice to Writers – Sondheim Principles](https://advicetowriters.com/advice/2015/4/21/stephen-sondheims-three-principles-of-lyric-writing.html))

#### Andrea Stolpe (*Popular Lyric Writing*, 2007, Berklee Press)

Standard text at Berklee, Belmont, USC Thornton. 10-step commercial-songwriting approach centering point of view, sectional balance, sensory imagery, form selection, hook placement. Stolpe emphasizes that singer-songwriter style is "anchored by the writing itself" — the lyric is the load-bearing element. ([Andrea Stolpe – Singer-Songwriter Style](https://www.andreastolpe.com/articles/what-defines-the-singer-songwriter-style-and-how-to-find-yourself-within-it))

#### Jason Blume (*Six Steps to Songwriting Success*, 2004/2017)

BMI Nashville workshop instructor. Six steps: (1) develop your craft, (2) write lyrics that touch the heart, (3) write strong melodies, (4) tap into the marketplace, (5) demo, (6) market. Most useful for an LLM: explicit lyric checklists for evaluating draft work.

#### Jimmy Webb (*Tunesmith*, 1998)

Only person to win Grammys for music, lyrics, AND orchestration. *Tunesmith* covers chord theory, rhyme schemes, pitching, and a heavy emphasis on **the marriage of music and lyric** — precursor to what Pattison would systematize as prosody.

#### "Show, don't tell" applied to lyric

Three concrete moves:

1. **Concrete nouns over abstractions.** "Empty chairs at the table" not "I'm lonely."
2. **Sensory detail.** Sight, sound, smell, touch, taste, body-temperature, motion (Pattison's 7 senses).
3. **Action verbs.** "She slammed the screen door" not "She was angry."

Anti-pattern: "feeling words" (love, sad, lonely, broken) on stressed positions. Use them sparingly; let imagery do the emotional work. ([BMI – Show Don't Tell](https://www.bmi.com/news/entry/showdont_tell_3_steps_to_writing_better_lyrics))

#### Hook construction rules (synthesized)

- Hook is the title phrase, typically 2–7 syllables.
- Lands in 4 possible positions: chorus line 1, chorus last line, both (bookended), or repeated every line of chorus.
- Memorability hierarchy: short title (1–4 syllables) > medium (5–7) > long.
- Repeat the hook ≥3× per chorus, ≥6× per song.
- Hook gets the highest melodic note or the longest note of the chorus.
- Vowel choice matters: open vowels (ah, oh, ee) project better than closed vowels (uh, ih).

### 2.3 Rhyme craft (English-specific)

#### The six rhyme types (Pattison's framework)

Ranked from most stable/closed to least stable/open:

1. **Perfect rhyme** — identical stressed vowel + identical consonants after. *cat/hat, light/night, taken/shaken.* Maximum closure. Use when the line states resolution.
2. **Family rhyme** — same vowel + consonants from the same phonetic family (voiced/unvoiced pairs: p/b, t/d, k/g, f/v, s/z, sh/zh, ch/j, m/n/ng). *bat/cab, fit/lid, knock/jog.* Almost as stable as perfect but expands vocabulary 5–10×.
3. **Additive rhyme** — matching vowel; the rhyming line ADDS a consonant. *stow/hope, year/feared.* Mildly unstable.
4. **Subtractive rhyme** — matching vowel; the rhyming line DROPS a consonant. *bake/stay, shout/now.* Mildly unstable.
5. **Assonance** — matching stressed vowel, different ending consonants. *rope/known, straight/fame, still/grip.* Clearly unstable.
6. **Consonance** — different vowels, matching ending consonants. *bat/spit, run/gone.* Most unstable. Common in hip-hop and indie.

Pattison's rule: **stable thought → perfect/family rhyme; unstable thought → additive/subtractive/assonance/consonance.** A chorus that resolves a verse usually wants perfect rhyme on its last line.

Plus two non-rhyme techniques:
- **Identity rhyme** — same word repeated. Generally a craft failure unless deliberate for hypnotic effect.
- **Eye rhyme** — rhymes on the page but not in sound (*love/move, cough/though*). Useless in song.

Sources: [Pattison – Essential Guide to Rhyming](https://www.amazon.com/Pat-Pattisons-Songwriting-Step-Step/dp/0876391501); [Andrea Stolpe – Rhyme Types](https://www.andreastolpe.com/articles/rhyme-types).

#### Rhyme schemes by genre

| Scheme | Pattern | Stability | Typical use |
|---|---|---|---|
| AABB | couplet | very stable | folk, country verse, kids' songs, hymn |
| ABAB | alternating | moderate | pop verse, ballad, sonnet-influenced |
| ABCB | only lines 2 and 4 rhyme | unstable / natural | folk ballad, country, story-songs |
| AABA | rhyme returns | stable with detour | 32-bar standards, ballads |
| ABABCDCD | extended alternating | extended motion | longer pop verses, hip-hop |
| AAAA | monorhyme | hypnotic / heavy | rap, comedic, list songs |
| AABBA | limerick | comic | rare in pop |
| Free verse | no scheme | maximally unstable | post-2010 indie, some hip-hop |

**Genre defaults:**
- Country: ABCB or AABB in verses; AABB or ABAB in chorus
- Pop: ABAB or ABCB in verses; AABB or repeating end-word in chorus
- Folk: ABCB or ABAB; ballad meter (alternating 4-stress / 3-stress lines)
- Hip-hop: AAAA, AABB, or complex multisyllabic chains
- Indie: often ABCB or no scheme
- R&B: looser — slant rhymes, repeating end-words, internal rhymes; perfect rhyme optional

#### Internal rhyme, multisyllabic rhyme, mosaic rhyme

- **Internal rhyme** — rhymes within a single line. Adds density and forward motion. Standard in hip-hop, increasingly used in pop bridges.
- **Multisyllabic rhyme ("multis")** — two-or-more syllables rhyming as a unit. *spaghetti / heavy already*. Hallmark of advanced rap. Eminem's "Lose Yourself" opens with a dense multisyllabic chain on the "-eddy/-evy" vowel. ([Wikipedia – Multisyllabic rhymes](https://en.wikipedia.org/wiki/Multisyllabic_rhymes))
- **Mosaic rhyme** — rhyme made of multiple words. *head / instead*, *insane / pen game.* Closely related to multisyllabic.

#### The "rhyme cheating" problem

Forced rhyme is the single most common amateur lyric failure. Diagnostics:

1. **Inverted syntax** — "down the road I walked alone" instead of "I walked alone down the road" just to put "alone" at line-end.
2. **Filler lines** — the next-to-last line says nothing because the writer needed an "-ight" set-up for "night."
3. **Cliché pairs** — fire/desire, heart/apart, eyes/lies, love/above. Fix: switch to family or assonance.
4. **Meaning twisted to fit the rhyme** — lyric drifts off-topic chasing sound.

Remedy: **loosen the scheme.** Move from AABB to ABAB to ABCB. Switch from perfect rhyme to family/assonance. ABCB is famously the "natural speech" scheme — only half the lines rhyme. ([BMI – 5 Rhyming Pitfalls](https://www.bmi.com/news/entry/5-song-rhyming-pitfalls-and-how-to-avoid-them))

### 2.4 Meter, prosody, and melody-lyric fit

#### English is stress-timed (load-bearing difference vs Thai)

This is the deepest English-vs-Thai craft difference. **Thai is syllable-timed** (each syllable gets roughly equal duration; tones carry meaning). **English is stress-timed** (stressed syllables fall at roughly equal time intervals; unstressed syllables compress between them). Therefore:

- An English line's "feel" comes from where the STRESSES land, not how many syllables it has.
- A 6-stress line and an 8-stress line are perceived as different lengths; a 10-syllable and 13-syllable line with the same 4 stresses feel about the same length.
- The unit of English rhythm is the **foot** (one stress + its surrounding unstressed syllables).

#### Metrical feet that matter for songwriting

| Foot | Pattern | "da-DUM" | Typical use |
|---|---|---|---|
| Iamb | u / | da-DUM | most common in English pop, ballad, conversation |
| Trochee | / u | DUM-da | nursery rhymes, marches, anthemic rock choruses |
| Anapest | u u / | da-da-DUM | folk ballads, country, limericks |
| Dactyl | / u u | DUM-da-da | waltz, Irish trad, some country |
| Spondee | / / | DUM-DUM | emphatic phrases, hooks |

Iambic is the default for natural English speech. Trochaic gives a "front-loaded" feel — chants, marches, kids' songs. Anapestic gives a "galloping" feel — "'Twas the night before Christmas" is anapestic tetrameter. ([MasterClass – Iambic Meter](https://www.masterclass.com/articles/understanding-iambic-meter))

#### Stress-to-downbeat matching (the prosody rule)

**Core rule:** stressed syllables land on strong beats (1 and 3 in 4/4); unstressed syllables land on weak beats (2 and 4, or off-beats). Violating this creates "wonky prosody" — the syllable the music emphasizes is one the speaker would naturally swallow. ([Berklee Take Note – Prosody](https://online.berklee.edu/takenote/prosody-in-music-and-songwriting/); [The Song Foundry – Prosody 101](https://thesongfoundry.com/prosody-songwriting-101/))

Test: say the lyric in conversational speech. Mark naturally stressed syllables. Then check whether the melody puts weight (longer note, higher pitch, downbeat) on those same syllables.

Common violations:
- "I LOVE you" sung as "i LOVE you" on beats 2-3-4 → fine.
- "I love YOU" with YOU on the downbeat when meaning is the verb → wrong unless contrast ("not him, YOU") is intended.
- Multi-syllable words: stress is fixed by dictionary. "guiTAR" not "GUItar"; "to-MOR-row" not "TO-mor-row".

#### Back-phrasing

Singing the melody slightly LATER than the written rhythm. Creates relaxed, conversational feel. Used heavily in jazz, R&B, country soul, Adele-style pop. Phrases that start after the downbeat are "back-heavy" — they feel unstable, like the melody is hanging off the beat. ([David Darling – Back Phrasing](https://www.daviddarling.info/encyclopedia_of_music/B/back_phrasing.html))

#### Word painting (text painting)

Melodic shape mirrors lyric meaning. Melody DESCENDS on "down" or "valley," RISES on "up" or "mountain," HALTS on "stop." Handel's *Messiah*: "valley" ends low, "mountain" peaks, "exalted" rises. Modern examples: "Friends in Low Places" (Garth Brooks) sings "low" on a low note; "Despacito" slows tempo when singing "despacito" (= "slowly"). Goes back to Gregorian chant. ([Wikipedia – Word painting](https://en.wikipedia.org/wiki/Word_painting))

For an LLM generator, this is a "bonus polish" rule: when a lyric contains a directional word (up/down, fall/rise, far/close, hot/cold, fast/slow), check whether the melodic instruction can mirror it.

### 2.5 Genre conventions

#### Pop (upbeat & ballad)
- **Structure**: V-PC-C-V-PC-C-B-C. Pre-chorus near-mandatory in modern pop.
- **BPM**: 100–130 upbeat; 60–85 ballad.
- **Themes**: love (new, ongoing, lost), self-empowerment, party/night-out, longing.
- **Rhyme**: ABAB or ABCB verses; AABB or repeated end-word chorus. Mix of perfect + family.
- **Line length**: short, 4–8 syllables typical.
- **Hook**: title bookended (line 1 AND last of chorus), or repeated as last 2 syllables.
- **Vocabulary register**: conversational, present tense, lots of "you/I/we," short Anglo-Saxon words.
- **Tropes**: "tonight," "forever," "lights," "dance," call-and-response with backing vocals.

#### Rock
- **Structure**: V-C-V-C-B-C or V-C-V-C with extended solos. Classic rock often follows AABA-derived forms.
- **BPM**: 120–135; pop-punk 135+; ballad-rock 70–90.
- **Themes**: rebellion, freedom, road/travel, defiance, heartbreak as anger, social commentary.
- **Rhyme**: AABB or ABAB. Less internal rhyme than pop; more memorable couplets.
- **Line length**: 6–12 syllables, often unequal — verses tell a story, chorus delivers a slogan.
- **Hook**: chorus title-shout. Often single-word hooks.
- **Vocabulary**: more polysyllabic Latinate words allowed than pop.

#### Country
- **Structure**: V-C-V-C-B-C (58% of #1s per NSAI); occasionally AABA for ballads.
- **BPM**: 118–125 — remarkably tight band across subgenres.
- **Themes**: nostalgia, small-town life, blue-collar pride, cheating/heartbreak, faith, drinking, trucks, family. "Yeah" appears in 62% of country songs; "girl" is the second-most-common word. ([Westword – Country Tropes](https://www.westword.com/music/the-ten-biggest-tropes-in-country-music-5694846/))
- **Rhyme**: AABB or ABCB; perfect rhyme strongly preferred. Country audiences notice forced rhyme.
- **Line length**: 8–12 syllables; story-detail requires longer lines than pop.
- **Hook**: title at end of chorus is the strong default; story-driven, with title functioning as punchline or thematic resolution.
- **Vocabulary**: plain spoken, present-tense, Anglo-Saxon, regional ("y'all," "ain't"), proper nouns (town names, brand names).
- **Storytelling**: linear narrative with beginning-middle-end is the Nashville norm.

#### Hip-hop / Rap
- **Structure**: 4-bar intro, 16-bar verses, 8-bar hooks; 3 verses standard. Modern radio rap shrinks verses to 12.
- **BPM**: 70–100; trap subgenre 70–80 with double-time hi-hats.
- **Themes**: come-up story, struggle, flexing, romance, social/political commentary, place-as-identity, rivalry.
- **Rhyme**: dense — multisyllabic, internal, mosaic. Modern elite rap stacks 4–6 syllables in a rhyme unit. Rhyme schemes are often complex chains rather than fixed end-rhyme.
- **Line length**: measured in BARS, not syllables. One bar = one 4-beat measure; a rapper fits 8–14 syllables per bar depending on flow.
- **Hook**: separate from verses, often sung rather than rapped, often featuring a guest vocalist. 8 bars.
- **Vocabulary**: largest of any genre. Slang-heavy, proper nouns (brands, places, people), internal references, wordplay/double-entendre prized.
- **Flow patterns**: triplet flow, double-time, on-beat/off-beat shifts, pause-and-burst.

#### R&B / Soul
- **Structure**: V-PC-C-V-PC-C-B-C, but with much more melodic embellishment.
- **BPM**: 70–100; slow-jam R&B 60–80.
- **Themes**: love, intimacy, longing, devotion, heartbreak. More directly sensual than pop.
- **Rhyme**: looser than pop — slant rhymes, internal rhymes, repeating end-words for hypnotic effect. Perfect rhyme is optional.
- **Line length**: variable — melisma allows a single lyric syllable to stretch across many notes.
- **Hook**: often a melisma-decorated title phrase; "hook" is as much a melodic gesture as a lyric.
- **Vocabulary**: emotive, sensual, direct address ("you," "baby"). Modern R&B often uses sparser, more atmospheric imagery.

#### Folk / Singer-songwriter
- **Structure**: V-C-V-C-B-C or AABA. Often no pre-chorus.
- **BPM**: 60–100. Acoustic-driven.
- **Themes**: introspection, place, memory, social commentary, character portraits, love. Confessional voice.
- **Rhyme**: ABCB ballad-meter is classic; ABAB for more formal songs; free for modern indie-folk.
- **Line length**: longer than pop — folk leans on narrative density. 8–14 syllables; ballad meter alternates 4-stress (8 syll) and 3-stress (6 syll) lines.
- **Hook**: title can be subtler; sometimes title doesn't appear in chorus at all (e.g., "Hallelujah" repeats "hallelujah" as the refrain).
- **Vocabulary**: poetic, image-rich, regional, archaic-ok. Place names, weather, seasons, body details.

#### Indie
- **Structure**: V-C-V-C-B-C most common, but loosest genre — through-composed and irregular forms accepted.
- **BPM**: 90–125.
- **Themes**: introspection, ambivalence, irony, mundane detail elevated to significance, post-romantic relationships.
- **Rhyme**: often ABCB or free; perfect rhyme can feel "too pop" for indie aesthetics.
- **Line length**: variable, often deliberately uneven.
- **Hook**: may be melodic rather than lyrical — a guitar hook or synth motif.
- **Vocabulary**: literate, often Latinate, references to literature/film/place, deliberate unusual or specific imagery.

#### EDM / Dance
- **Structure**: A-B-D-B-D-A or A-B-D-E-D-A.
- **BPM**: 120–140 typical; DnB/jungle 160–180; future bass 140–160.
- **Themes**: love-at-the-club, escape, transcendence, "tonight," catharsis. Lyrics often function as emotional shorthand rather than narrative.
- **Rhyme**: simple — AABB or repeated end-word. The drop is often wordless or a single hook phrase.
- **Line length**: short (4–8 syllables) — vocals are written to fit between rhythmic synth stabs.
- **Hook**: a single repeated phrase before each drop ("chant hook"); the drop itself is often instrumental.
- **Topline writing**: vocals are usually written OVER a pre-existing instrumental.

#### Blues
- **Structure**: 12-bar AAB cycled (sometimes 8-bar or 16-bar). Each "verse" = one 12-bar cycle.
- **BPM**: 60–120; slow blues 60–80; jump blues 120–180.
- **Themes**: hardship, loss, romantic betrayal, work, travel, mortality, defiance.
- **Rhyme**: AAB — A-line states a problem; A-line repeats with slight variation; B-line resolves and rhymes back to A.
- **Line length**: 8–12 syllables; AAB structure provides built-in repetition.
- **Hook**: the B-line resolution; often the title.
- **Vocabulary**: direct, colloquial, regional Southern US idiom, blues archetypes ("woman," "train," "road," "morning," "trouble").

#### Ballad (cross-genre form)
Technically a SLOW song with strong narrative or emotional focus, found across pop, country, rock, R&B, folk. Defining features:
- **BPM**: 60–85.
- **Structure**: V-C-V-C-B-C or AABA.
- **Line length**: longer (10–14 syllables) to fit story-detail.
- **Dynamics**: starts intimate, builds to chorus, peaks at bridge or final chorus.
- **Rhyme**: perfect or family preferred — slow tempo lets the ear hear each rhyme land.
- **Singability**: open vowels on long sustained notes (Davis's rule applies heavily).

### 2.6 Real-song reference notes

Notes-only format. **No lyric block exceeds 2 lines.** Where 2 lines appear, they illustrate the technique being discussed.

**"Someone Like You" — Adele — 2011** — *Hook bookending, asymmetric pre-chorus.* Key A major. Sections: Intro–Verse–Pre-chorus–Chorus. Pre-chorus is 9 bars instead of 8, creating tension before chorus payoff (Dan Wilson confirmed intentional — "holding your breath just a little too long"). Chorus uses multi-syllabic rhymes and ends with the title phrase as a final 2-syllable echo. Verses detail-rich and inward; choruses euphoric and outward.

**"All of Me" — John Legend — 2013** — *Direct address (2nd person), simple AABB, perfect-rhyme chorus.* "You" named in nearly every line. Verses use list structure (your X, your Y, your Z). Chorus uses repeated end-word "me/you" identity rhyme as a hypnotic device. BPM ~63.

**"Shape of You" — Ed Sheeran — 2017** — *Pre-chorus build, repeated-syllable chorus.* V-PC-C structure with marimba-led groove. Chorus built around "I'm in love with the SHAPE of you" — title positioned end of phrase. Verses use ABAB. BPM 96.

**"Blinding Lights" — The Weeknd — 2020** — *Post-chorus hook, 80s synth prosody.* BPM 171 (or 86 half-time). Structure: intro-V1-PC-C-Post-V2-PC-C-Post-Bridge-C-Outro. The "blinding lights" post-chorus is a wordless-style sung tag that becomes the song's de facto hook. Lyrical chorus short and chantable.

**"Wagon Wheel" — Old Crow Medicine Show — 2004** — *Place-name imagery, AABB country verse, title at end of chorus.* Key A major; I–V–vi–IV chord cycle. Anapestic rhythm matches the rolling motion of the lyric (word painting at form level). Verses are travel-narrative; chorus is plea. Ketch Secor wrote verses around Bob Dylan's existing chorus 25 years later.

**"Before He Cheats" — Carrie Underwood — 2005** — *Revenge-narrative, specific concrete imagery, ABCB verse.* Verses load up specific objects (Pattison-style concrete nouns). Chorus title bookended. BPM ~84. Classic Nashville V-C-V-C-B-C.

**"Bohemian Rhapsody" — Queen — 1975** — *Through-composed, multi-section.* No verse-chorus. Five distinct sections (intro ballad, guitar-led ballad, operatic interlude, hard rock, outro ballad) tied only by lyric narrative. Rhyme density and scheme change per section.

**"Don't Stop Believin'" — Journey — 1981** — *Delayed chorus.* Title doesn't appear until ~3:00; structure V-V-V-Bridge-Chorus rather than V-C-V-C. Builds anticipation through repeated verse-like sections before delivering the title hook. Unusual but effective inversion.

**"Hallelujah" — Leonard Cohen — 1984** — *AACBBC rhyme scheme, religious-erotic juxtaposition.* All verses follow AACBBC. C-lines act as a refrain anchor — they rhyme across verses while each verse's A/B pairs change. Cohen wrote 80–180 draft verses. AABA-derived form with "hallelujah" refrain.

**"The Sound of Silence" — Simon & Garfunkel — 1964** — *AABB folk-ballad, imagery-led verses, refrain title.* Five verses, each ending with "the sound of silence" as recurring refrain. Lines 6–8 syllables with alternating stress patterns. Heavy concrete-noun imagery. No bridge — through-verse structure.

**"Lose Yourself" — Eminem — 2002** — *Dense multisyllabic chains.* Opening verse stacks 4-syllable rhyme units on the "-eddy/-evy" sound (multi-word internal rhymes). Verse 16 bars, hook 8 bars. Demonstrates assonance-based multisyllabic chains.

**"Alright" — Kendrick Lamar — 2015** — *Hook-led structure, call-and-response, mantra hook.* 8-bar hook repeats title 6+ times; verses 16 bars with complex internal rhyme and political content. Hook is sung-rapped, halfway between rap and chant.

**"No Scrubs" — TLC — 1999** — *List-structure verse, repeated end-word chorus, conversational diction.* Verses enumerate the "scrub" archetype; chorus uses "no scrub" as a hook phrase repeated 4×. Direct audience address ("ladies").

**"Skinny Love" — Bon Iver — 2007** — *Minimal sections, repeated grammatical structure as hook, falsetto register.* Two verses with repeated "I told you to be X" line construction in the chorus serving as hook. Loose rhyme scheme — ABCB or near-free. Whispered-falsetto vocal performance creates intimacy.

**"Don't You Worry Child" — Swedish House Mafia — 2012** — *A-B-D-B-D-A EDM structure, single repeated title phrase as drop hook.* Verses build chord progression; drop is the title phrase chanted with synth lead. Lyric content minimal — emotional shorthand rather than narrative.

### 2.7 Public-domain illustrations (folk / traditional)

Used freely for longer-quote teaching needs.

**"Scarborough Fair" (English traditional, 16th c.)** — Dorian mode. End-rhymes across verses follow patterns like *fair/there*, *shirt/work*, *land/strands*. Internal refrain "parsley, sage, rosemary and thyme" sits in line 2 of each verse; closing refrain "Then she'll be a true love of mine" closes each verse — a refrain-AABB hybrid. Short illustrative phrase (PD): *"Are you going to Scarborough Fair? / Parsley, sage, rosemary and thyme"* — ABCB scheme where lines 2 and 4 rhyme on the refrain.

**"The House of the Rising Sun" (American traditional)** — Folk ballad meter. Alternating 4-stress / 3-stress lines (common meter). ABCB or ABAB scheme depending on verse. Narrative warning-song with refrain-based structure.

**"The Water Is Wide" (traditional Scottish/English)** — Common meter (8-6-8-6 syllables, ABAB). Perfect rhyme + ballad meter example.

**Stephen Foster — "Beautiful Dreamer" (1864)** — AABA form, parlor-ballad style, anapestic-leaning rhythm. Public domain; ideal for AABA illustration without copyright concerns.

**"Amazing Grace" (John Newton, 1779)** — Common meter hymn (8-6-8-6 ABAB). Archetypal perfect rhyme + common meter + AABA-derived structure. Widely used teaching example.

---

## 3. Thai songwriting craft — additions beyond the existing skill <a id="3-thai-deepening"></a>

The existing skill covers Thai phonetic tones, สัมผัสนอก/ใน, vowel-family rhyme tables, ฉันทลักษณ์ (กลอนแปด), and 9 Thai sub-genre Style templates. This section adds what's missing: **lyrical conventions per genre**, **lyric analysis of famous Thai songs**, **modern post-2020 trends**, **deeper ฉันทลักษณ์ beyond กลอนแปด**, **singability pitfalls beyond the 10 เพี้ยน risks**, and **signature techniques of major Thai lyricists**.

### 3.1 Genre lyrical conventions (Thai, deep)

#### เพลงลูกทุ่ง (luk thung)

**Suraphol-era (1960s)** — สุรพล สมบัติเจริญ established the template: รำวง-derived rhythms, exuberant calls/teases (เรียก-ล้อ), first-person male persona, romantic-comedic complaint over a steady downbeat. Recurring themes: คนต่างจังหวัด↔คนกรุง, สาวงาม-ที่หายไป, ความน้อยใจของชนชั้นแรงงาน. Vocabulary: คำเรียก/คำอ้อนใช้สัมผัสนอกชัด. Hook pattern: คำเรียกขึ้นต้นบรรทัด (จ๋า/นะ/เอย/เอ๋ย) + คำซ้ำที่ท้ายฮุก. ([silpa-mag](https://www.silpa-mag.com/culture/article_26088))

**ครูสลา-era ลูกทุ่งอีสาน (1990s–2020s)** — สลา คุณวุฒิ (ไผ่ พงศธร, ต่าย อรทัย, ศิริพร อำไพพงษ์, ไมค์ ภิรมย์พร) reshaped the genre around คนอีสานในกรุงเทพฯ: ลูกจ้างโรงงาน, แม่บ้าน, ลูกชายส่งเงินกลับบ้าน. Signature vocabulary: *อ้าย / น้อง / เอื้อย / บ่ / แม่นบ่ / กะ / ผู้สาว / คิดฮอด / สิ / ฮัก / เผิ่น*. Narrative arc almost always: ปฐมเหตุของการพลัดพราก → ปัจจุบันยังคิดถึง → ขอความหวัง / ถามไปยังคู่ที่ห่างไกล. Hook usually phrased as a question (เธอยังคิดถึงกันบ่ / เผิ่นยังจำได้บ่). ฉันทลักษณ์: 4-line verses ≈ กลอนแปด but flexible syllable count to fit Isan melody. ครูสลา's principle: *"เพลงลูกทุ่ง 5 วิแรกต้องโดนเลย"* — open with a concrete image, not abstract emotion. ([readthecloud – ครูสลา](https://readthecloud.co/sala-khunnawut/); [The People – ฟองเบียร์](https://www.thepeople.co/read/11774))

**Modern ไผ่/ต่าย duets** — แทรกภาษาอีสานเป็น "เครื่องหมายอัตลักษณ์" ในวรรครับ/วรรคส่ง, แต่ฮุกใช้ภาษากลางเพื่อให้คนทั่วประเทศร้องตามได้. ("คองเผิ่น" 2025 — *คอง* = รอ, *เผิ่น* = เขา.)

#### หมอลำ

หมอลำเป็น "หมอ" = ผู้ชำนาญในการเอากลอนมาขับร้อง โดยมีแคนเป็นเครื่องดนตรีหลัก. กลอนลำแบ่ง 2 ประเภท: **กลอนสั้น** (เร็ว เน้นจังหวะ) / **กลอนยาว** (พรรณนา เล่าเรื่อง). โครงสร้างกลอนลำใช้สัมผัสสระตามแบบกาพย์-กลอนลาว: ทุกวรรคต้องส่งสัมผัสสระลงคำสุดท้ายของวรรค, แล้วเชื่อมไปต้นวรรคถัดไป. ([RMU – ความรู้เกี่ยวกับหมอลำ](https://arit.rmu.ac.th/หมอลำ/); [Fine Arts Dept](https://www.finearts.go.th/performing/view/12439-หมอลำ))

Modern adaptations into ลูกทุ่งอีสาน:
- **Call-response / โต้กลอน** — duet ชาย-หญิงสลับวรรค (ไผ่-ต่าย, ก้อง ห้วยไร่ feat ลำไย ไหทองคำ).
- **คำขึ้นต้น "โอ้ละน้อ / โอย / ฮ่อยฮอย / ไหล่ละน้อ"** — เป็นคำเลียนเสียงดนตรีและการเรียก.
- **คำเลียนเสียง/คำซ้ำ** — *ดอกเอ๋ย-ดอกเอย, สาวเอย-สาวเอ๋ย.*
- **เพศ-การเหน็บแนม** — มรดกที่สืบทอดมาสู่ลูกทุ่งอีสาน "แซว" (ลำไย ไหทองคำ, เบิ้ล ปทุมราช).

#### เพลงเพื่อชีวิต (phleng phuea chiwit)

ก่อตัวก่อน 14 ตุลา 16 — รากเดิมคือเพลงปลุกใจ-เพลงกรรมกร, ยกระดับโดยคาราวาน-คาราบาว ใช้รากโฟล์ก-คันทรีอเมริกัน. เนื้อหา:

- **เล่าเรื่องบุคคล/อาชีพชั้นล่าง** — "บัวลอย" (ทหารตายในสงคราม), "คนเก็บฟืน" (วิถีชีวิตป่า/ชนบท), "ชีวิตสัมพันธ์" (มนุษย์↔สัตว์↔ธรรมชาติ). ตัวละครมีชื่อ-มีเรื่อง, ไม่ใช่ "ผู้ชาย/ผู้หญิง" นามธรรม.
- **คำที่ใช้** — *แผ่นดิน, ฟ้า, ธาร, ไพร, กรรมกร, ชาวนา, อาทร, ดวงตา, จน, ทุกข์, ต่อสู้, หยาดเหงื่อ*. คำซ้อนเพื่อความหมายชัดเจน (*แผ่นดินถิ่นไทย, สู้-ทน, ทุกข์ยาก*).
- **โครงสร้าง verse-heavy** — เพลงเพื่อชีวิตเลี้ยงท่อน verse ยาวเพื่อเล่าเรื่อง; ฮุกมักสั้น-ตรง-ซ้ำได้.
- **ลีลาภาษา** — เลี่ยงคำสำนวนสวยหรู, เลือกใช้คำง่าย แต่ "กินใจ"; ใช้คำเรียกบุคคลที่ 2 (พี่น้อง, เพื่อน, สหาย) ดึงผู้ฟังเข้าเป็นส่วนของวง.

#### T-pop modern (post-2010)

Polycat, Stamp, Atlas, Lipta, ATOM กำหนด vocabulary ที่ครอบคลุม "post-Bangkok soft-pop":

- **ฮุกที่ภาษาเขียน-แต่ฟังเหมือนพูด** — Polycat: *"ถ้าจะมีความรักทั้งที อย่าเป็นเลยคนจงรักภักดี"* — โครงสร้างเป็นภาษาเขียน, แต่จังหวะตัดวรรคให้ฟังเหมือนคุย.
- **คำคู่กลาย ๆ ที่ดูเก่าๆ retro** — *ภักดี, จงรัก, กลอย, อาทร, ห่วงหา* (Polycat ตั้งใจหยิบศัพท์ลูกกรุงมา reframe).
- **โครงสร้าง verse-pre-chorus-chorus-bridge** — มาตรฐาน Western pop ยุค 2010s; ไม่ค่อยใช้ AABA แบบลูกกรุง.
- **Bridge มักเป็นจุดเปลี่ยน register** — ขยับจาก past tense (เล่า) เป็น present pleading (วิงวอน).

นะ Polycat: *"เพลงที่เขียนด้วยคำที่เรียบง่าย ไม่หวือหวา แต่ฟังแล้วสัมผัสถึงความรู้สึกที่สวยงามในนั้นได้"* ([adaymagazine – Polycat](https://adaymagazine.com/entertainment-polycat/))

#### Thai rock — Bodyslam, Cocktail, Big Ass

- **Bodyslam** — anthemic, motivational; metaphors of ไฟ/ฝัน/แสง/ทาง ปรากฏหนาแน่น. โครงสร้าง: verse ค่อยสร้าง premise ส่วนตัว → pre-chorus ยกตัวขึ้น → chorus เป็นคำเรียก/ยืนยัน. "ความเชื่อ" เป็นแม่แบบ.
- **Cocktail** — "alternative rock เชิงกวี" — ใช้คำผญา/อุปมา/คำพ้อง; ท่อน bridge ที่ขยายอุปมาเป็นภาพใหญ่.
- **Big Ass** — emo-rock เนื้อหารัก-เสียใจ, ภาษาทันสมัย, ตรงไปตรงมา; ใช้คำควบกล้ำที่บ่งบอก "ดราม่า" (ทรมาน, ทรุดโทรม).

#### Thai indie — Scrubb, Whal & Dolph, Mints

จุดร่วม: เลี่ยง marker ของยุคและสถานะ.

- **ประโยคไม่จบ** — Scrubb ตัดประโยคให้ค้าง (จบบรรทัดด้วย "ที่...", "และ...") ให้ผู้ฟังเติมเอง.
- **คำที่ "ไม่กำหนดเวลา"** — เลี่ยง "วันนี้/พรุ่งนี้/พ.ศ.", ใช้ "วันที่...", "ตอนที่..." แทน.
- **Whal & Dolph** — feel-good indie-pop; theme คือ การยอมรับ-ค่อย ๆ ค้นพบ; vocabulary หวานแต่ไม่หยด.
- **mints** — แบบสดใส-ขี้เล่น, ใช้ onomatopoeia (โบ๊ะ บะ ดะ) ผสมศัพท์ภาษาพูดของวัยรุ่น.

#### Thai R&B/Soul — Da Endorphine, Lula, Stamp (soul side)

- **Vocabulary** — รัก-เสียใจ-คิดถึง เป็น core; การสร้างภาพแบบ "interior monologue" (ในใจฉัน, ความรู้สึก, หัวใจ). คำที่นิยม: *รู้บ้างไหม, ในใจ, เก็บไว้, อยาก, แต่ไม่กล้า*.
- **Phrasing** — melisma-friendly: เลือกคำที่ลงท้ายด้วยสระเปิด (อา อี อู ไอ ออ).
- **โครงสร้าง** — verse สั้นกว่าลูกทุ่ง, ทันที pre-chorus, chorus มีฮุกที่มี high note ให้โชว์เทคนิค.

#### Thai hip-hop — Thaitanium, F.HERO, YOUNGOHM, Pyra, ILLSLICK, SPRITE

Structural challenge: ภาษาไทยส่วนใหญ่เป็น monosyllabic, เสียงเน้นมักลงคำสุดท้ายของวรรค → multisyllabic rhyme (แบบ MF DOOM, Eminem) ทำตรง ๆ ไม่ได้. แร็ปเปอร์ไทยใช้กลยุทธ์:

- **สัมผัสสระข้ามคำ (assonance chains)** — เลือกคำหลายคำที่สระเดียวกันต่อกัน: "ตา-ฟ้า-คว้า-อา" → ทำให้ฟังเหมือน multisyllabic.
- **Code-switching ไทย-อังกฤษ** — F.HERO/Thaitanium มักวาง English word/phrase ที่ตำแหน่ง end-rhyme เพื่อใช้เสียงอังกฤษ (multisyllabic ธรรมชาติ) ปิดบรรทัด.
- **YOUNGOHM** — เน้น melodic rap, pentatonic. ใช้ slang กรุงเทพฯ (โคตร, แม่ง, อ่ะ, ไง, เว้ย) เป็นภาษากลางของแร็ปยุค post-2018. ใช้ผญาเหน็บแนมแบบลูกทุ่ง+ฮิปฮอป crossover.
- **Pyra** — dark trap, ภาษาอังกฤษเป็นหลัก แต่ identity ไทย.
- **เทคนิค "เปลี่ยนเสียงวรรณยุกต์ ให้คล้อง"** — แร็ปเปอร์ไทยมักจงใจเลือกคำที่วรรณยุกต์ตรงกัน เพื่อให้ฟังลื่นกว่า.

#### Folk/Acoustic — Singto Numchok, Singular, ETC

- **Singto Numchok** — surf-pop/folk-soul; "playful" — ใช้คำธรรมดาที่สุด (ไข่, พิซซ่า, Coffee Mate) เป็น symbol สำหรับความรัก. ทำให้ความรักรู้สึก "เข้าถึงได้" ไม่ดราม่า.
- **Singular** — duo/folk-pop; ภาษาเรียบ, ภาษาแบบ "เพื่อนคุยกัน", ใช้คำขึ้นต้นบรรทัด "เธอ..." / "ฉัน..." ซ้ำกันเป็น anaphora.

#### BL/Series OST (post-2018 GMM-TV)

งานวิจัย Wiwitwannasan Journal (2024) จำแนกแนวคิดความรักใน OST ซีรีส์วาย 4 กลุ่ม 25 แนวคิดย่อย: ([Wiwitwannasan](https://so06.tci-thaijo.org/index.php/wiwitwannasan/article/view/278488))

- **รักสมหวัง** — รักคือความสุข, รักเปลี่ยนชีวิต, รักไม่ต้องอธิบาย, รักคือพรหมลิขิต
- **รักสมหวังแต่เจ็บปวด** — กลัวห่าง, สับสน, ตัดสินใจยาก
- **รักไม่สมหวัง** — แอบรัก, รักข้างเดียว, รอ, สิ้นหวัง
- **รักไม่แน่นอน** — หวง, ควบคุม, ลังเล, ทดลอง

**Lyrical signature ของ OST วาย:**
- **คำเรียกเป็นกลาง-เพศใด ๆ** — *เธอ, นาย, ฉัน, เรา* (เลี่ยง พี่/น้อง/ที่รัก/ภรรยา/สามี ที่มีนัยเพศชัด).
- **คำว่า "นาย" (you, casual masculine)** — แทบเป็น signature word ของ OST วาย.
- **คำซ้ำ-anaphora บนคำว่า "อยาก..." / "ถ้า..." / "แค่..."** — สร้าง longing.
- **โครงสร้าง slow-build ballad** — verse นุ่ม, pre-chorus ขยายภาพในใจ, chorus เป็น declaration of feeling. Tempo มาตรฐาน 70–90 BPM.

### 3.2 Annotated Thai lyric samples

(Short fair-use snippets + structural commentary. Romanization avoided per skill rule.)

**"ความเชื่อ" — Bodyslam feat. แอ๊ด คาราบาว (2005)**
- Structure: 4×4 verse + pre-chorus 2 บรรทัด + chorus 4 บรรทัด + bridge 4 บรรทัด.
- Verse 1 ขึ้นด้วยอุปมาแสง-ความหวัง — sequence: ใต้/แสง/หวัง/...ทาง. Rhyme family: /อาง/ open ตรงท้ายคำ ("ทาง-วาง-สว่าง").
- Pre-chorus เป็น declaration — ใช้สรรพนามบุรุษที่ 1 + กริยา present ("จะเดิน", "จะสู้").
- Chorus มี hook word ซ้ำที่ตำแหน่งเดียวของบรรทัด.
- Bridge — แอ๊ด คาราบาว เข้า, register เปลี่ยน → ทำหน้าที่ "anchor" ทางใจให้ chorus รอบสุดท้ายหนักขึ้น.
- เพี้ยน-risk note: เสียงโท-ตรี ในคำว่า "เชื่อ" (falling-rising) ลงในโน้ตที่ต่ำ-ขึ้น → safe.
- Signature craft: anaphora บนคำเดียวที่หัวบรรทัด, ฮุกเป็น universal statement.

**"บัวลอย" — คาราบาว (1988)**
- Structure: verses เล่าประวัติบัวลอยตั้งแต่เป็นเด็ก → ทหาร → ตาย. ฮุกขัดจังหวะการเล่าด้วย "บัวลอย-บัวลอย" anaphora บนชื่อ.
- Rhyme family: /อย/ — ใช้ซ้ำได้ทั้งเพลงเพราะ "ลอย" ผูกกับชื่อตัวละครอยู่แล้ว.
- Signature craft: ใช้ชื่อคนจริงเป็นแกนเพลง, เลี่ยงคำ abstract; ผู้ฟังจดจำ "ตัวละครชื่อบัวลอย" ก่อนข้อความ. ลายเซ็นเพลงเพื่อชีวิต. ([Mainstand](https://mainstand.co.th/th/news/1/article/9896))

**"คนเก็บฟืน" — คาราบาว (1986)**
- Opening = image painting: "เบื้องบนเป็นแผ่นฟ้ากว้าง / เบื้องล่างเป็นธารน้ำใส". กลอน 7-7 syllable, สัมผัสภายในที่ "บน-ล่าง" + "กว้าง-ใส".
- Anaphora "เบื้อง..." คู่กัน — สร้างความสมดุลภาพ.
- Rhyme: /อาง/-/ไอ/ คู่กันท้ายคู่บรรทัด AABB.
- Hook ใช้คำซ้อนเพื่อความหมายอบอุ่น — "เก็บไม้-เก็บฟืน", "ต้ม-กา", "แบ่ง-กิน".

**"ฝนตกไหม" — Three Man Down (2018)**
- Chorus-first imprinted — ฮุกเดียวที่จำได้: "แค่อยากจะรู้ว่าตรงที่เธอยืนนั้นมีฝนตกไหม". คำถามอ่อนโยน → pathos.
- Rhyme family: /ไอ/ open at line end (ไหม-ไหม-เปล่า-ใจ) — ABAB ผ่อนคลาย.
- คำซ้ำ "ไหม" 3 ครั้งใน chorus.
- Signature craft of post-2015 indie pop: ใช้คำถาม "ไหม" / "หรือเปล่า" / "ใช่ไหม" ลงท้ายฮุก. คำพวกนี้ลงสระเปิด, ลากได้ง่าย.

**"คิดมาก" — Polycat (2015)**
- Verse-driven — monologue ภายในของคนคิดเยอะ.
- Rhyme family: /อิด/, /ออน/ — สัมผัสนอกสลับ ABAB.
- คำที่ Polycat ใช้บ่อย: *เธอ, ใจ, นอน, คืน, เงียบ, รู้ดี*.

**"ภาพจำ" — อะตอม ชนกันต์**
- Premise: ความทรงจำที่ติดอยู่ในรูปภาพ — image-as-anchor.
- Structure: verse เล่าเรื่อง past tense → chorus กลับมา present ("ยังจำ...") → bridge ขยายเป็น future hypothesis.
- Rhyme: /อำ/-/ัน/ ปนกัน — สัมผัสไม่เป๊ะ AABB แต่ assonance พอแล้ว.
- "ภาพจำ" เป็น title-hook — ฟองเบียร์-school technique.

**"เธอ" — Singular**
- Anaphora บนคำว่า "เธอ" — verse-only AAAA: ทุกบรรทัดใน chorus เริ่มด้วย "เธอ...".
- Rhyme: assonance หลวม ๆ — vowel echo ไม่ต้องเป๊ะ.
- Vocabulary indie 2010s: *ทุกอย่าง, รู้สึก, อยู่ตรงนี้, เปลี่ยนไป*.

**"คองเผิ่น" — ไผ่ พงศธร × ต่าย อรทัย (2025)**
- Hook ใช้คำอีสาน "คอง = รอ" + "เผิ่น = เขา" — คนฟังจำคำคู่ใหม่ที่ไม่ใช่ภาษากลาง.
- Duet structure — ผู้ชายเล่า verse 1, ผู้หญิงเล่า verse 2, ฮุกร้องคู่.
- Rhyme: สัมผัสนอก AABB strict กลอนแปด + สัมผัสในระดับ assonance อีสาน.

**"ชีวิตสัมพันธ์" — คาราบาว**
- Verse แบบ list/inventory — ลำดับสิ่งมีชีวิต (นก, แม่ลูกอ่อน, คน, สัตว์) เพื่อสร้าง "ระบบนิเวศ" ในเพลง.
- Hook สั้น ลื่น ซ้ำได้ — ใช้ "เรา" → กลายเป็นเพลงรวมหมู่ (sing-along anthem).
- Rhyme family: /อิน/-/ิน/ — easy chorus.

**Reference: ลูกกรุง / สุนทราภรณ์ era**
- Verse แบบ AABA หรือ ABAC ที่ chorus เป็น literary refrain.
- Vocabulary: *รำพึง, อาทร, รัญจวน, ดวงสมร, ทรวง, ไฉน, ดั่ง, มิ-, สุดเอย*. นำมาใช้ใน modern Polycat → flavor "retro" / "old-Bangkok".

### 3.3 Modern Thai lyric trends (post-2020)

**Conversational Soft Register** — Atlas, Tilly Birds, Three Man Down, Nont Tanont:
- ลงท้ายบรรทัดด้วย particle ภาษาพูด: *นะ, นะคะ, ก็, อะ, สิ*
- เริ่มประโยคด้วย "ถ้า..." / "แค่..." / "เผื่อ..."
- ไม่มี marker ยุค-สถานที่
- verse สั้น chorus ยาว (ตรงข้ามกับเพื่อชีวิต)

**Code-switching ไทย-อังกฤษ:**
- **Phum Viphurit** — "Lover Boy" อังกฤษล้วน, แต่ context ไทย; "Hello, Anxiety" ผสมประโยคอังกฤษเข้าวรรคไทย. "Bangkok-international artist" strategy.
- **F.HERO/YOUNGOHM-style rap** — English word placed deliberately at end-rhyme position.
- **BL OST + T-pop ballad** — title-hook เป็นภาษาอังกฤษ chunk แล้ว verse ภาษาไทย.

**Multisyllabic-rhyme attempts ในแร็ปไทย:** assonance chains + end-rhyme cluster of 2–4 monosyllables ที่อ่านรวมเหมือนเป็น multisyllabic + เน้นเสียง percussive (ก/ป/ต/ฟ) ที่ตำแหน่งเดียวของ bar.

**BL romance vocabulary:**
- Pronouns: *นาย, เธอ, เรา*
- Verbs: *เป็นห่วง, ดูแล, ไม่ปล่อย, ใกล้, เก็บ, ค่อย ๆ*
- หลีกเลี่ยง: *พี่/น้อง* (เพศชัด), *สวย* (gendered female), *หล่อ* บางเพลง

**Bedroom-pop soft-vocabulary:** *เงียบ, หลับ, แสงไฟ, เพดาน, ฝน, นาฬิกา, อยู่ตรงนี้, ลำพัง* — image domestic แทน metaphor มหึมาแบบ rock.

### 3.4 ฉันทลักษณ์ echoes in modern song design

**กาพย์ยานี ๑๑** — 1 บท = 2 บาท = 4 วรรค. วรรคหน้า 5 พยางค์, วรรคหลัง 6 พยางค์, รวม 11 พยางค์/บาท. Modern echo: หลายเพลงป๊อปไทย verse ที่ตัด 5+6 พยางค์ — เช่น Polycat verse rhythm ใกล้กาพย์ยานี. ใช้ในการแต่ง verse-only / bridge ที่ต้องการลีลา "อ่อนหวาน, ช้า, พรรณนา". ([NockAcademy – กาพย์ยานี](https://nockacademy.com/thai-language/เรียนรู้เรื่องกาพย์ยานี-11-พร้อมเคล็ดลับการแต่งกาพย์แบบง่ายดาย/))

**กลอนสุภาพ vs กลอนเปล่า:**
- **กลอนสุภาพ (กลอนแปด)**: 4 วรรค, 8 พยางค์/วรรค — แม่แบบลูกทุ่ง.
- **กลอนเปล่า**: ไม่มีสัมผัสบังคับ — Bodyslam/Cocktail/indie ใช้บ่อยใน verse เพื่อให้เล่าได้คล่อง; กลับเข้าสัมผัสตอน chorus.

**คำซ้ำ คำซ้อน คำเลียนเสียง:**
- **คำซ้อนเพื่อความหมาย** — *บ้านเรือน, รักใคร่, ทุกข์ยาก* — ใช้สร้าง "weight" และ formality. นิยมในเพลงเพื่อชีวิต & ลูกกรุง.
- **คำซ้อนเพื่อเสียง** — *ซุ่มซ่าม, ตูมตาม, กรุ่นกลิ่น* — สร้าง sonic interest ใน verse-pop/indie.
- **คำเลียนเสียง (onomatopoeia)** — *โบ๊ะ, ปั๊ก, จ๊ะ, เอ๋อ, อู๊ย* — เด่นใน mints/Singto/TikTok-pop.
- **คำซ้ำที่หัวบรรทัด (anaphora)** — ลายเซ็นฟองเบียร์ที่ทำให้เพลงจำได้.

**โคลงสี่สุภาพ** — แทบไม่มีในเพลง — บังคับเอก-โทเข้มเกินไป. แต่ "spirit" ของโคลง — จบบรรทัดด้วย "สุดยอดเสียง" + คำ formal — ปรากฏใน chorus ของเพื่อชีวิต/anthem rock ที่ขึ้น climax.

### 3.5 Singability pitfalls beyond the 10 เพี้ยน risks

The existing skill covers 10 risk patterns. Additional patterns found in research:

**คำที่ AI/karaoke มักร้องผิด:**
- คำควบกล้ำที่ต้องลงน้ำหนัก ค-ร, ก-ล, ป-ล — *ครอบครัว, ความเชื่อ, ปลูกฝัง, กล้าหาญ*. AI vocal models มัก "ลด" เสียงควบเป็นเสียงเดี่ยว. หลีกเลี่ยงตำแหน่งสำคัญ (downbeat ของฮุก).
- คำพ้องเสียงที่ตัดสินใจไม่ได้ — *ขัน, พัน* — AI จะร้องวรรณยุกต์กลาง ๆ ฟังกำกวม.
- คำมีตัวสะกดเงียบ — *กตัญญู, ปฏิเสธ, ภัย, ศักดิ์* — เสี่ยงร้องผิดตัวอักษร.

**คำที่ "ไม่ร้องดี" (ลายเซ็นที่นักแต่งเลี่ยง):**
- คำหลายพยางค์ทาง formal compound — *ประสบการณ์, สมัครสมาน, อภินันทนาการ* — กินจังหวะมาก, chorus ฟังหนัก.
- คำที่ลงท้ายด้วย "พยัญชนะแน่น" (ก/ด/บ) ในตำแหน่งที่ต้องลากเสียง — ลากไม่ได้.
- คำที่มี vowel สั้น + ตัวสะกดหนัก วางที่ note ยาว — "เพลงค้าง". เปลี่ยนเป็นคำสระยาว.

**มืออาชีพแก้ปัญหา:**
- เลือก synonym ที่ลงเสียง — *คิดถึง* (3 พยางค์, ลงท้ายเสียงสามัญที่ลากได้) แทน *นึกถึง* (สามัญแต่ "ก" หนัก).
- ใช้คำพ้องเสียง strategically — "ใจ" คล้องกับ "ไหน/ไป/ใคร/ใจ" → "rhyme gold" ของ pop ไทย.
- เปลี่ยนวรรณยุกต์ของคำเดียวด้วย particle — แทน "นี้" (โท) ด้วย "นี่" (เอก) เพื่อลงโน้ตที่ต่ำกว่า.
- Front-load consonant-heavy words — เอาคำควบใส่ต้น verse ไม่ใช่ chorus.

### 3.6 Signature techniques of major Thai lyricists

**ดี้ นิติพงษ์ ห่อนาค** — *"บัญญัติ 5 ประการ"* (SkillLane): (1) แต่งให้ใครร้อง (2) ทำนอง (3) เรื่อง (4) สื่อสาร (5) ความประทับใจ. คำสัมผัสกันในเพลงทุกเพลง. คำ "ไพเราะเสนาะหู" — มาตรฐาน Grammy ยุค 90s. แต่งให้เหมาะกับคนร้อง — เนื้อเดียวกันแต่งให้เบิร์ดกับอัสนีจะออกมาคนละโทน. ([SkillLane](https://www.skilllane.com/courses/music-composer-skill); [Thai PBS](https://www.thaipbs.or.th/now/content/3380); [Music MThai](https://music.mthai.com/news/newsmusic/85973.html))

**สุรักษ์ สุขเสวี** — ภาษาเขียน > ภาษาพูด — ใช้คำสุภาพ-เป็นทางการเพื่อสร้างพลัง emotional. อบอุ่น > เศร้า — เลือกอารมณ์ที่ "ปลอบ" มากกว่า "ทำให้รู้สึกแย่"; กลายเป็น niche ของเขา. ใช้ภาพประสบการณ์จริง แต่ "พิมพ์" ผ่านภาษาเขียนให้ดูสากล. ([Sarakadee](https://www.sarakadee.com/2019/08/01/สุรักษ์-สุขเสวี/))

**ฟองเบียร์ (ปฏิเวธ อุทัยเฉลิม)** — คำซ้ำต้นวรรค ("เธอยัง..." × 3 / "แสนล้านนาที..."). First 5 seconds rule (จากครูสลา). "เราไม่ค่อยคิดซับซ้อน คิดซับซ้อนไม่ค่อยเก่ง" → emotional directness. โครงสร้าง intro-A-B-Hook-A2-B2-Hook-Bridge-Hook ที่ทุกท่อนต้อง "พูดเรื่องเดียวกัน, ขยายเรื่อย ๆ". ([The People – ฟองเบียร์](https://www.thepeople.co/read/11774); [Sanook – ฟองเบียร์](https://www.sanook.com/music/2379301/))

**บอย โกสิยพงษ์** — ทำนองนำคำ — บอยทำทำนองก่อน แล้วใส่คำให้พอดี. คำง่าย แต่ image ลึก — *ความรัก, รอย, เธอ, อยู่*; พื้นฐาน Bakery R&B/funk. ไม่มีลายเซ็นทาง rhyme บังคับ — assonance หลวม + groove นำ. ([adaymagazine – บอย](https://adaymagazine.com/boy-kosiyapong/))

**ครูสลา คุณวุฒิ** — "5 วินาทีแรกต้องโดน" — verse 1 ต้องมีภาพชัด, มีคำเฉพาะที่เห็น (ไม่ใช่ feeling นามธรรม). หัวใจคือ "ความไพเราะ" ที่ตรงใจคนชั้นล่าง. ปั้นเพลงประจำตัวศิลปิน — เนื้อหาต้องสอดคล้องกับ "ที่มา" ของศิลปิน. สอนแต่งเพลงผ่าน "มหาลัยใจดี". ([readthecloud – ครูสลา](https://readthecloud.co/sala-khunnawut/))

**ปั่น ไพบูลย์เกียรติ** — เน้น "เสียงสูง" + คำที่ลากได้; แต่งเอง โดยเน้น chorus มี high note ที่ลง "อา/อี/ออ".

---

## 4. Suno bilingual prompt behavior (2025–2026) <a id="4-suno-bilingual"></a>

### 4.1 Model timeline (v4.5 → v5.5)

| Version | Released | Headline change |
|---|---|---|
| v4.5 | May 2025 | 8-min first gen, smarter style mashups, "improved prompt adherence" |
| v4.5+ | Jul 2025 | Add Vocals / Add Instrumental production tools |
| v4.5-all | (community-tracked) | Carry-over slider system stabilized |
| v5 (`chirp-crow`) | Sept 23, 2025 | "Studio-grade" audio, 12-stem separation, Persona Voices, Sample-to-Song, 4-min extends, vocal naturalness step-change |
| v5.5 | Mar 26, 2026 | Voice Cloning ("Voices"), Custom Models (train on your catalog, up to 3), "My Taste" passive personalization. **No prompt-syntax change** — same 1,000-char Style, 5,000-char Lyrics, same metatags |

Takeaways:
- **v5 measurably improved English vocal clarity** and reduced robotic/metallic artifacts. Non-English pronunciation also improved (better Korean, Spanish) but the English-vs-non-English gap remains visible.
- **v5.5 changes nothing for prompt syntax** but introduces Voices, which let a user lock vocal identity — meaning gender/timbre tags should be **dropped** when a Voice is active to free character budget for production detail.
- **Character limits matter:** v5 = 200-char Style, v5.5 = 1,000-char Style. Overage is **silently truncated** with no warning — front-load genre/mood/vocal tags.

### 4.2 English-language behavior in v5/v5.5

#### What v5 does well in English

- Naturalistic phrasing, less "AI singer" timbre, clearer consonants on radio-pop/folk/R&B vocals.
- Better structure adherence: v5 "respects structure tags more consistently."
- Repeats hooks faithfully when the **exact same chorus text is pasted in every chorus slot** (not via "repeat chorus" shorthand).

#### Where v5 still fails on English

- **Homographs**: *read, live, lead, bass, tear, wind, wound, close, refuse, present, object, conduct, desert, produce, record, contract* — Suno guesses, often wrong, and re-rolling rarely changes the choice.
- **Silent letters / irregular spelling**: *knight, queue, colonel, choir, Wednesday.*
- **Loanwords**: *genre, fiancé, café, façade.*
- **Acronyms**: `AI` reads as "aye" sometimes; force with `A I` (spaced) or "ay-eye".
- **Numbers/dates**: `2024` unreliable — spell out "twenty twenty-four".
- **Rushed/mumbled lines**: lines >15 syllables get crunched. Sweet spot 6–12 syllables; verses 8–10, choruses 10–12.

Core principle: **once audio renders, pronunciation is locked. Fix the lyric text, not the generated audio.** ([HookGenius pronunciation guide](https://hookgenius.app/learn/fix-suno-pronunciation/))

#### English fix tactics that work

- Phonetic respell: `through` → `thru`, `colonel` → `kernel`, `your` → `yore`.
- Hyphenate syllables: `tonight` → `to-night`.
- Space letters: `AI` → `A I`.
- Pick synonyms over phonetic rewriting whenever possible.
- Diction-boosting tags: `[Staccato]` (best overall), `[Spoken Word]`, `[Operatic]`, `[Crisp]`.

#### The AAVE / regional accent problem

Real, repeatedly documented Suno limitation:
- "Generated accents often sound off, sometimes leaning toward British rather than the desired Southern, New York, or West Coast styles."
- Suno "defaults to a generic 'white-sounding' voice" for rap/trap by default.
- **Community-proven workaround:** put the regional flavor **into the lyric text** (slang, syntax, contractions like "ain't", "finna", "y'all") rather than relying on a tag.
- Indirect accent triggers that DO help: `Memphis trap`, `Atlanta trap`, `Compton hip-hop beat`, `West Coast g-funk` — geographic/sub-genre tags pull accent better than `Southern accent` does directly.

#### Rhyme density and English melodic phrasing

- **Dense end-rhyme breaks Suno's melodic phrasing.** "Too dense, too perfect, too repetitive" rhymes cause Suno to over-emphasize last words, rush lines, and make the chorus feel crowded.
- Safer rhyme pattern for melodic sections: rhyme every 2nd or 4th line (ABCB, AABB, or ABAB), not every line.
- **Chorus should have LOWER rhyme density than verse.** Verses can carry tighter rhyme; choruses need air to repeat cleanly.
- Reserve dense, multi-syllabic, internal-rhyme writing for **rap/spoken** sections only. ([Jack Righteous – Rhyme Architecture](https://jackrighteous.com/en-us/blogs/music-creation-process-guide/rhyme-architecture-ai-songwriting))

#### Hook placement: does Suno respect English chorus repetition?

Yes, conditionally:
- Hook must be **short** (2–4 lines, 6–10 syllables/line). Long novel choruses produce robotic chorus artifacts.
- Hook lines must be **pasted identically every time** — using "[Chorus]" alone without re-pasting the text often yields drift.
- Short repeated hooks (2–4 reps) sing better than one-pass long choruses.
- Pre-Chorus tags help — explicitly anchoring `[Pre-Chorus]` before `[Chorus]` raises the model's "build expectation."

#### BPM ranges that work for English by genre (Suno community-validated)

| Genre | Range | Optimal |
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

### 4.3 Language-mixing strategies

#### Two encoding patterns

**Section-anchored (recommended, community consensus):**
```
[Verse 1] (Spanish)
...
[Chorus] (English)
...
[Verse 2] (Spanish)
...
```
The parenthetical language tag on the section header is the highest-leverage anchor for stable code-switching.

**Line-anchored / inline mix:** strongly discouraged. Failure modes: language drift mid-phrase, broken stress, garbled phrasing across the language boundary. Existing Thai-skill rule (no Thai+English in the same line) generalizes to all bilingual cases.

#### "(Parenthetical echo)" pattern for translation

- Parenthetical text in lyrics becomes a **backing/ad-lib vocal layer**, not a sung lead line.
- Use it for echo translations: `I'll wait forever (te esperaré)` — the Spanish echo surfaces as backing harmony.
- Use it for ad-libs: `Rise up (rise up, rise up)`.
- Same bracket-vs-parenthesis grammar the Thai skill already documents. **Translation echoes are the cleanest bilingual pattern** when full bilingual sections are too heavy.

#### K-pop English-chorus pattern

K-pop is the canonical bilingual case:
- Romanize Korean (`Saranghae`, not 사랑해) — Hangul direct input causes pre-v5 drift; v5 handles it better but romanization remains safer.
- Hyphenate for syllabic control: `Sa-rang-hae`.
- Section-anchor English chorus explicitly: `[Chorus] (English)`.
- Group-vocal tags critical: `Mixed group vocals`, `Layered harmonies`, `Gang vocals`, `Group Chant`.

#### Spanglish (Latin pop, reggaeton)

Same pattern as K-pop — section-anchor switches, romanize Spanish only if necessary (Suno handles Spanish in native orthography well). Reggaeton 88–100 BPM. Vocal tags: `melodic male delivery`, `dembow rhythm`.

#### Language-stability declaration

Community-recommended global pin in Style field when drift is a problem:
- `All lyrics in [language X], no English` (or `no [language Y]`)
- Place in **both** Style field and as a comment in Lyrics field for redundancy.

#### Drift recovery

If a generation drifts mid-song:
1. Remove mixed-language lines until base version is stable
2. Re-add code-switches one section at a time
3. Keep recurring hooks **letter-identical** to lock pronunciation

### 4.4 Tag vocabulary — English vs other languages

#### Tags that influence English diction

- `[Staccato]` — best single tag for English enunciation
- `[Spoken Word]` — clearest pronunciation, suppresses melodic mush
- `[Operatic]` — dramatic precise articulation
- `[Crisp]` / "crisp diction"
- `country drawl`, `twangy vocals`, `Southern accent` (weak), `slight drawl`
- Indirect regional triggers: `Memphis trap`, `Atlanta trap`, `Nashville polish`, `Compton hip-hop`, `West Coast g-funk`

#### Tags that influence non-English diction

Almost none are language-named. The working pattern is **regional-genre tags** that pull dialect indirectly (`reggaeton`, `K-pop boy band`, `J-pop`, `bossa nova`, `flamenco`, `luk thung`, `mor lam`). Direct tags like "in Spanish accent" or "Thai accent" are not consistently respected.

#### Singer-style descriptors (universal)

- **Character**: `raspy male tenor`, `smooth baritone`, `deep female alto`, `silky female vocals`, `young male tenor`
- **Delivery**: `breathy`, `powerful belt`, `whispered`, `spoken word`, `drawl`, `falsetto`, `aggressive`, `emotional delivery`, `conversational rap`, `melismatic`
- **Effects**: `reverb-drenched`, `dry close-mic`, `doubled harmonies`, `lo-fi filtered`, `auto-tuned`, `ASMR-like`

Always include character + delivery + effects.

#### Production tags (universal)

- **Texture**: `lo-fi tape hiss`, `vinyl crackle`, `tape saturation`, `crisp digital clarity`
- **Mix**: `polished radio-ready`, `warm analog`, `bedroom recording feel`, `stadium reverb`, `spacious and wide`, `compressed and loud`
- **Words Suno IGNORES**: `professional`, `high-quality`, `amazing`, `best ever` — compliments, not descriptors.

#### No-artist-names rule

**Universal — applies to both Thai and Western artists.** Multiple sources confirm:
- Suno blocks recognized artist names (and many lookalikes). Generations may fail or be silently filtered.
- "In the style of [artist name]" prompts get blocked or quietly substituted.
- Producer-tag matches (drops like "Mike Will Made-It") in lyrics also trigger filters.
- Workaround: describe the **sonic fingerprint** instead of naming. Existing Thai-skill rule generalizes directly.

### 4.5 Genre-specific English Styles strings

Community-shared, paste-ready Styles strings:

**Pop:**
> Dream pop, shimmering reverb-drenched guitars, airy ethereal female soprano, lush synth pads, nostalgic dreamy atmosphere, wide stereo, 98 BPM

> Synth-pop, 80s-inspired, euphoric and nostalgic, powerful female vocals with layered harmonies, analog synth pads, punchy drum machine, shimmering arpeggios, Moog bass, polished radio-ready production, 118 BPM

**Rock:**
> 90s grunge rock, distorted guitars, gritty male baritone, pounding live drums, dark moody energy, raw garage production, 110 BPM

**Country:**
> Modern country, acoustic and electric guitars, pedal steel accents, heartfelt male baritone with slight drawl, Nashville polish, storytelling cadence, 96 BPM

> Outlaw country, dusty acoustic guitar, upright bass, gravelly male baritone, vintage 70s tape warmth, sparse raw arrangement, 88 BPM

**Hip-hop:**
> Melodic trap, atmospheric pads, 808 sub-bass, autotuned melodic male rap delivery, reverb-heavy, dark moody aesthetic, 140 BPM half-time feel

> Boom-bap hip-hop, dusty sample loop, vinyl crackle, hard-knock drums, conversational male rap delivery, gritty street energy, 88 BPM

**R&B:**
> Neo-soul, Rhodes piano, live warm bass, brushed drums, soulful female alto with jazzy phrasing, earthy organic production, 88 BPM

> Modern R&B, sparse trap-influenced drums, lush pad layers, silky male tenor with melismatic runs, polished radio production, 78 BPM

**Folk:**
> Indie folk, fingerpicked acoustic guitar, intimate warm male tenor, subtle cello, brushed percussion, storytelling cadence, 88 BPM

**EDM:**
> Synthwave, pulsing analog arpeggios, gated reverb drums, DX7 electric piano, wide stereo, nostalgic 80s futurism, 112 BPM

> Progressive house, euphoric synth lead, side-chained pad, four-on-the-floor kick, soaring female vocal hook, festival energy, 124 BPM

**Lo-fi / Chill:**
> Lo-fi hip-hop, chill and nostalgic, pitched-down vocal sample, Rhodes piano, tape-saturated drums, vinyl crackle, warm analog bass, lo-fi tape hiss, 75 BPM

### 4.6 Thai vs English behavior comparison table

| Dimension | English best practice | Thai best practice | Differentiate in skill? |
|---|---|---|---|
| **Tone/pitch matching** | N/A (English is stress-timed, not tonal) | Critical — เพี้ยน risk per syllable | Yes — Thai-only audit |
| **Stress matching** | Critical — stressed syll → downbeat | N/A (Thai is syllable-timed) | Yes — English-only audit |
| **Rhyme density** | Loose, every 2nd or 4th line; dense breaks melody | สัมผัสนอก/ใน per khlong-jong rules; vowel-family matching | Yes — different rule systems |
| **Syllables per line** | 6–12 sweet spot, 8–10 verse, 10–12 chorus | 6–9 typical (Thai syllables are heavier) | Yes — different ranges |
| **Romanization** | N/A | Forbidden — use Thai script | Same rule, different reason |
| **Section anchoring** | `[Verse] (English)` | `[Verse] (Thai)` | Same pattern, both languages |
| **Hook repetition** | Paste identical chorus text every chorus | Same | No difference |
| **Bracket vs parenthesis** | `[directives]` vs `(backing/echo)` | Identical | No difference |
| **Mispronunciation source** | Homographs, silent letters, loanwords | Tone-melody mismatch, ambiguous vowel lengths | Yes — different audit lists |
| **Accent control** | Geographic sub-genre tags + slang in lyric text | Sub-genre tags (ลูกทุ่ง, อีสาน) + regional vocabulary | Same tactic, different vocab |
| **BPM ranges** | Wider; genre-driven | Often slower for ลูกทุ่ง / Thai pop ballads; faster for หมอลำ | Yes — separate slider tables |
| **Artist name filter** | Blocks Western artists | Blocks Thai artists | Same rule, mention both populations |
| **Diction tags** | `[Staccato]`, `[Spoken Word]`, `[Crisp]` reliably improve | Same tags work; less documented effect | Same recommendations |
| **Drift declaration** | "All lyrics in English, no [other]" | "All lyrics in Thai, no English / no Romanization" | Same pattern |
| **Number/date handling** | Spell out (`twenty twenty-six`) | Spell out (สองพันยี่สิบหก) | Same rule |

---

## 5. Synthesis — implications for the bilingual skill refactor <a id="5-synthesis"></a>

What the research means for actually rebuilding the skill. Recommendations grouped by category.

### 5.1 Architecture preservation

- **Keep the two-tier loading.** Add new English reference files in parallel to existing Thai ones. Don't inline reference content into `SKILL.md`.
- **Preserve the warn-don't-auto-fix invariant.** English homograph flagging is the analog of เพี้ยน flagging — surface candidate fixes, let the user pick.
- **Preserve two parallel audits, kept separate.** Refactored Step 8 supports up to **four** blocks now (only render the ones with content):
  - `### ⚠️ Pronunciation Risk Flags (Thai)` — เพี้ยน
  - `### ⚠️ Pronunciation Risk Flags (English)` — homographs/silent letters/loanwords
  - `### 🎼 Rhyme Audit (Thai)` — คำคล้องจอง
  - `### 🎼 Rhyme Audit (English)` — density check, scheme detection
- **Keep the frontmatter discoverability hooks.** The description field is keyword-rich for skill matching; preserve that, but add English-language trigger phrases ("write English song for Suno", "English Suno prompt", "T-pop English chorus", etc.).
- **Keep the bracket-vs-parenthesis grammar** (load-bearing, Suno-enforced).

### 5.2 New rules to encode

1. **Language anchoring rule.** Every section header in a bilingual lyric must carry `(English)` or `(Thai)` (or both for intentional code-switching sections). This becomes a structural lint.
2. **No-mix-per-line rule (generalized).** Already a Thai rule. Generalize: no single sung line should contain both Thai and English. Backing-vocal parenthetical echoes are the **only** sanctioned exception.
3. **Echo-translation pattern.** Document `Lead line (echo translation)` as the canonical bilingual translation device.
4. **English homograph list.** Ship a starter list (`read, live, lead, bass, tear, wind, wound, close, refuse, present, object, conduct, desert, produce, record, contract`) and flag any occurrence with a suggested rewrite.
5. **English rhyme density check.** If end-rhyme density exceeds 75% of chorus lines, warn. If internal rhyme appears in a melodic (non-rap) section, warn. Existing Thai rhyme audit logic generalizes.
6. **Syllables-per-line check (per language).** Thai: 6–9. English: 8–10 verse, 10–12 chorus. Flag >15 in either language.
7. **Drift declaration heuristic.** If the lyric is >70% one language, suggest adding `All lyrics in [X], no [Y]` to the Style field.
8. **First-5-Seconds rule (both languages).** After drafting, check verse 1: does the opening have a concrete image / specific noun? If not, flag.
9. **Hook placement check (English).** Title must appear in chorus line 1, last line, both, or repeated every line. Warn if missing.
10. **Stress-to-downbeat audit (English).** Flag function-words on inferred downbeats, multi-syllable words with wrong dictionary stress.
11. **Cliché-pair rhyme list (English).** Flag fire/desire, heart/apart, eyes/lies, love/above; suggest family/assonance alternatives.

### 5.3 New reference files to add

Proposed file structure (parallel to existing Thai files):

```
references/
  # Existing (Thai)
  suno-fields-reference.md        ← update: add v5/v5.5 char limits, English-tag notes
  tonal-melodic-rules.md          ← keep
  pian-risk-checklist.md          ← keep
  khlong-jong-rhyme.md            ← keep
  style-templates.md              ← rename → style-templates-th.md
  examples.md                     ← rename → examples-th.md
  
  # New (English)
  song-structure-en.md            ← §2.1 — forms, BPM, section functions
  lyric-frameworks-en.md          ← §2.2 — Pattison, Davis, Sondheim, Stolpe, Blume, Webb
  rhyme-craft-en.md               ← §2.3 — six rhyme types, schemes, cliché pairs, density rules
  prosody-meter-en.md             ← §2.4 — stress-timing, feet, stress-to-downbeat, word painting
  genre-conventions-en.md         ← §2.5 — 10 genres with BPM/structure/rhyme/vocabulary
  style-templates-en.md           ← §4.5 — paste-ready Styles strings per English genre
  english-diction-checklist.md    ← homographs, silent letters, loanwords (parallel to pian-risk-checklist.md)
  examples-en.md                  ← worked examples for English genres
  
  # New (bilingual)
  bilingual-mixing.md             ← §4.3 — language anchoring, echo translation, K-pop pattern, drift recovery
  genre-lyric-conventions-th.md   ← §3.1 — Thai genre lyrical conventions (deepening current style templates)
  lyricist-signatures-th.md       ← §3.6 — ดี้/สุรักษ์/ฟองเบียร์/บอย/ครูสลา signature techniques
```

This is a doubling, but each file stays load-on-demand. `SKILL.md` references them via Step 2.

### 5.4 Updated output template (Step 8)

```
## 🎵 [Title]

### 📋 Styles (paste into Styles field)
[Styles string — front-load genre+mood+vocal+BPM]
⚠ Note: v5 truncates Styles at 200 chars silently. Total: [N] chars.

### 📝 Lyrics (paste into Lyrics field)
[Verse 1] (Thai)
...
[Pre-Chorus] (Thai)
...
[Chorus] (English)
...
[Verse 2] (Thai)
...
[Bridge] (Thai)
...
[Chorus] (English)
...

### ⚙️ Settings
- Vocal Gender: [Male / Female / Duet]
- Weirdness: [X]%
- Style Influence: [Y]%
- Model: [v4.5+all / v5 / v5.5]

### ⚠️ Pronunciation Risk Flags (Thai)
[เพี้ยน items — rendered only if Thai content present]

### ⚠️ Pronunciation Risk Flags (English)
[homograph/silent-letter/loanword items — rendered only if English content present]

### 🎼 Rhyme Audit (Thai)
[สัมผัสนอก/ใน findings — rendered only if Thai content present]

### 🎼 Rhyme Audit (English)
[scheme detected; density warnings; cliché-pair flags — rendered only if English content present]

### 🔁 Iteration Tips
[as before, language-aware]
```

### 5.5 Slider/Styles updates

- Add a per-English-sub-genre Weirdness / Style Influence table (parallel to the existing Thai table). For English, the community consensus is similar — radio pop favors lower Weirdness + higher Style Influence; experimental/indie favors the opposite. Use Hookgenius and Suno community ranges:
  - **English mainstream pop**: Weirdness 25–35%, Style Influence 70–85%
  - **English rock / pop-rock**: 35–50%, 65–80%
  - **English indie**: 50–65%, 55–70%
  - **English country**: 25–35%, 75–88%
  - **English hip-hop / trap**: 40–55%, 60–75%
  - **English R&B / neo-soul**: 25–40%, 70–85%
  - **English folk / singer-songwriter**: 30–45%, 65–80%
  - **English EDM / dance**: 30–45%, 70–85%
  - **English lo-fi / chill**: 35–50%, 65–80%
  - **English blues**: 30–45%, 70–85%
- BPM tables in `suno-fields-reference.md` need a second column for English-genre ranges (see §4.2 table).
- Add accent guidance: warn that direct accent tags ("Southern accent", "British accent") are weak; recommend **geographic sub-genre tags + in-lyric slang** as the proven workaround.

### 5.6 Model-version awareness

- Update the version table to include v5.5 (March 2026) and note that voice-cloning users should drop `male vocals`/`female singer` tags from Style.
- Note v5's 200-char and v5.5's 1,000-char Style limits with the "silent truncation" warning so the prompt builder front-loads critical tags.
- Add a Style-budget calculator note: "If Styles > 200 chars and user is on v5, warn that tags after position 200 will be silently dropped."

### 5.7 What NOT to change

- The bracket-vs-parenthesis grammar.
- The "warn, don't auto-fix" stance for all four audit tracks.
- The Thai script default for Thai content (no romanization).
- The Step 8 output template's section order (don't reorganize casually — it's the user-visible contract).
- The "no artist names" guard — extend it to include Western artists explicitly in the warning copy.
- The frontmatter discoverability hooks — preserve keyword density even when adding English triggers.

### 5.8 Optional advanced additions (judgment calls for build phase)

These were surfaced by research but are not strictly required for a viable bilingual MVP. Each is a small, testable feature:

- **"Style-of-X" mode for Thai lyricists** — Let user pick "เขียนแบบดี้ / ฟองเบียร์ / ครูสลา / บอย / สุรักษ์" and apply that lyricist's signature rules. Higher-effort, niche value.
- **BL OST mode** — enforce gender-neutral pronouns + 25 romance taxonomy concepts; default theme picker for รักสมหวัง / รักไม่สมหวัง / รักไม่แน่นอน.
- **Word painting bonus pass** — when lyric contains a directional word (up/down/rise/fall/stop), suggest a melodic-direction hint in the Styles prompt. Optional polish, easy to skip.
- **Multisyllabic rap-rhyme audit** — for hip-hop mode, scan for assonance chains and multisyllabic rhyme units; flag verses lacking density.
- **Show-don't-tell pass (English)** — if chorus lines are >50% abstract feeling-words (love, sad, lonely, broken), suggest replacing one with concrete imagery.
- **Pattison stable-vs-unstable audit** — for ballads/literary songs, check whether structural choices (line length, rhyme position, even/odd lines) match the lyric's emotional state.
- **Hook melodic-shape hint** — for English songs, suggest "hook on highest note" in the Styles prompt when title is short.

These can ship later — none are blockers for a working bilingual v1.

---

## 6. Sources <a id="6-sources"></a>

### English songwriting craft

**Frameworks and theory:**
- [Berklee Online – Prosody in Music and Songwriting](https://online.berklee.edu/takenote/prosody-in-music-and-songwriting/)
- [Pat Pattison – Berklee faculty page](https://college.berklee.edu/people/c-pat-pattison)
- [Pat Pattison – Online Courses](https://www.patpattison.com/online-courses)
- [Pat Pattison – Art of Phrasing](https://www.patpattison.com/art-of-phrasing)
- [Sound on Sound – Pat Pattison: Writing Better Lyrics](https://www.soundonsound.com/techniques/pat-pattison-writing-better-lyrics)
- [Pattison's Essential Guide to Rhyming](https://www.amazon.com/Pat-Pattisons-Songwriting-Step-Step/dp/0876391501)
- [Sheila Davis – Craft of Lyric Writing (Internet Archive)](https://archive.org/details/craftoflyricwrit0000davi)
- [Andrea Stolpe – Popular Lyric Writing (Berklee Press)](https://berkleepress.com/songwriting/popular-lyric-writing/)
- [Andrea Stolpe – Rhyme Types](https://www.andreastolpe.com/articles/rhyme-types)
- [Andrea Stolpe – Singer-Songwriter Style](https://www.andreastolpe.com/articles/what-defines-the-singer-songwriter-style-and-how-to-find-yourself-within-it)
- [Stephen Sondheim – Three Principles](https://advicetowriters.com/advice/2015/4/21/stephen-sondheims-three-principles-of-lyric-writing.html)
- [Jimmy Webb – Tunesmith (Internet Archive)](https://archive.org/details/tunesmith00jimm)
- [Jason Blume – Six Steps to Songwriting Success](https://www.penguinrandomhouse.com/books/15113/six-steps-to-songwriting-success-revised-edition-by-jason-blume/)

**Structure, form, BPM:**
- [Wikipedia – Song structure](https://en.wikipedia.org/wiki/Song_structure)
- [MasterClass – Common Song Structures](https://www.masterclass.com/articles/songwriting-101-learn-common-song-structures)
- [Songstuff – AABA](https://www.songstuff.com/songwriting/article/aaba-song-form/)
- [Songstuff – AAB](https://www.songstuff.com/songwriting/article/aab-song-form/)
- [NSAI – Structure of Number Ones](https://www.nashvillesongwriters.com/structure-number-ones)
- [Rap Authority – 16 Bars in Rap](https://rapauthority.com/16-bars-in-rap/)
- [EDM Tips – EDM Song Structure](https://edmtips.com/edm-song-structure/)
- [Unison – EDM Song Structure 101](https://unison.audio/edm-song-structure/)
- [Orphiq – BPM by Genre](https://orphiq.com/resources/bpm-tempo-guide)
- [Chosic – BPM by Genre List](https://www.chosic.com/bpm-by-genre-list/)
- [zZounds – Pre-Chorus to Chorus](https://blog.zzounds.com/2022/03/07/anticipation-to-eruption-connecting-your-pre-chorus-to-your-chorus/)
- [Producer Hive – What is a Pre-Chorus](https://producerhive.com/songwriting/what-is-a-pre-chorus/)

**Hooks and titles:**
- [Berklee Online – Killer Hooks](https://online.berklee.edu/takenote/how-to-write-songs-with-killer-hooks/)
- [SoundFly Flypaper – Lyrical Hooks](https://flypaper.soundfly.com/write/write-lyrical-hooks/)

**Rhyme:**
- [Wikipedia – Multisyllabic rhymes](https://en.wikipedia.org/wiki/Multisyllabic_rhymes)
- [ASCAP – Rhyme Schemes for Songwriters](https://www.ascap.com/help/career-development/15-rhyme-schemes-jordan-reynolds)
- [BMI – 5 Song Rhyming Pitfalls](https://www.bmi.com/news/entry/5-song-rhyming-pitfalls-and-how-to-avoid-them)

**Meter, prosody, phrasing:**
- [Penn – Rhythm and Meter in English Poetry](https://www.writing.upenn.edu/~afilreis/88v/meter.html)
- [MasterClass – Iambic Meter](https://www.masterclass.com/articles/understanding-iambic-meter)
- [The Song Foundry – Prosody 101](https://thesongfoundry.com/prosody-songwriting-101/)
- [Songwriting.net – Size Matters](https://www.songwriting.net/blog/size-matters-a-study-in-prosody)
- [David Darling – Back Phrasing](https://www.daviddarling.info/encyclopedia_of_music/B/back_phrasing.html)
- [Wikipedia – Word Painting](https://en.wikipedia.org/wiki/Word_painting)

**Show don't tell, POV:**
- [Songwriting.net – Show Don't Tell](https://www.songwriting.net/blog/bid/209079/Show-Don-t-Tell-3-Steps-to-Writing-Better-Lyrics)
- [BMI – Show Don't Tell](https://www.bmi.com/news/entry/showdont_tell_3_steps_to_writing_better_lyrics)

**Genre conventions:**
- [Westword – 10 Biggest Country Tropes](https://www.westword.com/music/the-ten-biggest-tropes-in-country-music-5694846/)
- [Lyncil – How to Write R&B Lyrics](https://www.lyncil.com/blog/how-to-write-rb--lyrics)
- [Wikipedia – Singer-songwriter](https://en.wikipedia.org/wiki/Singer-songwriter)

**Real-song analyses:**
- [David Lapadat – Someone Like You breakdown](https://www.davidlapadat.com/post/breaking-down-adele-s-someone-like-you-a-masterclass-in-song-structure)
- [Slave to Music – Bohemian Rhapsody](https://slavetomusic.com/the-secret-architecture-of-queens-bohemian-rhapsody-meaning-structure-and-studio-secrets/)
- [Wikipedia – Hallelujah](https://en.wikipedia.org/wiki/Hallelujah_(Leonard_Cohen_song))
- [Wikipedia – Wagon Wheel](https://en.wikipedia.org/wiki/Wagon_Wheel_(song))
- [Singing Coach – Lose Yourself](https://www.singingcoach.ai/lose-yourself-eminem)
- [Switched on Pop – Taylor Swift Songwriting School](https://switchedonpop.substack.com/p/the-taylor-swift-songwriting-school)
- [Story of Song – Skinny Love](https://storyofsong.com/story/skinny-love/)

**Public domain references:**
- [Wikipedia – Scarborough Fair](https://en.wikipedia.org/wiki/Scarborough_Fair_(ballad))
- [Wikipedia – House of the Rising Sun](https://en.wikipedia.org/wiki/The_House_of_the_Rising_Sun)

### Thai songwriting craft

**Genre & history:**
- [silpa-mag – สุรพล สมบัติเจริญ](https://www.silpa-mag.com/culture/article_26088)
- [silpa-mag – เพลงเพื่อชีวิตก่อน 2500](https://www.silpa-mag.com/history/article_67706)
- [silpa-mag – บัวลอย](https://www.silpa-mag.com/culture/article_32852)
- [Mainstand – แอ๊ดเล่าที่มาบัวลอย](https://mainstand.co.th/th/news/1/article/9896)
- [fungjaizine – เพลงเพื่อชีวิตกับการเมือง](https://www.fungjaizine.com/article/guru/comrade-songs)
- [Sarakadee Lite – เพลงเพื่อชีวิต นิวเจน](https://www.sarakadeelite.com/lite/songs-social-messages/)
- [Thai Wikipedia – เพลงเพื่อชีวิต](https://th.wikipedia.org/wiki/เพลงเพื่อชีวิต)
- [Thai Wikipedia – หมอลำ](https://th.wikipedia.org/wiki/หมอลำ)
- [Thai Wikipedia – ความเชื่อ (Bodyslam)](https://th.wikipedia.org/wiki/ความเชื่อ_(เพลงบอดี้สแลม))
- [Thai Wikipedia – เพลงลูกกรุง](https://th.wikipedia.org/wiki/เพลงลูกกรุง)
- [RMU – ความรู้เกี่ยวกับหมอลำ](https://arit.rmu.ac.th/หมอลำ/)
- [Fine Arts Dept – หมอลำ](https://www.finearts.go.th/performing/view/12439-หมอลำ)
- [Esanpedia – กลอนลำ](https://www.esanpedia.oar.ubu.ac.th/musicsound/?cat=42)
- [Wiwitwannasan – Songs of Y series](https://so06.tci-thaijo.org/index.php/wiwitwannasan/article/view/278488)
- [HipHopDX – F.HERO Thai hip hop OG](https://hiphopdx.com/en_asia/news/f-hero-thai-hip-hops-og-pioneer-ultimate-champion)
- [Happening – Thailand hip hop timeline](https://happeningandfriends.com/article-detail/99?lang=en)
- [Bandwagon – Whal & Dolph](https://www.bandwagon.asia/articles/asia-spotlight-whal-and-dolph-on-making-waves-in-thailand-s-music-scene-what-the-duck)

**Lyricist interviews:**
- [adaymagazine – Polycat](https://adaymagazine.com/entertainment-polycat/)
- [adaymagazine – Atom Chanakan](https://adaymagazine.com/lyrics-1/)
- [adaymagazine – Scrubb](https://adaymagazine.com/lyrics-3/)
- [adaymagazine – บอย โกสิยพงษ์](https://adaymagazine.com/boy-kosiyapong/)
- [readthecloud – ครูสลา](https://readthecloud.co/sala-khunnawut/)
- [Sarakadee – สุรักษ์ สุขเสวี](https://www.sarakadee.com/2019/08/01/สุรักษ์-สุขเสวี/)
- [The People – ฟองเบียร์](https://www.thepeople.co/read/11774)
- [SkillLane – บัญญัติ 5 ประการ ดี้](https://www.skilllane.com/courses/music-composer-skill)
- [Thai PBS – ดี้ นิติพงษ์](https://www.thaipbs.or.th/now/content/3380)
- [Music MThai – ดี้แนะเคล็ดลับเขียนเพลงฮิต](https://music.mthai.com/news/newsmusic/85973.html)
- [Sanook – 10 เพลงดังที่ฟองเบียร์เขียน](https://www.sanook.com/music/2379301/)

**ฉันทลักษณ์ & rhyme:**
- [Sanook campus – แผนผังกลอนแปด](https://www.sanook.com/campus/1423131/)
- [trueplookpanya – สัมผัสนอก-สัมผัสใน](https://www.trueplookpanya.com/dhamma/content/90496)
- [NockAcademy – กาพย์ยานี ๑๑](https://nockacademy.com/thai-language/เรียนรู้เรื่องกาพย์ยานี-11-พร้อมเคล็ดลับการแต่งกาพย์แบบง่ายดาย/)
- [NockAcademy – คำซ้อน](https://nockacademy.com/thai-language/เรียนรู้และเข้าใจเรื่องคำซ้อนในภาษาไทย/)
- [Veradet – คำซ้อน คำซ้ำ](https://www.veradet.com/1450)

### Suno bilingual behavior

- [HookGenius – Complete Suno Prompt Guide (2026)](https://hookgenius.app/learn/suno-prompt-guide-2026/)
- [HookGenius – Suno v5 Complete Guide](https://hookgenius.app/learn/suno-v5-complete-guide/)
- [HookGenius – Suno v5.5 Guide](https://hookgenius.app/learn/suno-v5-5-guide/)
- [HookGenius – Suno Pronunciation Fix Guide](https://hookgenius.app/learn/fix-suno-pronunciation/)
- [HookGenius – Free Suno Prompts (200+ recipes)](https://hookgenius.app/suno-prompts/)
- [HookGenius – Fix Suno Repetition](https://hookgenius.app/learn/fix-suno-repetition/)
- [HookGenius – All Suno Metatags](https://hookgenius.app/learn/suno-metatags-complete-list/)
- [Jack Righteous – Suno v5 Multilingual Guide](https://jackrighteous.com/en-us/blogs/guides-using-suno-ai-music-creation/suno-v5-multilingual-english-pronunciation-guide)
- [Jack Righteous – Custom Lyrics in Suno v5](https://jackrighteous.com/en-us/blogs/guides-using-suno-ai-music-creation/custom-lyrics-in-suno-v5)
- [Jack Righteous – Rhyme Architecture for AI](https://jackrighteous.com/en-us/blogs/music-creation-process-guide/rhyme-architecture-ai-songwriting)
- [Jack Righteous – Suno Meta Tags Guide](https://jackrighteous.com/en-us/pages/suno-ai-meta-tags-guide)
- [blakecrosley – Suno V5.5 Reference](https://blakecrosley.com/guides/suno)
- [Suno Wiki – v5 chirp-crow release](https://sunoaiwiki.com/news/2025/09-25-suno-v5-chirp-crow-api/)
- [Suno Wiki – Improve Suno hip-hop/rap/trap](https://sunoaiwiki.com/tips/2024-07-08-improve-suno-hiphop-rap-trap/)
- [Suno Wiki – Advanced Song Production](https://sunoaiwiki.com/tips/2024-05-05-advanced-song-production-techniques-for-suno-ai/)
- [Suno official – v5.5 announcement](https://suno.com/blog/v5-5)
- [Suno help – Model Timeline](https://help.suno.com/en/articles/5782721)
- [Music Business Worldwide – Suno v5.5](https://www.musicbusinessworldwide.com/suno-launches-v5-5-ai-model-with-voice-capture-and-personalization-features/)
- [OpenMusicPrompt – K-pop Suno Guide](https://openmusicprompt.com/blog/how-to-make-kpop-suno-guide)
- [HowToPromptSuno – Making music](https://howtopromptsuno.com/making-music)
- [SunoAIPromptGuide – Avoid Artist Names](https://sunoaipromptguide.org/how-to-avoid-artist-name-tags-on-suno-ai/)
- [FLTMAG – Suno AI Language Learning](https://fltmag.com/suno-ai/)
- [Suno.wiki – Voice Tags](https://www.suno.wiki/faq/metatags/voice-tags/)
- [Polyglossic – Suno target-language pop](https://www.polyglossic.com/suno-ai-music-in-target-language/)
- [Song AI Farm – Suno AI Best Practices 2026](https://www.songaifarm.com/blog/suno-ai-music-generator-2026-best-lyrics-prompts-guide)

---

## Confidence notes

- **High confidence**: English songwriting frameworks (Pattison, Davis, Sondheim, Stolpe, Webb, Blume) — well-documented academic and industry sources, multiple cross-references. Thai รค (rhyme), ฉันทลักษณ์, and major lyricist signatures — Thai-language scholarship and journalism corroborate. Suno field grammar and version timeline — official documentation.
- **Medium confidence**: Genre-specific BPM ranges (multiple community sources align, but exact "optimal" numbers are aggregated averages, not laws). English-language Suno behavior (Hookgenius and Jack Righteous are evidence-grounded but represent specific creator communities — different user populations may report different patterns). Per-Thai-sub-genre slider values (community-reported, not officially confirmed by Suno).
- **Lower confidence**: Exact effect-sizes of individual tags (e.g., does `[Staccato]` reliably improve Thai diction, or just English? Multiple sources say both, but no controlled study). The AAVE/regional-accent claims (consistent across sources but anecdotal).

## Boundaries reminder

This is a **research report only**. No code has been written, no skill files have been edited, no architectural decisions are final. Next step is the user's call:

- `/sc:design` — turn §5 into a concrete architecture plan with file structure and migration path.
- `/sc:implement` — start writing the new reference files and updating `SKILL.md`.
- Continue researching — if any section feels thin (e.g., need more English-genre examples, or deeper Thai-lyricist coverage), spawn another agent.
