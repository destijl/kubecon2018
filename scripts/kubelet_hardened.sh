#!/bin/bash

# $Id: $

set -o errexit
set -o nounset
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}
: ${CLUSTER:="kubecon2018-hardened"}

DEMOMAGIC="demo-magic.sh"

if [ ! -f $DEMOMAGIC ]; then
  wget -q https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh 
fi

. demo-magic.sh -d

# empty kubeconfig to make sure we're acting as the kubelet
export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)
pe "kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 get pods --all-namespaces" || true
pe "kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 -n default get pods"
pe "kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 run newnx --image=nginx"
pe "kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 get secrets" || true
pe "kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 auth can-i create certificatesigningrequests"


