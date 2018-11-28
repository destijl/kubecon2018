#!/bin/bash

# $Id: $

DEMOMAGIC="demomagic.sh"

if [ ! -f $DEMOMAGIC ]; then
  wget -q https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh 
fi

. demo-magic.sh -d

p "curl -X POST -H \"Content-Type: application/json\" -d '{\"access_token\":ya29.c...}' https://www.googleapis.com/oauth2/v2/tokeninfo"

# Print output to save token handling
#curl -X POST -H "Content-Type: application/json" -d '{"access_token":"ya29.c...}' https://www.googleapis.com/oauth2/v2/tokeninfo

cat << EOF
{
  "issued_to": "112061657786725890568",
  "audience": "112061657786725890568",
  "scope": "https://www.googleapis.com/auth/trace.append https://www.googleapis.com/auth/service.management.readonly https://www.googleapis.com/auth/servicecontrol https://www.googleapis.com/auth/logging.write https://www.googleapis.com/auth/monitoring https://www.googleapis.com/auth/devstorage.read_only",
  "expires_in": 2439,
  "access_type": "offline"
}
EOF

