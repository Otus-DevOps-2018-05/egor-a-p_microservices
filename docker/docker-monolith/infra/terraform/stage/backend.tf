terraform {
  backend "gcs" {
    bucket = "storage-bucket-docker-terraform"
    prefix = "terraform/tfstate/stage"
  }
}
