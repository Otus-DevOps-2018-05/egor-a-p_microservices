provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region = "${var.region}"
}

resource "google_compute_instance" "gitlab" {
  name = "gitlab"
  machine_type = "${var.machine_type}"
  zone = "${var.zone}"
  tags = ["gitlab"]

  boot_disk {
    initialize_params {
      image = "docker-base"
      type = "pd-ssd"
      size = 50
    }
  }

  network_interface {
    network = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_docker" {
  name = "gitlab-allow-docker"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "2375",
      "2376"
    ]
  }

  source_ranges = "${var.source_ranges}"
  target_tags = ["gitlab"]
}

resource "google_compute_firewall" "firewall_ssh" {
  name = "gitlab-allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "22"
    ]
  }

  source_ranges = "${var.source_ranges}"
  target_tags = ["gitlab"]
}

resource "google_compute_firewall" "firewall_http" {
  name = "gitlab-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "80",
      "443"
    ]
  }

  source_ranges = "${var.source_ranges}"
  target_tags = ["gitlab"]
}

