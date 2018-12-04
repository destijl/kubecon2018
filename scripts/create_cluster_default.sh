#!/bin/bash

# $Id: $

gcloud beta container clusters create kubecon2018 \
    --zone=us-west1-b
    --cluster-version=1.11.3-gke.18

