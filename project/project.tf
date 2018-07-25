variable "project" {}
variable "project_id" {}
variable "org_id" {}
variable "billing_account" {}

resource "google_project" "project" {
    name       = "${var.project}"
    project_id = "${var.project_id}"
    org_id     = "${var.org_id}"
    billing_account = "${var.billing_account}"
}
