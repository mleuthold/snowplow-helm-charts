#!/usr/bin/env bash

set -xe

export HELM_TILLER_SILENT=true

NAMESPACE="${MY_KUBERNETES_NAMESPACE:-default}"

helm init --client-only

# install tillerless
if ! helm plugin list | grep "^tiller[[:space:]]";
then
    helm plugin install https://github.com/rimusz/helm-tiller
fi
