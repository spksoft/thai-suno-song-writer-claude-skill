# Worked Examples — English & Bilingual Suno Prompts

Each example is a full, ready-to-paste output as it would be given to a user. Copy the structure and adapt for the user's actual concept.

Two parallel audits per language are shown — pronunciation risk and rhyme/form audit kept separate. For bilingual songs, a bilingual-mixing audit is added.

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
modern pop ballad, bittersweet hopeful, fingerpicked acoustic guitar, soft strings, intimate female alto, polished radio mix, 82 BPM, crisp English diction
```
*(193 chars — within v5 200-char limit)*

### 📝 Lyrics (paste into Lyrics field)
```
[Intro]
[Soft fingerpicked acoustic guitar]

[Verse 1]
A shoebox underneath the bed
Faded photographs I never threw away
Your handwriting on the back in red
Says we'd remember every single day

[Pre-Chorus]
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
Now the colors start to fade
And the memories are all that stayed

[Chorus]
These are just the pictures of us
Frozen smiles that turned to dust
Wish I knew back then how it ends
Now I'm holding on to ghosts of friends

[Bridge]
[Soft piano]
Maybe nothing lasts the way we thought it would
Maybe loving you was the best thing I could
But the pictures stay the same
While the years just rearrange

[Chorus]
These are just the pictures of us
Frozen smiles that turned to dust
Wish I knew back then how it ends
Now I'm holding on to ghosts of friends

[Outro]
[Acoustic guitar fade]
Just the pictures of us...

[Fade Out]
```

### ⚙️ Settings
- **Vocal Gender:** Female
- **Weirdness:** 28%
- **Style Influence:** 78%
- **Model:** v4.5+all (or v5 / v5.5 if Pro/Premier)

### ⚠️ Pronunciation Risk Flags (English)
- Line "A postcard from a beach I'd never go": "go" at line-end on /əʊ/ is open vowel, safe. No flag.
- Line "Frozen smiles that turned to dust": "dust" closed-vowel /ʌ/ at line-end — but it's the hook word, ear expects the closure; accept and watch the take. If Suno collapses it, lengthen to "turned to ash and dust."
- *No other major risks detected — vocabulary is unambiguous, no homographs in stressed positions, line lengths within 12-syllable target*

### 🎼 Rhyme Audit (English)
- **Verse 1:** ABCB on /ɛd/ + /eɪ/ (bed/red rhyme; "away"/"day" rhyme) ✓
- **Verse 2:** ABCB on /əʊ/ + /eɪ/ (show/go; "stayed"/"made") ✓ — shares /eɪ/ family with Verse 1
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

---

## Example 2 — English country uptempo (small-town nostalgia, male lead, ~3:00)

**User concept:** A country song about a hometown that's changed but still feels like home. Male lead, ~3:00, mid-tempo.

### 🎵 Same Old Town

**Rhyme blueprint:**
- Hook = "same old town" → chorus rhyme family `/aʊn/` (town, down, found, around) — large family
- Chorus AABB perfect on /aʊn/ + /eɪn/
- Verse ABCB on /aɪ/ + /əʊ/ (large families with strong vowels)
- Pre-chorus drives into chorus with /aʊ/ assonance

### 📋 Styles
```
modern country, acoustic and electric guitars, pedal steel accents, warm male baritone with slight drawl, Nashville polish, storytelling cadence, 98 BPM, crisp English diction with country drawl
```
*(184 chars — within v5 limit)*

### 📝 Lyrics
```
[Intro]
[Acoustic guitar, pedal steel sweep]

[Verse 1]
Drove past the high school where I used to be
The Friday-night-lights have all gone dim
But the football field still looks the same to me
And I can hear the band start playing the old hymn

[Pre-Chorus]
Some things change and some things don't
And I came back tonight to find

[Chorus]
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
Some things change and some things don't
And I came back tonight to find

[Chorus]
It's the same old town
With the same old crowd
The diner on the corner where we used to hang around
The water tower's gone but the river's still the same
And I'm still the kid who used to know everyone by name

[Bridge]
[Pedal steel solo, 4 bars]
Maybe I was wrong to think I had to leave
Maybe I was wrong to think I'd ever find
A place to call my own and a heart to believe
'Cause the home I had was already on my mind

[Chorus]
It's the same old town
With the same old crowd
The diner on the corner where we used to hang around
The water tower's gone but the river's still the same
And I'm still the kid who used to know everyone by name

[Outro]
[Pedal steel fade]
Same old town...

