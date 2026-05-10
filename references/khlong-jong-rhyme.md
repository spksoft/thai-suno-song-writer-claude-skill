# คำคล้องจอง — Thai Rhyme & Rhythm for Song Lyrics

This document is the rhyme-craft reference for the skill. **Rhyme in Thai songs is not optional decoration — it is the structural skeleton that makes lyrics feel "ภาษาเพลง" (song-language) rather than "ภาษาพูด" (spoken text).** Suno will sing whatever you give it, but lyrics without proper คำคล้องจอง land flat: the listener perceives them as prose forced onto a melody, even when the meaning is good.

This file explains: (1) how Thai rhyme actually works phonetically, (2) the rhyme schemes that fit modern Thai pop sections, (3) how to compose with rhyme in mind, (4) a self-check the skill applies before output.

Per the skill's "warn, don't auto-fix" rule: when the user supplies their own lyrics, flag rhyme weaknesses and suggest fixes — do not silently rewrite.

## 1. The phonetic rule of Thai rhyme

Two Thai syllables **คล้องจอง** (rhyme) when:

1. **Same vowel sound** (พยัญชนะสระ identical, e.g. both /aː/, both /ɔː/, both /ɤː/), AND
2. **Same final consonant class** (มาตราตัวสะกด — see table below), OR both syllables are open (ไม่มีตัวสะกด, แม่ ก กา).

**Tone does not have to match.** This is the single most common mistake by non-native lyric writers: they avoid pairing words because the tone marks differ. In Thai rhyme, สามัญ/เอก/โท/ตรี/จัตวา on the same vowel + final all rhyme freely.

Examples that rhyme:
- ใจ (jai, mid) + ไป (pai, mid) + ไหน (nǎi, rising) + ไกล (klai, mid) — all /ai/ open ✓
- รัก (rák, high) + นัก (nák, high) + พัก (phák, high) + จัก (jàk, low) — all /a/ + /k/ ✓
- เธอ (thəː, mid) + เผลอ (phlɤː, rising) + เจอ (jɤː, mid) — all /ɤː/ open ✓
- หาย (hǎai, rising) + สาย (sǎai, rising) + ตาย (taai, mid) + ฝัน (fǎn... NO, different vowel/final) ✗

Examples that look like they rhyme but don't:
- รัก (/a/+/k/) ≠ ลัด (/a/+/t/) — same vowel, different final class
- ใจ (/ai/) ≠ หาย (/aːi/) — short vs. long vowel; tolerated in pop but not a strong rhyme
- ฝน (/o/+/n/) ≠ ฟ้า (/aː/ open) — different vowel and structure entirely

### มาตราตัวสะกด (final-consonant classes for rhyme)

| มาตรา | Sounds like | Examples |
|---|---|---|
| แม่ ก กา | open syllable, no final | มา, ดี, ใจ, เธอ, หู |
| แม่กก | -k stop | นัก, รัก, สุข, ลึก |
| แม่กด | -t stop | รัด, ปิด, จด, ฝืด |
| แม่กบ | -p stop | จบ, รับ, ลูบ, สงบ |
| แม่กง | -ŋ nasal | คง, รัง, ฟัง, สอง |
| แม่กน | -n nasal | กิน, ฝัน, จัน, นอน |
| แม่กม | -m nasal | ลม, ฝัน... no wait, ฝัน is แม่กน. Try: ตาม, นาม, ก้ม |
| แม่เกย | -j glide | ลอย, ใจ, เคย, เลย |
| แม่เกอว | -w glide | ดาว, แล้ว, รัว, เลว |

A syllable can only rhyme tightly within the same มาตรา. Cross-มาตรา attempts (e.g. ฟัง + ฟัน — แม่กง + แม่กน) fail; listeners hear them as "เกือบคล้อง" (almost-rhyme), which is worse than no rhyme.

### Long vs. short vowel — the gray zone

Modern Thai pop accepts these as loose rhymes:
- /a/ + /aː/ (รัก / มาก)
- /i/ + /iː/ (ปิด / กรีด)
- /u/ + /uː/

