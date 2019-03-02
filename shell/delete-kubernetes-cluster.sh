#!/usr/bin/env bash

set -xe

MY_TEMP_DIR="target"

# remove DIND containers and volumes
./${MY_TEMP_DIR}/dind-cluster-v1.13.sh clean