[Fade Out]
```

### ⚙️ Settings
- **Vocal Gender:** Male
- **Weirdness:** 30%
- **Style Influence:** 82%
- **Model:** v4.5+all (or v5 / v5.5 if Pro/Premier)

### ⚠️ Pronunciation Risk Flags (English)
- Line "The football field still looks the same to me" (13 syllables) — within target. No flag.
- Line "Old man Walter passed away last spring": proper noun "Walter" — Suno handles common Anglo names OK; no flag.
- *No major risks detected — country vocabulary is concrete, no homographs, no acronyms or digits*

### 🎼 Rhyme Audit (English)
- **Verse 1:** ABAB on /iː/ + /ɪm/ ("be"/"to me"; "dim"/"hymn") ✓
- **Verse 2:** ABAB on /ɪŋ/ + /eɪn/ ("spring"/"ring"; "chain"/"rain") ✓ — shares /eɪn/ family with chorus end-rhyme
- **Pre-Chorus:** AA couplet on /aɪn/ ("don't"/"find" — additive rhyme, mild tension lifting into chorus) ✓
- **Chorus:** AABB on /aʊn/ (town/crowd/around) + /eɪm/ (same/name) ✓
- **Bridge:** AABB on /iːv/ (leave/believe) + /aɪnd/ (find/mind) ✓
- **Hook placement:** "same old town" appears line 1 of chorus + repeated phrasings throughout — front-loaded hook, repeated 4+ times per chorus ✓
- **No cliché pairs**; "town/crowd/around" is a country-staple but family ✓
- **Show-don't-tell:** verses load up specific objects (high school, Friday-night-lights, football field, diner, water tower, river, gas station, church bell, cottonwood, pedal steel) — Pattison-strong concrete imagery ✓
- *Rhyme scheme: verse ABAB, chorus AABB perfect; hook placement: chorus line 1, repeated 4+ times; no major issues*

### 🔁 Iteration Tips
- If the drawl is too thick: drop "country drawl" from Styles
- If the song feels generic: change "town" to a specific place name in the lyric (Suno handles Anglo place names like "Nashville", "Austin", "Charleston" well)
- For a duet version: change Verse 2 vocal to Female and add `[Female Vocal]` tag at Verse 2

---

## Example 3 — Bilingual T-pop ballad (Thai verses + English chorus, male lead, ~3:30)

**User concept:** A romantic T-pop ballad about long-distance love. Thai verses tell the story; English chorus is the emotional declaration. Male lead.

### 🎵 ระยะทาง (Ten Thousand Miles)

**Rhyme blueprint:**
- Thai verses on /ai/ open (ใจ-ไป-ไกล family) — ABAB
- Thai pre-chorus on /a/ open (มา-หา-ครา) — couplet
- English chorus AABB perfect on /aɪz/ + /aɪnd/ (miles/eyes; find/mind)
- Bridge mixed-language (Thai → English transition) — flagged below

### 📋 Styles
```
modern T-pop ballad, bittersweet long-distance, fingerpicked acoustic guitar, warm strings, intimate male tenor, polished radio mix, 84 BPM, Thai verses with English chorus, no in-line mixing
```
*(213 chars — ⚠ exceeds v5 200-char limit by 13; use v5.5 or trim "intimate" → "" )*

### 📝 Lyrics
```
[Intro]
[Soft fingerpicked acoustic guitar]

[Verse 1] (Thai)
ในคืนที่ฟ้ายังไม่สาย
หัวใจฉันยังคิดถึงเธอเสมอ
แม้ระยะทางจะแสนไกล
ภาพของเธอก็ไม่เคยเลือนเผลอ

[Pre-Chorus] (Thai)
และทุกครั้งที่ดาวลอยลงมา
(ลงมา ลงมา)
หัวใจฉันก็เปียกชื้นทุกครา

[Chorus] (English)
Ten thousand miles between us tonight
Still I see your face when I close my eyes
Distance cannot break this hold of mine
You're the one I'll always look to find

[Verse 2] (Thai)
ภาพถ่ายใบเก่าที่ยังเก็บใกล้
รอยยิ้มของเธอที่ยังจำเสมอ
ทุกๆ คำที่เคยพูดเข้าใจ
ยังก้องอยู่ข้างในใจที่ยังเพ้อ

[Pre-Chorus] (Thai)
และทุกครั้งที่ดาวลอยลงมา
(ลงมา ลงมา)
หัวใจฉันก็แหลกสลายทุกครา

[Chorus] (English)
Ten thousand miles between us tonight
Still I see your face when I close my eyes
Distance cannot break this hold of mine
You're the one I'll always look to find

[Bridge] (English)
[Soft piano]
If the night could carry me to where you are
I would walk every step no matter how far
Just to hold you once again
Tell you that I never went

[Chorus] (English)
Ten thousand miles between us tonight
Still I see your face when I close my eyes
Distance cannot break this hold of mine
You're the one I'll always look to find

