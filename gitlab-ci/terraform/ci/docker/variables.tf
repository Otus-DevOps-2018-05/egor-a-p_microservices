variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable disk_image {
  description = "Disk image for docker"
  default     = "docker-base"
}

variable zone {
  description = "Zone"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable machine_type {
  description = "Type of google instance"
  default     = "n1-standard-2"
}

variable source_ranges {
  type        = "list"
  description = "Allowed IP addresses"

  default = [
    "0.0.0.0/0"
  ]
}
