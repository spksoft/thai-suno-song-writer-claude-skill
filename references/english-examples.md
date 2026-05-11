# Worked Examples — English Suno Prompts

Each example is a full, ready-to-paste output as the skill would deliver it. Copy the structure and adapt for the user's actual concept.

Two examples cover the English-only baseline: a pop ballad and a country uptempo. Both demonstrate the **Suno 2025+ directive grammar** layered on top of the standard skill output: inline parenthetical performance cues `(whispered)`, `(belted)`, `(building intensity)`, `(stripped back)`, `(spoken word)`, `(harmonized)`, `(ad-lib)`, `(half-time feel)` placed BEFORE the line they modify; v5+ meta tags `[Mood: ...]`, `[Vocal Style: ...]`, `[Texture: ...]`, `[Callback: chorus melody]` placed at the top of the Lyrics field; and the **three-layer vocal spec** (Character + Delivery + Effects) in the Styles field.

Both examples follow the 5-part Style formula (Genre/Subgenre → Mood & Energy → Vocal Direction → Instrumentation → Production & Tempo) with 8–15 tags, raised from the older 4–8 guidance.

Pronunciation flags and rhyme audits are kept visually separate in the output, per the skill's "warn, don't auto-fix" convention. Bilingual examples live in `thai-examples.md`.

---

## Example 1 — English pop ballad (heartbreak, female lead, ~3:30)

**User concept:** A breakup ballad about realizing it's over while looking through old photos. Female lead, 3:30.

### 🎵 Pictures of Us

**Rhyme blueprint (chosen before writing):**
- Hook word = "us" → chorus rhyme family is `/ʌs/` (us, dust) — short, intimate
- Chorus AABB perfect rhyme on /ʌs/ + /ɛnd/
- Verse ABCB ballad-meter, family rhyme on /əʊ/ (open vowels for sustained notes)
- Pre-chorus AA couplet on /eɪ/ (lifts into chorus)

### 📋 Styles (paste into Styles field)

```
modern pop ballad, bittersweet hopeful melancholy, intimate breathy female alto with subtle vibrato, slightly behind-the-beat phrasing, fingerpicked acoustic guitar, soft strings, warm piano, polished radio mix with airy reverb, 82 BPM, crisp English diction
```

*(11 tags · 235 chars — exceeds v5 200-char cap, use v5.5 or trim "warm piano,")*

**Three-layer vocal spec inside the Styles field:**
- **Character:** intimate breathy female alto
- **Delivery:** with subtle vibrato, slightly behind-the-beat phrasing
- **Effects:** airy reverb (folded into "polished radio mix with airy reverb")

### 📝 Lyrics (paste into Lyrics field)

```
[Mood: bittersweet hopeful melancholy]
[Vocal Style: intimate breathy alto, slightly behind the beat]
[Texture: sparse verse, blooming chorus]

[Intro]
[Soft fingerpicked acoustic guitar]

[Verse 1]
(stripped back)
A shoebox underneath the bed
Faded photographs I never threw away
Your handwriting on the back in red
Says we'd remember every single day

[Pre-Chorus]
(building intensity)
Now the colors start to fade
And the memories are all that stayed

[Chorus]
These are just the pictures of us
Frozen smiles that turned to dust
Wish I knew back then how it ends
Now I'm holding on to ghosts of friends

[Verse 2]
A movie ticket from a winter show
The summer dress I wore the night you stayed
A postcard from a beach I'd never go
The little promises that we both made

[Pre-Chorus]
(building intensity)
Now the colors start to fade
And the memories are all that stayed

[Chorus]
These are just the pictures of us
Frozen smiles that turned to dust
Wish I knew back then how it ends
Now I'm holding on to ghosts of friends

[Bridge]
[Soft piano]
(whispered)
Maybe nothing lasts the way we thought it would
Maybe loving you was the best thing I could
But the pictures stay the same
While the years just rearrange

[Chorus]
[Callback: chorus melody]
(belted)
These are just the pictures of us
Frozen smiles that turned to dust
Wish I knew back then how it ends
Now I'm holding on to ghosts of friends

[Outro]
[Acoustic guitar fade]
(ad-lib)
Just the pictures of us...

[Fade Out]
```

### ⚙️ Settings
- **Vocal Gender:** Female
- **Weirdness:** 28%
- **Style Influence:** 78%
- **Model:** v5.5 recommended (v5 truncates Styles at 200 chars)

### 🎙️ Directives used
- `[Mood: bittersweet hopeful melancholy]` — v5+ meta tag at top to anchor emotional register across regenerations
- `[Vocal Style: intimate breathy alto, slightly behind the beat]` — meta tag declares the three-layer vocal spec inside the Lyrics field too
- `[Texture: sparse verse, blooming chorus]` — meta tag asks Suno to widen the arrangement at the chorus
- `(stripped back)` before Verse 1 — pulls instrumentation down so the lyric's first 5 seconds land clean
- `(building intensity)` before each Pre-Chorus — instructs the lift into the chorus
- `(whispered)` before the Bridge — peak vulnerability moment, melodic climb begins
- `[Callback: chorus melody]` before the final Chorus — anchors the melody-recall expectation
- `(belted)` before the final Chorus — pushes the vocal to its strongest take to land the emotional payoff
- `(ad-lib)` before the Outro tag — lets Suno improvise a final wordless flourish on "Just the pictures of us..."