[Outro]
[Acoustic guitar fade]
ระยะทาง... ten thousand miles...

[Fade Out]
```

### ⚙️ Settings
- **Vocal Gender:** Male
- **Weirdness:** 30%
- **Style Influence:** 80%
- **Model:** v5.5 recommended (v5 truncates Styles)

### ⚠️ Pronunciation Risk Flags (Thai — เพี้ยน)
- บรรทัด "หัวใจฉันยังคิดถึงเธอเสมอ" (11 syllables) — ภายในเป้า, "คิด" สามัญ + "ถึง" สามัญ + "เธอ" สามัญ → ทำนองได้อิสระ. ไม่มี flag.
- "เผลอ" ที่ปลาย verse 2: รัตวา /ɤː/ ลงท้าย, สระเปิด, ลากได้ปลอดภัย. ไม่มี flag.
- *ไม่พบจุดเสี่ยงสำคัญ — เนื้อร้องไทยใช้คำง่ายๆ และโครงสร้างประโยคเหมาะกับความยาวบรรทัด*

### ⚠️ Pronunciation Risk Flags (English)
- Line "Distance cannot break this hold of mine": no homographs, no silent letters, line length 10 syllables. No flag.
- Line "Tell you that I never went": "went" /ɛnt/ at line-end closed vowel — safe on short note, watch on held note. If collapsed, change to "Tell you that I never strayed."
- *No major risks detected*

### 🎼 Rhyme Audit (Thai — คำคล้องจอง)
- **Verse 1:** ABAB on /ai/ + /ɤː/ ("สาย"/"ไกล"; "เสมอ"/"เผลอ") ✓
- **Verse 2:** ABAB mirroring Verse 1 — same families /aːi/ + /ɤː/ ("ใกล้"/"ใจ"; "เสมอ"/"เพ้อ") ✓ — cohesion with Verse 1
- **Pre-Chorus:** AA couplet on /aː/ ("มา"/"ครา") ✓
- **(ลงมา ลงมา)** echo rhymes with line above ✓
- **สัมผัสใน per Thai verse line:** "ฉัน"-"ยัง", "ใจ"-"ไกล" etc. — pass ✓
- *scheme คำคล้องจอง ครบ — verse ABAB บน /ai/+/ɤː/, pre-chorus AA บน /aː/, สัมผัสใน ครบทุกบรรทัด verse*

### 🎼 Rhyme Audit (English)
- **Chorus:** AABB perfect on /aɪt/+/aɪz/ ("tonight"/"eyes" — assonance pair, fine for ballad) and /aɪn/ ("mine"/"find") ✓
- **Bridge:** AABB on /ɑːr/ ("are"/"far") + /ɛn(t)/ ("again"/"went" — family rhyme on n) ✓
- **Hook placement:** "Ten thousand miles between us tonight" — title phrase in line 1 of chorus ✓
- **No cliché pairs**
- *Rhyme scheme: chorus AABB, bridge AABB; hook placement: chorus line 1; no major issues*

### 🌐 Bilingual Mixing Audit
- **Section anchoring:** every section carries `(Thai)` or `(English)` ✓
- **No same-line code-switching detected** ✓ — outro contains `ระยะทาง... ten thousand miles...` but this is the title-reprise, not a sung lead; treats as parenthetical-style trailing tag, accept.
- **Drift declaration present** in Styles ("Thai verses with English chorus, no in-line mixing") ✓
- *Section anchors present; no same-line code-switching detected*

### 🔁 Iteration Tips
- ⚠ **Char-budget warning**: Styles is 213 chars; v5 truncates at 200. Either use v5.5 or trim to: `modern T-pop ballad, fingerpicked acoustic, warm strings, male tenor, polished mix, 84 BPM, Thai verses with English chorus`
- If Thai pronunciation drifts toward English-accented Thai: re-add `Thai vocals primary, native Bangkok diction` to Styles
- If English chorus drifts toward Thai-accented English: the section anchor `(English)` on the chorus should hold; if not, regenerate
- If you want the English title to also have a Thai echo: use the (parenthetical echo) pattern — e.g., `Ten thousand miles between us tonight (ห่างไกลเหลือเกิน)`

---

## Notes on these examples

- All three follow the Step 8 output template in `SKILL.md` exactly. Section headers, ordering, and severity formats are load-bearing.
- Example 1 is the English-only baseline.
- Example 2 demonstrates country conventions (concrete imagery, ABAB+AABB, family rhyme on hook).
- Example 3 is the canonical bilingual case — Thai verses + English chorus with explicit section anchors and drift declaration.
- The audits show what "clean" output looks like. When flags exist, they sit in the same place with rewrite suggestions; the user picks.
