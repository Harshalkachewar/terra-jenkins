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

resource "null_resource" "setup_script" {

  # ✔ This is the fix — connection for BOTH provisioners
  connection {
    type     = "ssh"
    host     = "192.168.1.190"
    user     = "root"
    password = "redhat"
  }

  triggers = {
    script_md5 = filemd5("scripts/create_dir_and_file.sh")
  }

  # Upload script
  provisioner "file" {
    source      = "scripts/create_dir_and_file.sh"
    destination = "/tmp/create_dir_and_file.sh"
  }

  # Execute script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/create_dir_and_file.sh",
      "/tmp/create_dir_and_file.sh ${var.directory_path} ${var.file_path}"
    ]
  }
}
