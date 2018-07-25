# rancher2-terraform
Terraform to deploy Rancher 2.0 Kubernetes Clusters on GCP

## Usage
### Setup variables
Terraform will require a handful of variables. Copy `secure.tf.example` to
`secure.tf` and then fill it out. `secure.tf` is in the gitignore.

### Deploy the project
```
terraform init
terraform apply -target module.project
```

### Deploy the master node
The master node must be configured before the Kubernetes cluster can be formed.
##### Without letsencrypt
```
# Get IP Address
terraform apply -target module.master.google_compute_address.rancher_master
```
```
# Set DNS record for new IP
```
```
# build master node
terraform apply -target module.master
```

### Deploy the cluster
Browse to the public address of the master node.
- Setup the password
- Create a "custom" cluster
- Add the cluster name to `secure.tf`
- Add the cluster token to `secure.tf`
- re-run `terraform apply`
- done
