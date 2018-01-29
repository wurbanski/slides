REVEAL_MD := ./node_modules/.bin/reveal-md
REVEAL_FLAGS := --static _out/
ROOT_DIRECTORY = .
DIRS := ${sort ${dir ${wildcard ${ROOT_DIRECTORY}/slides/*/}}}

.PHONY: list $(DIRS)

install:
	@npm install

$(DIRS):
	$(info $@)
	@mkdir -p _out/$@
	$(REVEAL_MD) $(REVEAL_FLAGS)$@ $@

list: $(DIRS)
	@ tree _out
