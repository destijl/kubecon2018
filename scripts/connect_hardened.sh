#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

: ${PROJECT:="gcastle-gke-dev"}
: ${ZONE:="us-west1-b"}
: ${CLUSTER:="kubecon2018-hardened"}

export KUBECONFIG=$(mktemp /tmp/kubeconfig.XXXXXX)

gcloud container clusters get-credentials ${CLUSTER} --zone=${ZONE} --project=${PROJECT}

# Port-forward signup pod to localhost:8080
POD=$(kubectl get pods --selector=app=screenshot --output=jsonpath={.items..metadata.name})
if [[ -z "${POD}" ]]; then
  echo "screenshot pod not found. Is the deployment still creating?"
  exit 1
fi
kubectl exec -it ${POD} -- /bin/bash
