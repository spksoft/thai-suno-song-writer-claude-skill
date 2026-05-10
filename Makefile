SKILL_NAME := thai-suno-songwriter
DIST_DIR   := dist
STAGE_DIR  := $(DIST_DIR)/$(SKILL_NAME)
SKILL_FILE := $(DIST_DIR)/$(SKILL_NAME).skill
INSTALL_DIR := $(HOME)/.claude/skills

.PHONY: all build validate install clean

all: build

validate:
	@test -f SKILL.md || { echo "error: SKILL.md not found"; exit 1; }
	@head -n 1 SKILL.md | grep -q '^---$$' || { echo "error: SKILL.md is missing YAML frontmatter (first line must be '---')"; exit 1; }
	@test -d references || { echo "error: references/ directory not found"; exit 1; }

build: validate
	@rm -rf $(STAGE_DIR) $(SKILL_FILE)
	@mkdir -p $(STAGE_DIR)
	@cp SKILL.md $(STAGE_DIR)/
	@cp -R references $(STAGE_DIR)/
	@cd $(DIST_DIR) && zip -r -X -q $(SKILL_NAME).skill $(SKILL_NAME)
	@rm -rf $(STAGE_DIR)
	@echo "built: $(SKILL_FILE)"

install: build
	@mkdir -p $(INSTALL_DIR)
	@rm -rf $(INSTALL_DIR)/$(SKILL_NAME)
	@unzip -q $(SKILL_FILE) -d $(INSTALL_DIR)
	@echo "installed: $(INSTALL_DIR)/$(SKILL_NAME)"

clean:
	@rm -rf $(DIST_DIR)
	@echo "cleaned: $(DIST_DIR)"
