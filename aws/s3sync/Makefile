include ../../docker.mk
include ../../help.mk
include ../../shell.mk

.PHONY: clean
clean: ## Clean up after the build process.

.PHONY: lint
lint: shell-lint docker-lint ## Lint all of the files for this Action.

.PHONY: test
test: shell-test ## Test the components of this Action.
