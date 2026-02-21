#!/usr/bin/env bash

gcp_login(){
  ls
  gcloud auth activate-service-account --key-file=key.json --project=$TF_VAR_project_id
  echo "✅ GCP Service account login"
}