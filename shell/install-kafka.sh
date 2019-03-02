#!/usr/bin/env bash

helm repo add confluentinc https://confluentinc.github.io/cp-helm-charts/
#helm repo update

helm tiller run "default" -- helm upgrade --install --wait --timeout 300 --namespace "default" "kafka" confluentinc/cp-helm-charts -f shell/kafka-values.yaml
