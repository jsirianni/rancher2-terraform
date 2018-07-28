variable "project" {}
variable "zone" {}
variable "image" {}
variable "disksize" {}
variable "disktype" {}
variable "machine_type" {}
variable "network" {}
variable "region" {}
variable "fqdn" {}
variable "token" {}
variable "name" {}

variable "count" {
    default = 2
}

variable "preemptible" {
    default = false
}

variable "tags" {
    default = [
        "rancher",
        "node"
    ]
}

variable "roles" {
    // string of roles [--etcd --controlplane --worker]
    default = "--etcd --controlplane"
}

variable "labels" {
    // string of --labels
    default = "--label platform=gcp"
}
