data "template_file" "rancher_node" {
  template = "${file("${path.module}/script.sh.tpl")}"
  vars {
      fqdn = "${var.fqdn}"
      token = "${var.token}"
      roles = "${var.roles}"
      labels = "${var.labels}"
  }
}


resource "google_compute_instance" "rancher_node" {
  count = "${var.count}"
  name         = "rancher-${var.name}-${count.index}"
  project      = "${var.project}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  scheduling {
    preemptible  = "${var.preemptible}"
  }

  tags = "${var.tags}"

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
    }
  }

  metadata_startup_script = "${data.template_file.rancher_node.rendered}"
}
