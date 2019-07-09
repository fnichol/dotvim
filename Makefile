VIM_SOURCES := $(shell find . -type f -name '*.vim' -o -name '.vimrc')
CHECK_TOOLS += vint

include vendor/mk/base.mk

build:
.PHONY: build

clean:
.PHONY: clean

check: checktools vint ## Checks all linting, styling, & other rules
.PHONY: check

vint: ## Checks Vim scripts for linting rules
	@echo "--- $@"
	vint --color $(VIM_SOURCES)
.PHONY: vint

test:
.PHONY: test

update-toc: ## Update README.md table of contents
	markdown-toc -i README.md
.PHONY: update-toc
