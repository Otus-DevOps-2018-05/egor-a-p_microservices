USER_NAME = egorapetrov
GOOGLE_PROJECT = docker-218307
INSTANCE=docker-host

.PHONY: host_up host_down build build_ui build_comment build_post build_prometheus push_ui push_comment push_post push_prometheus up down

init:
	export GOOGLE_PROJECT=$(GOOGLE_PROJECT) \
    && export USER_NAME=$(USER_NAME)

set_env:
	eval $$(docker-machine env $(INSTANCE))

host_up: init
	docker-machine create --driver google \
           --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
           --google-machine-type n1-standard-1 \
           --google-zone europe-north1-c $(INSTANCE)

host_down:
	docker-machine rm $(INSTANCE) -f

build: build_ui build_comment build_post build_prometheus

build_ui:
	eval $$(docker-machine env $(INSTANCE)) && cd src/ui && bash docker_build.sh

build_comment:
	eval $$(docker-machine env $(INSTANCE)) && cd src/comment && bash docker_build.sh

build_post:
	eval $$(docker-machine env $(INSTANCE)) && cd src/post-py && bash docker_build.sh

build_prometheus:
	eval $$(docker-machine env $(INSTANCE)) && docker build -t $(USER_NAME)/prometheus monitoring/prometheus

push: push_ui push_comment push_post push_prometheus

push_ui:
	eval $$(docker-machine env $(INSTANCE)) && docker push $(USER_NAME)/ui

push_comment:
	eval $$(docker-machine env $(INSTANCE)) && docker push $(USER_NAME)/comment

push_post:
	eval $$(docker-machine env $(INSTANCE)) && docker push $(USER_NAME)/post

push_prometheus:
	eval $$(docker-machine env $(INSTANCE)) && docker push $(USER_NAME)/prometheus

up:
	eval $$(docker-machine env $(INSTANCE)) && cd docker && docker-compose -f docker-compose.yml -f docker-compose-monitoring.yml up -d

down:
	eval $$(docker-machine env $(INSTANCE)) && cd docker && docker-compose -f docker-compose.yml -f docker-compose-monitoring.yml down

