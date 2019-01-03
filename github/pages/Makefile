include ../../docker.mk
include ../../help.mk
include ../../shell.mk

IMAGE_NAME=hugo-build

.PHONY: clean
clean: ## Clean up after the build process.

.PHONY: lint
lint: shell-lint docker-lint ## Lint all of the files for this Action.

.PHONY: test
test: shell-test ## Test the components of this Action.

.PHONY: build
build: docker-build ## Build this Action.