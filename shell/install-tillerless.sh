#!/usr/bin/env bash

set -xe

helm init --client-only

# install tillerless
if ! helm plugin list | grep "^tiller[[:space:]]";
then
    helm plugin install https://github.com/rimusz/helm-tiller
fi
