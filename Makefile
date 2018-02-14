OUTPUT := _out

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
WORKDIR := $(dir $(mkfile_path))

mogrify := mogrify -strip -interlace Plane -gaussian-blur 0.05 -quality 85

REVEAL_MD := $(WORKDIR)/node_modules/.bin/reveal-md
REVEAL_THEME := white
HIGHLIGHT_THEME := ocean

SLIDES_DIR := decks

SRC_FILES := ${wildcard $(SLIDES_DIR)/*/slides.md}
OUTFILES := ${patsubst $(SLIDES_DIR)/%/slides.md,$(OUTPUT)/%/index.html,$(SRC_FILES)}

.PHONY: all slides index clean

all: slides index

__create:
	@if [ ! -d $(OUTPUT) ]; then echo "Creating output directory: $(OUTPUT)"; mkdir -p $(OUTPUT); fi

clean:
	@test ! -d $(OUTPUT) || rm -rf $(OUTPUT)

index: __create slides $(OUTPUT)/index.html

$(OUTPUT)/index.html: generate_index.py
	@./generate_index.py $(SLIDES_DIR)
	@mv index.html $(OUTPUT)/

slides: __create $(OUTFILES) optimize_images

$(OUTPUT)/%/index.html: $(SLIDES_DIR)/%/slides.md
	(cd $(dir $<); $(REVEAL_MD) --static $(WORKDIR)${dir $@} --static-dirs images $(notdir $<) )

optimize_images: 
	@which mogrify >/dev/null && find $(WORKDIR)$(OUTPUT) -type d -name images -exec $(mogrify) {}/*.jpg \; || echo "imagemagick not installed, skipping..."

serve:
	@$(REVEAL_MD) -w $(SLIDES_DIR) --theme $(REVEAL_THEME) --highlight-theme $(HIGHLIGHT_THEME)

