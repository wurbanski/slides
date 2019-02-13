mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
WORKDIR := $(dir $(mkfile_path))

REVEAL_MD := npx reveal-md
REVEAL_THEME := white
HIGHLIGHT_THEME := ocean

SLIDES_DIR := decks
OUTPUT := _out

SRC_FILES := ${wildcard $(SLIDES_DIR)/*/slides.md}
OUTFILES := ${patsubst $(SLIDES_DIR)/%/slides.md,$(OUTPUT)/%/index.html,$(SRC_FILES)}

MOGRIFY := mogrify -strip -interlace Plane -gaussian-blur 0.05 -quality 85

.PHONY: all slides index clean

all: slides index $(WORKDIR)$(OUTPUT)/.optimized

clean:
	@test ! -d $(OUTPUT) || rm -rf $(OUTPUT)

index: $(OUTPUT) $(OUTPUT)/index.html

slides: $(OUTPUT) $(OUTFILES)

serve:
	@(cd $(SLIDES_DIR); $(REVEAL_MD) --theme $(REVEAL_THEME) --highlight-theme $(HIGHLIGHT_THEME))

# Output directory
$(OUTPUT):
	$(info creating $(OUTPUT))
	@mkdir -p $(OUTPUT)

# Index file
$(OUTPUT)/index.html: generate_index.py
	@./generate_index.py $(SLIDES_DIR)
	@mv index.html $(OUTPUT)/

# index per-slidedeck
$(OUTPUT)/%/index.html: $(SLIDES_DIR)/%/slides.md
	@(sed -r -e '/^Note:/,/^----?$$/{//!d}' -e '/^Note:/d' $< > $<.stripped; \
		cd $(dir $<); \
		$(REVEAL_MD) --static $(WORKDIR)${dir $@} --static-dirs images $(notdir $<).stripped\
	)

# Image optimization before publishing
$(WORKDIR)$(OUTPUT)/.optimized: $(OUTPUT) slides
	$(info Optimizing images...)
	@which mogrify >/dev/null && find $(WORKDIR)$(OUTPUT) -type d -name images -exec $(MOGRIFY) {}/*.jpg \; || echo "imagemagick not installed, skipping."
	@touch $(WORKDIR)$(OUTPUT)/.optimized

