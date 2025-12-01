terraform {
  required_providers {
    linux = {
      source  = "TelkomIndonesia/linux"
      version = "0.7.0"
    }
  }
}

provider "linux" {
  host     = "192.168.1.190"
  port     = 22
  user     = "root"
  password = "redhat"
}

variable "directory_path" {
  default = "/tmp/terraform1"
}

variable "file_path" {
  default = "/tmp/terraform1/unnati.txt"
}

resource "null_resource" "create_directory_and_file" {
  # If you want to re-run when outputs change, add triggers = { ... }
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = "192.168.1.190"
      user     = "root"
      password = "redhat"
    }

    inline = [
      "set -euo pipefail",
      "echo '=== creating directory ==='",
      "mkdir -p ${var.directory_path}",
      "echo 'hello world' > ${var.file_path}",
      "chmod 644 ${var.file_path}",
      "echo '=== verify ==='",
      "ls -l ${var.directory_path} || true",
      "cat ${var.file_path} || true"
    ]
  }
}
