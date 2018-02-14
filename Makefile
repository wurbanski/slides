OUTPUT := _out

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
workdir := $(dir $(mkfile_path))

mogrify := mogrify -strip -interlace Plane -gaussian-blur 0.05 -quality 85

REVEAL_MD := $(workdir)/./node_modules/.bin/reveal-md
REVEAL_FLAGS := --static

SLIDES_DIR := slides
SRC_FILES := ${wildcard $(SLIDES_DIR)/*.md}

OUTFILES := ${patsubst $(SLIDES_DIR)/%.md,$(OUTPUT)/%/index.html,$(SRC_FILES)}

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

$(OUTPUT)/%/index.html: $(SLIDES_DIR)/%.md
	@(cd $(SLIDES_DIR); $(REVEAL_MD) --static $(workdir)${dir $@} --static-dirs images $(notdir $<) )

optimize_images: 
	@which mogrify && find $(workdir)$(OUTPUT) -type d -name images -exec $(mogrify) {}/*.jpg \; || echo "imagemagick not installed, skipping..."

serve:
	@$(REVEAL_MD) -w $(SLIDES_DIR) --theme white --highlight-theme ocean

