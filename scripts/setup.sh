#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}
CLUSTER="kubecon2018"

export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)

gcloud container clusters get-credentials ${CLUSTER} --zone=${ZONE} --project=${PROJECT}

cd ../screenshot
make push
cd ../manifests
kubectl delete deployment screenshot || true
kubectl delete deployment newnx || true
kubectl delete deployment exchange || true
kubectl apply -f screenshot.yaml
kubectl apply -f kubelet-cluster-admin-role-binding.yaml
kubectl create namespace exchange
kubectl apply -n exchange -f exchange.yaml 

CLUSTER="kubecon2018-hardened"
export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)

gcloud container clusters get-credentials ${CLUSTER} --zone=${ZONE} --project=${PROJECT}

cd ../manifests
kubectl delete deployment screenshot || true
kubectl delete deployment exchange || true
kubectl apply -f screenshot.yaml
kubectl create namespace exchange
kubectl apply -n exchange -f exchange.yaml 

