IMAGE_NAME=$(shell basename $(CURDIR))

.PHONY: docker-lint
docker-lint: ## Run Dockerfile Lint on all dockerfiles.
	dockerfile_lint -r $(ROOT_DIR)/.dockerfile_lint/github_actions.yaml $(wildcard Dockerfile* */Dockerfile*)

.PHONY: docker-build
docker-build: ## Build the top level Dockerfile using the directory or $IMAGE_NAME as the name.
	docker build --build-arg HELM_VERSION=$(HELM_VERSION) -t $(IMAGE_NAME) .

.PHONY: docker-tag
docker-tag: ## Tag the docker image using the tag script.
	docker tag $(IMAGE_NAME) $(DOCKER_REPO)/helm-packager:$(HELM_VERSION)

.PHONY: docker-publish
docker-publish: docker-tag ## Publish the image and tags to a repository.
	docker push $(DOCKER_REPO)/helm-packager:$(HELM_VERSION)