#!/usr/bin/env bash

helm repo add confluentinc https://confluentinc.github.io/cp-helm-charts/
#helm repo update

helm tiller run "default" -- helm upgrade "kafka" confluentinc/cp-helm-charts \
	--namespace "default" \
	--install \
	--force \
	--wait \
	--timeout 600 \
	-f shell/kafka-values.yaml
