#!/usr/bin/make -f

MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -c

ENV =? local

include mk/*.mk

init: check lint

start.kubernetes:
	./shell/start-kubernetes-cluster.sh

stop.kubernetes:
	minikube stop

delete.kubernetes:
	minikube delete

install.tillerless:
	./shell/install-tillerless.sh

deploy.collector:
	helm tiller run "default" -- helm upgrade "collector" ./charts/snowplow-scala-stream-collector-kafka \
		--namespace "default" \
		--install \
		--force \
		--wait \
		--timeout 600

deploy.enricher:
	helm tiller run "default" -- helm upgrade "enricher" ./charts/snowplow-stream-enrich-kafka/ \
		--namespace "default" \
		--install \
		--force \
		--wait \
		--timeout 600

deploy.kafka:
	./shell/install-kafka.sh

deploy: start.kubernetes install.tillerless
	$(MAKE) deploy.kafka
	$(MAKE) create.kafka-topics
	$(MAKE) deploy.collector
	$(MAKE) deploy.enricher

create.kafka-topics:
	kubectl cp shell/create-kafka-topics.sh kafka-cp-kafka-0:/tmp/create-kafka-topics.sh
	kubectl exec -it kafka-cp-kafka-0 -- bash /tmp/create-kafka-topics.sh