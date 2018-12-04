#!/bin/bash

# $Id: $

gcloud beta container clusters create kubecon2018-hardened \
    --zone=us-west1-b
    --metadata disable-legacy-endpoints=true \
    --workload-metadata-from-node=SECURE \
    --cluster-version=1.11.3-gke.18

