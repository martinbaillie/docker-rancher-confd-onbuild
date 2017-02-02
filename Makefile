IMAGE_NAME = martinbaillie/rancher-confd-onbuild
IMAGE_VERSION = latest
DOCKER_REGISTRY =

WORKING_DIR := $(shell pwd)

.PHONY: build tag push

release:: build tag push

push::
		@docker push $(DOCKER_REGISTRY)$(IMAGE_NAME):$(IMAGE_VERSION)

tag::
		@docker tag $(IMAGE_NAME) $(DOCKER_REGISTRY)$(IMAGE_NAME):$(IMAGE_VERSION)

build::
		@docker build --pull \
			--build-arg=http_proxy=${http_proxy} \
			--build-arg=https_proxy=${https_proxy} \
			--build-arg=no_proxy=${no_proxy} \
			-t $(IMAGE_NAME) $(WORKING_DIR)
