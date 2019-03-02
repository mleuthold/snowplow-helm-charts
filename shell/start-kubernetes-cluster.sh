#!/usr/bin/env bash

minikube start

kubectl config use-context minikube

echo "apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-limit-range
spec:
  limits:
  - default:
      cpu: 250m
      memory: 512Mi
    defaultRequest:
      cpu: 100m
      memory: 128Mi
    type: Container" | kubectl apply -f -
