#!/usr/bin/env bash
export GOOGLE_APPLICATION_CREDENTIALS="key.json"

gcp_login(){
  gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS --project=$TF_VAR_project_id
  echo "✅ GCP Service account login"
}

gcp_bucket(){
  gcloud storage cp functions.zip gs://$TF_VAR_bucket_name/functions/$GITHUB_REPOSITORY_NAME-$GITHUB_REF_NAME.zip
  echo "✅ GCP push zip to bucket"
}