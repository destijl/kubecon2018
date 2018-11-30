#!/bin/bash

# $Id: $

gcloud beta container clusters create kubecon2018-hardened \
    --metadata disable-legacy-endpoints=true \
    --workload-metadata-from-node=SECURE \
    --cluster-version=1.11.3-gke.18

