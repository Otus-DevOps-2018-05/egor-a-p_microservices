resource "google_compute_firewall" "firewall_ssh" {
  name = "default-allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "22"
    ]
  }

  source_ranges = "${var.source_ranges}"
  target_tags = ["docker"]
}

resource "google_compute_firewall" "firewall_reddit" {
  name = "default-allow-reddit"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "9292"
    ]
  }

  source_ranges = "${var.source_ranges}"
  target_tags = ["docker"]
}

resource "google_compute_firewall" "firewall_docker" {
  name = "default-allow-docker"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "2375",
      "2376"
    ]
  }

  source_ranges = "${var.source_ranges}"
  target_tags = ["docker"]
}
