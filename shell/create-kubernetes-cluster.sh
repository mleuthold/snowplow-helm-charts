#!/usr/bin/env bash

set -xe

MY_TEMP_DIR="target"

# https://github.com/kubernetes-sigs/kubeadm-dind-cluster

mkdir -p ${MY_TEMP_DIR}

if ! echo ${MY_TEMP_DIR}/dind-cluster-v1.13.sh;
then
	wget https://github.com/kubernetes-sigs/kubeadm-dind-cluster/releases/download/v0.1.0/dind-cluster-v1.13.sh --directory-prefix=./${MY_TEMP_DIR}/;
fi
chmod +x ./target/dind-cluster-v1.13.sh

# start the cluster
./${MY_TEMP_DIR}/dind-cluster-v1.13.sh up