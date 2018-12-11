provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region = "${var.region}"
}

module "vpc" {
  source = "../modules/vpc"

  source_ranges = [
    "0.0.0.0/0"
  ]
}

module "docker" {
  source = "../modules/docker"
  public_key_path = "${var.public_key_path}"
  zone = "${var.zone}"
  node_count = "${var.count}"
}
