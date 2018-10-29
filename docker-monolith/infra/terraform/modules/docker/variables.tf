variable node_count {
  description = "Number of instances"
  default     = "1"
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
  default     = "n1-standard-1"
}
