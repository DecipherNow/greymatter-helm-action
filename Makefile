export ROOT_DIR=$(CURDIR)
export DOCKER_REPO=deciphernow
export HELM_VERSION=v3.1.1

include ./docker.mk
include ./help.mk
include ./shell.mk

.PHONY: clean
clean: ## Clean up after the build process.

.PHONY: lint
lint: docker-lint shell-lint #docker-lint ## Lint all of the files for this Action.

.PHONY: build
build: docker-build ## Build this Action.

.PHONY: test
test: ## Test the components of this Action.

.PHONY: publish
publish: docker-publish ## Publish this Action.
