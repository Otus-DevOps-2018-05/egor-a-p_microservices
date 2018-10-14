resource "google_compute_instance" "docker" {
  count = "${var.node_count}"
  name = "docker-${count.index}"
  machine_type = "${var.machine_type}"
  zone = "${var.zone}"
  tags = ["docker"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
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