But for hook lines and chorus end-rhymes, **match length exactly**. A loose rhyme is fine in a verse; it is heard as sloppy in a chorus.

## 2. สัมผัสนอก vs. สัมผัสใน — the two rhyme axes

### สัมผัสนอก (external rhyme — between lines)

The end-of-line rhyme that gives a verse its scheme. Modern Thai pop uses three patterns:

| Scheme | Pattern | Where it fits |
|---|---|---|
| **AABB** | line 1 + line 2 rhyme; line 3 + line 4 rhyme | Chorus, simple verse, hook-heavy sections |
| **ABAB** | line 1 + line 3 rhyme; line 2 + line 4 rhyme | Verse, more "literary" feel |
| **AABA** | line 1, 2, 4 rhyme; line 3 is a "release" line | Pre-chorus that sets up a chorus |

You can also chain: line 4's last syllable becomes line 5's first/second syllable rhyme — this is the classic กลอนแปด เกี่ยวสัมผัส (interlocking) pattern. Modern pop uses it occasionally to make verses feel inevitable.

**Example: AABB chorus**
```
อยากบอกเธอว่ายังรัก  ← A: /ak/
อยากให้เธอกลับมาพัก  ← A: /ak/
ในใจของฉันยังเหมือนเดิม  ← B: /əːm/
ที่เคยอบอุ่นและเปรมปริ่ม  ← B: /im/ (loose with /əːm/, OK)
```

**Example: ABAB verse**
```
ในคืนที่ฟ้ามืดมัว    ← A: /ua/
ใจฉันยังคงคิดถึงเธอ  ← B: /ɤː/
ลมหนาวพัดผ่านเข้ามา  ← A: /aː/ (loose with /ua/)
ราวกับว่าเธอยังอยู่เผลอ  ← B: /ɤː/
```

### สัมผัสใน (internal rhyme — within a line)

Vowel echo or alliteration **within a single sung line**. This is what makes Thai lyrics feel musical at the syllable level. Two sub-types:

- **สัมผัสสระ (vowel echo):** two syllables in the same line share the same vowel.
  - "ใจ ที่ ไม่ มี ใคร" — /ai/ at positions 1, 5 + /iː/ at 3, 4
  - "หวาน ผ่าน กาล เวลา" — /aː/ at positions 1, 2, 3, 4 (heavy)
- **สัมผัสอักษร / สัมผัสพยัญชนะ (alliteration):** two syllables share the initial consonant sound.
  - "เธอ ทำ ให้ ฉัน" — /th/ + /th/ wait that's only เธอ-ทำ; reach further: "เธอ ทำ ทุก ที่" — /th/ at 1, 2, 3, 4
  - "ใจ จม จาก เจ้า" — /j/ at 1, 2, 4

A well-crafted Thai pop line typically has **at least one สัมผัสใน per line** — vowel echo OR alliteration, doesn't have to be both. Lines without any internal rhyme feel "เนื้อดิบ" (raw/unfinished) when sung.

**Bonus pattern: สัมผัสซ้อน (stacked internal rhyme)** — vowel echo + alliteration on the same word pair. Highest craft level. Used heavily in classic ลูกกรุง and modern art-pop.

- "ฝน ฟ้า ฟาด ใจ" — /f/ alliteration on ฝน-ฟ้า-ฟาด, plus /aː/ vowel on ฟ้า-ฟาด

## 3. กลอนแปด-inspired structure (the default Thai song verse)

Modern Thai pop is loosely descended from กลอนแปด. You don't need to follow it strictly — but understanding it explains why most good Thai songs feel the way they do.

A กลอนแปด stanza = 4 lines × 8 syllables (7–9 acceptable). Rhymes:

