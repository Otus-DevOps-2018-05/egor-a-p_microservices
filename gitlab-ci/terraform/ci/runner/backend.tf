terraform {
  backend "gcs" {
    bucket = "storage-bucket-gitlab-terraform"
    prefix = "terraform/tfstate/runner"
  }
}
