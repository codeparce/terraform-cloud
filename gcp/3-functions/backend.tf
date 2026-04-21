terraform {
  backend "gcs" {
    bucket = "code-parce-tfstate"
  }
}