### ⚠️ Pronunciation Risk Flags (English)
- Line "A postcard from a beach I'd never go": "go" at line-end on /əʊ/ is open vowel — safe. No flag.
- Line "Frozen smiles that turned to dust": "dust" closed-vowel /ʌ/ at line-end — but it's the hook word, ear expects the closure; accept and watch the take. If Suno collapses it, lengthen to "turned to ash and dust."
- *No other major risks detected — vocabulary is unambiguous, no homographs in stressed positions, line lengths within 12-syllable target*

### 🎼 Rhyme Audit (English)
- **Verse 1:** ABCB on /ɛd/ + /eɪ/ (bed/red rhyme; away/day rhyme) ✓
- **Verse 2:** ABCB on /əʊ/ + /eɪ/ (show/go; stayed/made) ✓ — shares /eɪ/ family with Verse 1
- **Pre-Chorus:** AA couplet on /eɪd/ (fade/stayed) ✓
- **Chorus:** AABB perfect (us/dust on /ʌs/ + /ʌst/; ends/friends on /ɛndz/) ✓
- **Bridge:** AABB on /ʊd/ (would/could; same/rearrange — assonance, deliberately less stable for emotional climax) ✓
- **Hook placement:** "us" appears in chorus line 1 ("pictures of us") — front-loaded hook ✓
- **No cliché pairs detected**
- **Show-don't-tell:** chorus is concrete (shoebox, photos, postcards, dress, ticket) — pass ✓
- *Rhyme scheme: verse ABCB, chorus AABB; hook placement: chorus line 1 with end-line echo; no major issues*

### 🔁 Iteration Tips
- If vibe is off: increase Style Influence to 88%, decrease Weirdness to 18%
- If "dust" collapses on the held note: use Replace Section in Song Editor with "turned to ash" instead
- If you want the track recognized for series work: ⋮ → Make Persona before iterating
- For a longer version: use Extend from the end of the outro and add an instrumental break
- If the `(belted)` final chorus is too dramatic: drop it back to `(building intensity)` or remove entirely

---

## Example 2 — English country uptempo (small-town nostalgia, male lead, ~3:00)

**User concept:** A country song about a hometown that's changed but still feels like home. Male lead, ~3:00, mid-tempo.

### 🎵 Same Old Town

**Rhyme blueprint:**
- Hook = "same old town" → chorus rhyme family `/aʊn/` (town, down, found, around) — large family
- Chorus AABB perfect on /aʊn/ + /eɪn/
- Verse ABAB on /iː/+/ɪm/ and /ɪŋ/+/eɪn/ (large families with strong vowels)
- Pre-chorus drives into chorus with /aɪnd/ additive

### 📋 Styles

```
modern country, nostalgic warm, heartfelt male baritone with slight Tennessee drawl, conversational storytelling cadence, acoustic and electric guitars, pedal steel accents, brushed drums, walking bass, polished Nashville mix with subtle reverb tail, 98 BPM, crisp English diction with country drawl
```

*(12 tags · 295 chars — use v5.5 or trim "brushed drums," / "walking bass,")*

**Three-layer vocal spec:**
- **Character:** heartfelt male baritone with slight Tennessee drawl
- **Delivery:** conversational storytelling cadence
- **Effects:** subtle reverb tail (folded into "polished Nashville mix with subtle reverb tail")

### 📝 Lyrics

```
[Mood: nostalgic warm homecoming]
[Vocal Style: storytelling baritone, conversational with slight drawl]
[Texture: rolling steel + brushed drums]

[Intro]
[Acoustic guitar, pedal steel sweep]

[Verse 1]
(spoken word)
Drove past the high school where I used to be
The Friday-night-lights have all gone dim
But the football field still looks the same to me
And I can hear the band start playing the old hymn

[Pre-Chorus]
(building intensity)
Some things change and some things don't
And I came back tonight to find

[Chorus]
(harmonized)
It's the same old town
With the same old crowd
The diner on the corner where we used to hang around
The water tower's gone but the river's still the same
And I'm still the kid who used to know everyone by name

[Verse 2]
Old man Walter passed away last spring
The gas station's now a coffee chain
But the church bell at noon still has the same ring
And the cottonwood is bending in the rain

[Pre-Chorus]
(building intensity)
Some things change and some things don't
And I came back tonight to find

[Chorus]
(harmonized)
It's the same old town
With the same old crowd
The diner on the corner where we used to hang around
The water tower's gone but the river's still the same
And I'm still the kid who used to know everyone by name

[Bridge]
[Pedal steel solo, 4 bars]
(half-time feel)
Maybe I was wrong to think I had to leave
Maybe I was wrong to think I'd ever find
A place to call my own and a heart to believe
'Cause the home I had was already on my mind

[Chorus]
[Callback: chorus melody]
(belted)
It's the same old town
With the same old crowd
The diner on the corner where we used to hang around
The water tower's gone but the river's still the same
And I'm still the kid who used to know everyone by name

[Outro]
[Pedal steel fade]
(ad-lib)
Same old town...

[Fade Out]
```

