#!/bin/bash

# $Id: $

set -o errexit
set -o nounset
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}
: ${CLUSTER:="kubecon2018"}

DEMOMAGIC="demo-magic.sh"

if [ ! -f $DEMOMAGIC ]; then
  wget -q https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh 
fi

. demo-magic.sh -d

p "curl -X POST -H \"Content-Type: application/json\" -d '{\"access_token\":ya29.c...}' https://www.googleapis.com/oauth2/v2/tokeninfo"

# Print output to save token handling
#curl -X POST -H "Content-Type: application/json" -d '{"access_token":"ya29.c...}' https://www.googleapis.com/oauth2/v2/tokeninfo

# Not sure this is worth demonstrating, cover in the slide.
#cat << EOF
#{
#  "issued_to": "112061657786725890568",
#  "audience": "112061657786725890568",
#  "scope": "https://www.googleapis.com/auth/trace.append https://www.googleapis.com/auth/service.management.readonly https://www.googleapis.com/auth/servicecontrol https://www.googleapis.com/auth/logging.write https://www.googleapis.com/auth/monitoring https://www.googleapis.com/auth/devstorage.read_only",
#  "expires_in": 2439,
#  "access_type": "offline"
#}
#EOF

# empty kubeconfig to make sure we're acting as the kubelet
export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)
pe "kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 get pods --all-namespaces" || true
pe "kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 -n default get pods"
pe "kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 run newnx --image=nginx"
pe "kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 get secrets" || true
pe "kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 auth can-i create certificatesigningrequests"


