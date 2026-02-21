#!/usr/bin/env bash

gcp_login(){
  ls
  gcloud auth activate-service-account --key-file=key.json --project=$TF_VAR_project_id
  echo "✅ GCP Service account login"
}

gcp_bucket(){
  gcloud storage cp functions.zip gs://$TF_VAR_bucket_name/$GITHUB_REPOSITORY_NAME-$GITHUB_REF_NAME/functions.zip
  echo "✅ GCP push zip to bucket"
}