```
○ ○ ○ ○ ○ ○ ○ A         ← วรรคสดับ (line 1) — last syllable = A
○ ○ B ○ ○ A ○ B         ← วรรครับ (line 2) — A in middle, B at end
○ ○ ○ ○ ○ ○ ○ B         ← วรรครอง (line 3) — last syllable = B (matches line 2 end)
○ ○ C ○ ○ B ○ C         ← วรรคส่ง (line 4) — B in middle, C at end (C carries to next stanza)
```

Translated to "what to do when writing a Thai pop verse":

1. **Pick a rhyme word for line 1's end.** Call it A.
2. **In line 2:** put a word that rhymes with A somewhere in the middle (positions 3, 4, or 5). End line 2 with a new rhyme word B.
3. **End line 3 with another B-rhyme.** (B repeats: line 2 end + line 3 end.)
4. **In line 4:** put another B-rhyme in the middle, and end with a fresh word C. C is the anchor for the next stanza or pre-chorus.

This pattern is what makes Thai verses feel "เป็นเพลง" (song-like). Even if you don't hit it 100%, hitting 60% of these rhymes is the difference between mediocre and good Thai lyrics.

### Modern relaxations

- 6–10 syllables per line is fine (not strict 8).
- The internal rhymes in lines 2 and 4 are the most often skipped — the line-end rhymes are the ones that matter.
- Pre-chorus often breaks the scheme on purpose to create lift into the chorus.
- Chorus often abandons กลอนแปด entirely for AABB couplets that are easier to remember.

## 4. Rhyme strategies per song section

### Verse
- **Default:** AABB or ABAB end-rhyme. Add at least one สัมผัสใน per line.
- **Verse 1 and Verse 2 should share a rhyme family** (the same vowel sound at the end of analogous lines). This makes the song feel cohesive.
- Avoid using the chorus's hook rhyme in the verse — you want the chorus to feel like arrival, not repetition.

### Pre-Chorus
- **AABA or AAB** is common. The "release" line (different rhyme) creates lift.
- Pre-chorus often uses a different vowel family than the verse, signaling "something is changing."
- Tempo here often quickens; shorter words (4–6 syllables/line) work well.

### Chorus
- **AABB** is the safest, most singable. ABAB is also strong if the song is more ballad-y.
- **The hook line — usually line 1 or line 4 — must end in a strong rhyme word.** This is the word the listener will remember.
- The title of the song almost always appears at the end of the hook line, and the rhyme partner one or three lines away makes it memorable.
- **Internal rhyme density should be highest in the chorus** — at least one สัมผัสใน per line, ideally two.
- The (parenthetical echo) lines should rhyme with the line above them. "อยากบอกเธอว่ารัก (ว่ารัก ว่ารัก)" — the echo is the rhyme.

### Bridge
- Often deliberately breaks the rhyme scheme to signal contrast.
- Can be unrhymed prose-like text, or use a totally new rhyme family.
- Returns to the chorus rhyme family on its last line, to set up the final chorus.

## 5. Common Thai pop rhyme families (vowel groups to keep in mind)

These are the vowel + final combinations that show up most often in Thai pop because they carry strong emotion. Use them when you're stuck for a rhyme:

| Family | Vowel + Final | Common words |
|---|---|---|
| **ใจ-ไป-ไกล family** | /ai/ open (แม่ ก กา) | ใจ, ไป, ไหน, ไกล, ใคร, ใช่, ไหว, ใหม่, ได้ |
| **เธอ-เผลอ family** | /ɤː/ open | เธอ, เจอ, เผลอ, เพ้อ, เอ๋อ, เคอะ |
| **รัก-นัก family** | /a/ + /k/ (แม่กก) | รัก, นัก, พัก, จัก, มัก, สลัก, ภัค |
| **ฝัน-วัน family** | /a/ + /n/ (แม่กน) | ฝัน, วัน, จัน, หวัน, มั่น, นั่น, ผัน, ดั่น |
| **คืน-ฟื้น family** | /ɯː/ + /n/ (แม่กน) | คืน, ฟื้น, ตื่น, ขึ้น, ยืน, ฝืน, รื่น |
| **มา-ฟ้า family** | /aː/ open | มา, ฟ้า, หา, ตา, น้ำตา, เวลา, ดารา, ห่าง — careful: ห่าง is /aː/+/ŋ/ |
| **ดาว-เรา family** | /aw/ open (แม่เกอว) | ดาว, เรา, เก่า, เศร้า, เปล่า, เนา, สาว, หาว |
| **เดิน-เกิน family** | /ɤːn/ + /n/ (แม่กน with เ-ิน) | เดิน, เกิน, เหิน, เผิน |
| **หวัง-ดัง family** | /a/ + /ŋ/ (แม่กง) | หวัง, ดัง, ทั้ง, ฟัง, ครั้ง, สั่ง, ระวัง |

