OUTPUT := _out

REVEAL_MD := ./node_modules/.bin/reveal-md
REVEAL_FLAGS := --static

SLIDES_DIR := slides
SRC_FILES := ${wildcard $(SLIDES_DIR)/*.md}

OUTFILES := ${patsubst $(SLIDES_DIR)/%.md,$(OUTPUT)/%/index.html,$(SRC_FILES)}

.PHONY: all slides index clean

all: slides index

clean:
	@test -d $(OUTPUT) && rm -rf $(OUTPUT)

index: $(OUTPUT)/index.html

$(OUTPUT)/index.html: generate_index.py
	./generate_index.py

slides: $(OUTFILES)

$(OUTPUT)/%/index.html: $(SLIDES_DIR)/%.md
	$(REVEAL_MD) $(REVEAL_FLAGS) ${dir $@} $<