### ⚙️ Settings
- **Vocal Gender:** Male
- **Weirdness:** 30%
- **Style Influence:** 82%
- **Model:** v5.5 recommended

### 🎙️ Directives used
- `[Mood: nostalgic warm homecoming]` — anchors the emotional register; resists drift toward melancholy or party-country
- `[Vocal Style: storytelling baritone, conversational with slight drawl]` — locks the three-layer vocal spec inside the Lyrics field
- `[Texture: rolling steel + brushed drums]` — keeps pedal steel forward; signals brush kit not big stadium drums
- `(spoken word)` before Verse 1 — slight talk-sing delivery on the opening verse (Nashville convention for setup verses)
- `(building intensity)` before each Pre-Chorus — the standard country lift into the chorus
- `(harmonized)` before each Chorus — invites Suno to layer the chorus with backing-vocal stacks (Nashville polish)
- `(half-time feel)` before the Bridge — drops the drum feel to half-time during the perspective shift (a country bridge convention)
- `[Callback: chorus melody]` before the final Chorus — anchors recall to the same melody we've heard twice
- `(belted)` before the final Chorus — pushes vocal to peak for the final payoff line "I'm still the kid who used to know everyone by name"
- `(ad-lib)` before the Outro tag — lets the singer riff on "Same old town..." over the pedal steel fade

### ⚠️ Pronunciation Risk Flags (English)
- Line "The football field still looks the same to me" (13 syllables) — within target. No flag.
- Line "Old man Walter passed away last spring": proper noun "Walter" — Suno handles common Anglo names OK; no flag.
- *No major risks detected — country vocabulary is concrete, no homographs, no acronyms or digits*

### 🎼 Rhyme Audit (English)
- **Verse 1:** ABAB on /iː/ + /ɪm/ (be/to me; dim/hymn) ✓
- **Verse 2:** ABAB on /ɪŋ/ + /eɪn/ (spring/ring; chain/rain) ✓ — shares /eɪn/ family with chorus end-rhyme
- **Pre-Chorus:** AA couplet on /aɪnd/ (don't/find — additive rhyme, mild tension lifting into chorus) ✓
- **Chorus:** AABB on /aʊn/ (town/crowd/around) + /eɪm/ (same/name) ✓
- **Bridge:** AABB on /iːv/ (leave/believe) + /aɪnd/ (find/mind) ✓
- **Hook placement:** "same old town" appears line 1 of chorus + repeated phrasings throughout — front-loaded hook, repeated 4+ times per chorus ✓
- **No cliché pairs**; "town/crowd/around" is a country-staple but family ✓
- **Show-don't-tell:** verses load up specific objects (high school, Friday-night-lights, football field, diner, water tower, river, gas station, church bell, cottonwood, pedal steel) — Pattison-strong concrete imagery ✓
- *Rhyme scheme: verse ABAB, chorus AABB perfect; hook placement: chorus line 1, repeated 4+ times; no major issues*

### 🔁 Iteration Tips
- If the drawl is too thick: drop "Tennessee drawl" from Styles or change to "light drawl"
- If the song feels generic: change "town" to a specific place name in the lyric (Suno handles Anglo place names like "Nashville", "Austin", "Charleston" well)
- For a duet version: change Verse 2 vocal to Female and add `[Female Vocal]` tag at Verse 2
- If `(half-time feel)` doesn't trigger in the bridge: replace with `[Drums: half-time]` directive at the top of the bridge section
- If `(harmonized)` chorus stacks too heavily: drop to `(layered backing vocals)` or remove

---

## Notes on these examples

- Both follow the Step 8 output template in `SKILL.md` exactly. Section headers, ordering, and severity formats are load-bearing.
- Example 1 is the English-only pop ballad baseline.
- Example 2 demonstrates country conventions (concrete imagery, ABAB+AABB, family rhyme on hook).
- Each example shows the **Suno 2025+ directive grammar**: v5+ meta tags at top of Lyrics field, inline parenthetical performance cues before the line they modify, the three-layer vocal spec inside Styles, and a new `🎙️ Directives used` block listing each non-trivial directive with rationale.
- The audits show what "clean" output looks like. When flags exist, they sit in the same place with rewrite suggestions; the user picks.
- For bilingual T-pop examples (Thai verses + English chorus) and Thai-only examples, see `thai-examples.md`.
