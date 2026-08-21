data "yandex_compute_image" "ubuntu-22-04" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "vm-01" {

  name        = "vm-01"
  platform_id = "standard-v3"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      size     = 40
      type     = "network-ssd"
      image_id = data.yandex_compute_image.ubuntu-22-04.id
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.default-ru-central1-d.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

data "yandex_vpc_network" "default" {
  name = "default"
}

data "yandex_vpc_subnet" "default-ru-central1-d" {
  name = "default-ru-central1-d"
}
