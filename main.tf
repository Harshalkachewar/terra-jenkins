terraform {
  required_providers {
    linux = {
      source = "TelkomIndonesia/linux"
      version = "0.7.0"
    }
  }
}

provider "linux" {
    host     = "192.168.180.129"
    port     = 22
    user     = "harshal"
    password = "redhat"
}

resource "linux_directory" "resource1" {
    path = "/tmp/terraform1"
}

resource "linux_file" "resource2" {
    path = "/tmp/terraform1/unnati.txt"
    content = <<-EOF
        hello world
    EOF
}
