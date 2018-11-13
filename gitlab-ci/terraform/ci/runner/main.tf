provider "docker" {
  host = "tcp://${var.docker_host_ip}:2376"
}

resource "docker_image" "gitlab_runner" {
  name = "gitlab/gitlab-runner:latest"
}

resource "docker_container" "gitlab_runner" {
  count = "${var.runners_number}"
  image = "${docker_image.gitlab_runner.latest}"
  name = "gitlab-runner-${count.index}"
  volumes {
    host_path = "/srv/runner-${count.index}/config"
    container_path = "/etc/gitlab-runner"
    read_only = false
  }
  volumes {
    host_path = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }
  upload {
    content = "${data.template_file.entrypoint.rendered}"
    file = "/home/gitlab-runner/entrypoint.sh"
    executable = true
  }
  entrypoint = ["/home/gitlab-runner/entrypoint.sh"]
}

data "template_file" "entrypoint" {
  template = "${file("${path.module}/files/entrypoint.sh")}"

  vars {
    ci_url = "${var.gitlab_url}"
    ci_token = "${var.token}"
  }
}
