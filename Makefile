VIM_SRC := $(shell find . -type f -name '*.vim' -o -name '.vimrc')
CHECK_TOOLS = vint

prepush: check ## Runs all checks/test required before pushing
	@echo "--- $@"
	@echo "all prepush targets passed, okay to push."
.PHONY: prepush

check: check-tools vint ## Checks all linting, styling, & other rules
.PHONY: check

vint: ## Checks Vim scripts for linting rules
	@echo "--- $@"
	vint --color $(VIM_SRC)
.PHONY: vint

check-tools:
	@echo "--- $@"
	$(foreach tool, $(CHECK_TOOLS), $(if $(shell which $(tool)),, \
		$(error "Required tool '$(tool)' not found on PATH")))
.PHONY: check-tools

update-toc: ## Update README.md table of contents
	markdown-toc -i README.md
.PHONY: update-toc

help: ## Prints help information
	@printf -- "\033[1;36;40mmake %s\033[0m\n" "$@"
	@echo
	@echo "USAGE:"
	@echo "    make [TARGET]"
	@echo
	@echo "TARGETS:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk '\
		BEGIN {FS = ":.*?## "}; \
		{printf "    \033[1;36;40m%-12s\033[0m %s\n", $$1, $$2}'
.PHONY: help
