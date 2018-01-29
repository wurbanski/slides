OUTPUT := _out

REVEAL_MD := ./node_modules/.bin/reveal-md
REVEAL_FLAGS := --static

SLIDES_DIR := slides
SRC_FILES := ${wildcard $(SLIDES_DIR)/*.md}

OUTFILES := ${patsubst $(SLIDES_DIR)/%.md,$(OUTPUT)/%/index.html,$(SRC_FILES)}

.PHONY: all slides

all: slides

slides: $(OUTFILES)

$(OUTPUT)/%/index.html: $(SLIDES_DIR)/%.md
	$(REVEAL_MD) $(REVEAL_FLAGS) ${dir $@} $<