When picking a rhyme word, ask: "is this a family that can sustain 4–6 lines of variation, or am I going to run out of options?" Smaller families (เพ้อ-family) force forced word choices; large families (ใจ-family, มา-family) are reliable workhorses.

## 6. Anti-patterns to avoid

### ขัดสัมผัส (broken rhyme)
The line ends on a word that almost rhymes but is wrong (/aː/+/ŋ/ trying to pair with /aː/ open). The listener feels the pull toward rhyme then the disappointment.

**Fix:** either commit to the rhyme (find a true partner), or commit to NOT rhyming (end on something obviously different so the ear doesn't expect it).

### สัมผัสซ้ำคำเดียวกัน (rhyming with the identical word)
"ฉันรักเธอ / เธอก็รักเธอ" — using the same word as both rhyme partners. Sounds lazy unless used deliberately for emphasis.

**Fix:** vary the word, even if you keep the same vowel. ฉันรักเธอ / ฉันมีเพียงเธอ → swap second เธอ to "เผลอ" or "เจอ" if meaning allows.

### เพี้ยนสัมผัส (rhyme that breaks tonal-melodic alignment)
Picking a rhyme word whose tone mismatches the melodic contour Suno is likely to generate. Example: ending two lines on falling-tone words (โท) when both fall on long held notes — both will flatten and the rhyme disappears.

**Fix:** when designing the rhyme, prefer mid (สามัญ) or high (ตรี) tones for chorus end-rhymes — these survive Suno's rendering best. Save falling/rising for unstressed positions.

### สัมผัสเลื่อน (drifting rhyme)
Stanza 1 rhymes A-A-B-B with vowel /aː/. Stanza 2 rhymes A-A-B-B but with vowel /ɤː/. Each stanza is internally consistent but the song feels disconnected.

**Fix:** at least one rhyme family should carry across stanzas. Easiest place is the chorus end-rhyme — use the same vowel family every chorus.

### Forcing rhyme that destroys meaning
"ฉันรักเธอจนใจสลาย / มองเธอไปไกลในรถไถ" — "รถไถ" (tractor) ruins the emotional moment.

**Fix:** if you can't find a meaningful rhyme word, prefer a near-rhyme or an unrhymed line over an absurd one. Pop listeners forgive a missed rhyme; they don't forgive a tractor.

## 7. The rhyme audit checklist (used by the skill in Step 7)

When reviewing a finished set of lyrics, scan with these questions:

### Per chorus
1. **Does the hook line rhyme with its partner?** (Line 1 + line 2, OR line 1 + line 4 in AABB.)
2. **Does the title word fall on a rhyme position?**
3. **Are the (parens echoes) rhyming with the line above them?**
4. **At least one สัมผัสใน per line?** (vowel echo or alliteration)
5. **Same chorus repeated identically each time?** (per the Suno requirement)

### Per verse
6. **Is there an end-rhyme scheme (AABB / ABAB / AABA)?** If three or more line-ends are unrhymed in a 4-line verse, flag it.
7. **Does Verse 2 share at least one rhyme family with Verse 1?** (Cohesion check.)
8. **Are any two adjacent line-ends ขัดสัมผัส (almost-rhyming, wrong final)?** Flag these.

### Across the song
9. **Does the chorus rhyme family stay constant across all chorus repeats?**
10. **Is any vowel family overused** (>10 line-ends out of ~30 total)? Risks monotony.
11. **Forced rhymes** that break meaning? Suggest the meaningful alternative.

For each issue found, output in the same format as เพี้ยน flags:

```
- บรรทัด "...": [issue], แนะนำเปลี่ยนเป็น "..."
```

A song with **0–2 rhyme flags** is in good shape; **3–5** suggests the verse or one chorus needs a rewrite; **6+** suggests the lyrics were written without rhyme intent and should be redrafted.

## 8. Composition workflow (use this when writing fresh lyrics)

When composing from scratch, work in this order — do NOT write line-by-line top-to-bottom:

1. **Pick the hook (chorus) end-rhyme word first.** This is usually the title or the title-adjacent word. Call its vowel family F.
2. **Write the chorus.** All chorus end-rhymes draw from F. Use AABB.
3. **Pick a contrasting rhyme family G for the verse.** G should be different enough to feel like setup, similar enough to flow into F. (E.g., F = ใจ-family /ai/, G = เธอ-family /ɤː/ — emotionally close but vowel-distinct.)
4. **Write Verse 1 with G as end-rhyme.**
5. **Write Verse 2 mirroring Verse 1's rhyme positions** but with new content.
6. **Pick a "release" rhyme H for the pre-chorus.** H is typically a vowel that "wants" to resolve into F.
7. **Bridge: free.** Often deliberately unrhymed or in a fourth family that returns to F at the end.

This order ensures the chorus — the most important part of the song — has the strongest rhyme craft, because you committed to its scaffolding first.

## 9. When the user already has lyrics

If the user pasted their own lyrics (skipping Step 3 composition), the skill still runs the audit in Section 7 above. Flag rhyme issues alongside เพี้ยน flags. Always offer rewrite suggestions; never silently rewrite.

If the user's lyrics have systematic rhyme issues (e.g., no end-rhyme scheme at all), say so directly — "เนื้อร้องนี้ไม่มี scheme คำคล้องจอง อาจฟังเหมือนพูดมากกว่าเหมือนเพลง" — and offer to refactor on request, but wait for the user to ask before rewriting.

## 10. Worked example: building a chorus with คำคล้องจอง

Concept: เพลงรัก, ผู้หญิงร้อง, hook word = "ใจ"

**Step 1 — Pick the rhyme family.** Hook = "ใจ" → family is /ai/ open. Available partners: ไป, ไหน, ไกล, ใคร, ไหว, ได้, ใช่, ใหม่.

**Step 2 — Sketch AABB chorus end-words:**
```
line 1: ... ใจ      ← A1
line 2: ... ไป      ← A2 (rhymes with A1)
line 3: ... ไหน     ← B1 (new rhyme, but still /ai/ family — for cohesion)
line 4: ... ใจ      ← back to title — repeat for hook recall
```

Actually that's an AABA — and AABA with the title hammered at end is a classic hook shape. Keep it.

**Step 3 — Fill in lines, adding สัมผัสใน in each line:**
```
อยากบอกให้เธอเข้าใจ              ← /ai/ at "ให้" + "ใจ" (internal vowel echo on /ai/)
อยากให้เธอรู้ว่าฉันยังไป...       ← /ai/ at "ให้" + "ไป"  
ไม่ว่าเธอจะอยู่ที่ไหน              ← /ai/ at "ไม่" + "ไหน" (alliteration "ไ-" + vowel)
ฉันก็ยังเก็บเธอไว้ในใจ            ← /ai/ at "ไว้" + "ใน" + "ใจ" (triple internal)
```

**Step 4 — Audit:** 
- End rhyme AABA on /ai/ ✓
- Each line has 2+ /ai/ syllables ✓
- Title "ใจ" lands on hook position (line 4 end) ✓
- No forced/absurd rhymes ✓
- All end words are mid/high tone (no falling-tone collapse risk) ✓

This chorus will feel "เป็นเพลง" — that's the difference proper rhyme craft makes.
