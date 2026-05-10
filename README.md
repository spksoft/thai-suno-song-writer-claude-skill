# Thai Suno Songwriter

> Claude skill ที่ช่วยสร้าง prompt ครบชุดสำหรับ Suno AI ให้แต่งเพลงไทย (และไทย-อังกฤษ) ได้ในคำสั่งเดียว
> A Claude skill that produces complete Suno AI prompts for Thai-language songs (and Thai/English code-switching) in one shot.

[ภาษาไทย](#-ภาษาไทย) · [English](#-english)

---

## 🇹🇭 ภาษาไทย

### มันคืออะไร

Skill สำหรับ Claude ที่ให้คุณบอก concept สั้น ๆ แล้วได้ชุด prompt ครบชุดสำหรับ Suno Custom Mode — Lyrics + Styles + Title + Vocal Gender + Weirdness + Style Influence — copy ลงทุกช่องแล้วกด Create ได้ทันที เน้นคุณภาพเพลงไทย/T-pop/Thai rock มี checklist เช็คความเสี่ยงออกเสียงเพี้ยนก่อน generate

### ติดตั้งยังไง

**ทางเลือกที่ 1 — Claude Code (เครื่องตัวเอง):**

1. โหลดไฟล์ `thai-suno-songwriter.skill` ล่าสุดจากหน้า [Releases](https://github.com/USER/REPO/releases/latest) (เปลี่ยน `USER/REPO` เป็น path จริงของคุณ)
2. แตกไฟล์เข้าโฟลเดอร์ skills ของ Claude:
   ```bash
   unzip thai-suno-songwriter.skill -d ~/.claude/skills/
   ```
3. เปิด Claude Code session ใหม่ — skill จะถูกโหลดอัตโนมัติ

**ทางเลือกที่ 2 — Claude.ai เว็บ:**

อัปโหลดไฟล์ `thai-suno-songwriter.skill` ผ่านหน้า Skills ใน Settings (ไฟล์ `.skill` คือไฟล์ zip ที่เปลี่ยนนามสกุล — ถ้าหน้าเว็บไม่รับ ให้เปลี่ยนชื่อเป็น `.zip` ก่อน)

**Windows:** ใช้โปรแกรมแตกไฟล์ใด ๆ (7-Zip, WinRAR) แตกไปที่ `%USERPROFILE%\.claude\skills\`

### วิธีใช้

ทักหา Claude เป็นภาษาไทยอะไรก็ได้ที่เกี่ยวกับ Suno เช่น:

- "ช่วยแต่งเพลง suno"
- "อยากทำเพลงไทยด้วย AI"
- "เขียน prompt สำหรับ suno ให้หน่อย"

Skill จะถามข้อมูลเพลงทีละขั้น (หัวข้อ อารมณ์ แนว ภาษา เพศนักร้อง ความยาว) แล้วผลิต prompt ครบชุดออกมา

### Build จากต้นทาง

```bash
make build           # สร้างไฟล์ dist/thai-suno-songwriter.skill
make install         # ติดตั้งเข้า ~/.claude/skills/ ทันที
make clean           # ลบโฟลเดอร์ dist/
```

ต้องการแค่ `zip` กับ `make` เท่านั้น (มาในตัวอยู่แล้วบน macOS/Linux)

---

## 🇬🇧 English

### What it is

A Claude skill that turns a short song concept into a complete, ready-to-paste Suno Custom Mode prompt — Lyrics + Styles + Title + Vocal Gender + Weirdness + Style Influence. Tuned for Thai pop/rock conventions, with a built-in mispronunciation (เพี้ยน) risk checklist applied before you generate.

### Install

**Option 1 — Claude Code (local):**

1. Download the latest `thai-suno-songwriter.skill` from the [Releases page](https://github.com/USER/REPO/releases/latest) (replace `USER/REPO` with your actual path).
2. Extract into your Claude skills directory:
   ```bash
   unzip thai-suno-songwriter.skill -d ~/.claude/skills/
   ```
3. Start a new Claude Code session — the skill loads automatically.

**Option 2 — Claude.ai web:**

Upload `thai-suno-songwriter.skill` via the Skills section in Settings. (`.skill` is just a renamed zip — if the web UI rejects the extension, rename to `.zip` first.)

**Windows:** Use any unzip tool (7-Zip, WinRAR) to extract into `%USERPROFILE%\.claude\skills\`.

### Usage

Talk to Claude in Thai (or mention Suno explicitly), for example:

- `ช่วยแต่งเพลง suno`
- `make a Thai song with Suno`
- `write a suno prompt for a Thai pop ballad`

The skill walks you through the concept (topic, mood, genre, language mix, vocal gender, length) and produces the full prompt set.

### Build from source

```bash
make build           # build dist/thai-suno-songwriter.skill
make install         # install to ~/.claude/skills/
make clean           # remove dist/
```

Only `zip` and `make` are required (preinstalled on macOS/Linux).

---

## How releases work

Every push to `main` triggers `.github/workflows/release.yml`, which rebuilds the skill and updates a rolling **`latest`** release. The `.skill` asset on that release always reflects the latest commit on `main`.

## License

MIT — see the skill content itself for usage notes.
