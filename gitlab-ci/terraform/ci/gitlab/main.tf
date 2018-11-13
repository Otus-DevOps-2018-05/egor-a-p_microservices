provider "docker" {
  host = "tcp://${var.docker_host_ip}:2376"
}

resource "docker_image" "gitlab" {
  name = "gitlab/gitlab-ce:latest"
}

resource "docker_container" "gitlab" {
  image = "${docker_image.gitlab.latest}"
  name = "gitlab"

  env = [
    "GITLAB_OMNIBUS_CONFIG=external_url 'http://${var.docker_host_ip}'"
  ]

  ports {
    internal = 80
    external = 80
  }
  ports {
    internal = 443
    external = 443
  }
  ports {
    internal = 22
    external = 2222
  }
  volumes {
    host_path = "/srv/gitlab/config"
    container_path = "/etc/gitlab"
  }
  volumes {
    host_path = "/srv/gitlab/logs"
    container_path = "/var/log/gitlab"
  }
  volumes {
    host_path = "/srv/gitlab/data"
    container_path = "/var/opt/data"
  }
}
