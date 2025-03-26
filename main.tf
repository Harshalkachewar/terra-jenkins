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
    user     = "root"
    password = "redhat"
}

resource "linux_file" "unnatifile" {
    path = "/tmp/testdir"
}
