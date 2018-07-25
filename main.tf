module "project" {
  source = "project"

  project    = "${var.project}"
  project_id = "${var.project_id}"
  org_id     = "${var.org_id}"
  billing_account = "${var.billing_account}"
}


// master node
module "master" {
    source = "master"

    project = "${var.project}"
    region  = "${var.primary_region}"
    zone    = "${var.primary_zone}"
    machine_type = "n1-standard-1"
    network  = "default"

    // image and disk
    image    = "ubuntu-os-cloud/ubuntu-1804-lts"
    disksize = "30"
    disktype = "pd-ssd"

    letsencrypt = "${var.letsencrypt}"
    fqdn        = "${var.fqdn}"
}


// etcd cluster and controlplane
module "etcd" {
    count   = 3
    source  = "node"
    name    = "etcd"
    project = "${var.project}"
    region  = "${var.primary_region}"
    zone    = "${var.primary_zone}"
    machine_type = "n1-standard-1"
    network = "default"

    // image and disk
    image = "ubuntu-os-cloud/ubuntu-1804-lts"
    disksize = "30"
    disktype = "pd-ssd"

    // rancher config
    fqdn = "${var.fqdn}"
    token = "${var.token}"
}


// etcd cluster and controlplane
module "worker" {
    count   = 2
    source  = "node"
    name    = "worker"
    project = "${var.project}"
    region  = "${var.primary_region}"
    zone    = "${var.primary_zone}"
    machine_type = "n1-standard-1"
    network = "default"

    // image and disk
    image = "ubuntu-os-cloud/ubuntu-1804-lts"
    disksize = "30"
    disktype = "pd-ssd"

    // rancher config
    fqdn = "${var.fqdn}"
    token = "${var.token}"
    roles = "--worker"
}
