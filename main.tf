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

# Define variables for paths
variable "directory_path" {
  default = "/tmp/terraform1"
}

variable "file_path" {
  default = "/tmp/terraform1/unnati.txt"
}

# Create directory using null_resource
resource "null_resource" "create_directory" {
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = "192.168.1.190"
      user     = "root"
      password = "redhat"
    }

    inline = [
      "mkdir -p ${var.directory_path}"
    ]
  }
}

# Create file with content
resource "null_resource" "create_file" {
  depends_on = [null_resource.create_directory]

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = "192.168.1.190"
      user     = "root"
      password = "redhat"
    }

    inline = [
      "echo 'hello world' > ${var.file_path}"
    ]
  }
}
