variable "project" {}
variable "zone" {}
variable "image" {}
variable "disksize" {}
variable "disktype" {}
variable "machine_type" {}
variable "network" {}
variable "region" {}

variable "letsencrypt" {}
variable "fqdn" {}


resource "google_compute_address" "rancher_master" {
  project = "${var.project}"
  name    = "rancher-master"
  region  = "${var.region}"
}


data "template_file" "rancher_master" {
  template = "${file("${path.module}/script.sh.tpl")}"
  vars {
      letsencrypt = "${var.letsencrypt}"
      fqdn = "${var.fqdn}"
  }
}


resource "google_compute_instance" "rancher_master" {
  name         = "rancher-master"
  project      = "${var.project}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  scheduling {
    preemptible  = false
    automatic_restart = true
  }

  tags = [
      "http-server",
      "https-server",
      "master",
      "rancher"
  ]

  boot_disk {
    initialize_params {
      image = "${var.image}"
      size  = "${var.disksize}"
      type  = "${var.disktype}"
    }
  }

  network_interface {
    network = "${var.network}"
    access_config {
        nat_ip = "${google_compute_address.rancher_master.address}"
    }
  }

  metadata_startup_script = "${data.template_file.rancher_master.rendered}"
}
