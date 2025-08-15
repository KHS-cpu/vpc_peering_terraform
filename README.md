## NOTE - SECURITY !!!
* The Terraform state file will contain the private key in plain text.

### To git clone a specific branch from a remote repository
```
git clone -b hellocloud-app-aws --single-branch git@gitlab.com:sailinnthu/terraform-aws-bastion-host.git hellocloud-app-aws
```

### See all state contents (will show private key)
```
terraform show
```

### See specific resource (will show private key)
```
terraform state show tls_private_key.hellocloud
```

### Extract just the private key
```
terraform state show tls_private_key.hellocloud | grep private_key_openssh
```

### To SSH into the instance
* Manually save the private key to a file.
```
$ terraform output
hellocloud_app_ip = "http://54.64.95.25"
hellocloud_app_url = "http://ec2-54-64-95-25.ap-northeast-1.compute.amazonaws.com"
hellocloud_instance_private_key = <sensitive>
```
```
terraform output -raw hellocloud_instance_private_key > hellocloud-ssh-key.pem
chmod 400 hellocloud-ssh-key.pem
```
```
ssh -i hellocloud-ssh-key.pem ubuntu@ec2-54-64-95-25.ap-northeast-1.compute.amazonaws.com
```
## NOTE - Common issue with Terraform modules and file provisioners
* The concept is using `${path.module}/files/` instead of just `files/` in your module definition. This ensures the path is resolved relative to the module's location, not the execution directory.

* Error as below
```
module.my-app-aws.null_resource.configure-hellocloud-app: Still creating... [00m20s elapsed]
╷
│ Error: file provisioner error
│ 
│   with module.my-app-aws.null_resource.configure-hellocloud-app,
│   on .terraform/modules/my-app-aws/instance.tf line 35, in resource "null_resource" "configure-hellocloud-app":
│   35:   provisioner "file" {
│ 
│ stat files/: no such file or directory
```
* To fix - update child module's `instance.tf` `line 36` as below.
* Before
```
  provisioner "file" {
    source      = "files/"
    destination = "/home/ubuntu/"
```
* After
```
  provisioner "file" {
    source      = "${path.module}/files/"
    destination = "/home/ubuntu/"
```
### Verify `terraform state list`
```
$ terraform state list
module.my-app-aws.data.aws_ami.ubuntu
module.my-app-aws.aws_eip.hellocloud
module.my-app-aws.aws_eip_association.hellocloud
module.my-app-aws.aws_instance.hellocloud
module.my-app-aws.aws_internet_gateway.hellocloud
module.my-app-aws.aws_key_pair.hellocloud
module.my-app-aws.aws_route_table.hellocloud
module.my-app-aws.aws_route_table_association.hellocloud
module.my-app-aws.aws_security_group.hellocloud
module.my-app-aws.aws_subnet.hellocloud
module.my-app-aws.aws_vpc.hellocloud
module.my-app-aws.null_resource.configure-hellocloud-app
module.my-app-aws.tls_private_key.hellocloud
```
### `terraform state show module.my-app-aws.tls_private_key.hellocloud`
```
$ terraform state show module.my-app-aws.tls_private_key.hellocloud
# module.my-app-aws.tls_private_key.hellocloud:
resource "tls_private_key" "hellocloud" {
    algorithm                     = "ED25519"
    ecdsa_curve                   = "P224"
    id                            = "23fab1d977d4e0dff0b2b77a6b9cbb5e7dc99247"
    private_key_openssh           = (sensitive value)
    private_key_pem               = (sensitive value)
    private_key_pem_pkcs8         = (sensitive value)
    public_key_fingerprint_md5    = "85:14:90:40:6d:ce:d7:46:70:d6:9c:97:90:d3:13:3a"
    public_key_fingerprint_sha256 = "SHA256:k3KuOuzhdDyxaUe3i3pNSeEYAltJyh9hbbsK8PbM724"
    public_key_openssh            = <<-EOT
        ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPs/HJoG+ViS6qnQSGWttcvPZtlcrTBxZynJX9qED3O
    EOT
    public_key_pem                = <<-EOT
        -----BEGIN PUBLIC KEY-----
        MCowBQYDK2VwAyEA0+z8cmgb5WJLqqdBIZa21y89m2VytMHFnKclf2oQPc4=
        -----END PUBLIC KEY-----
    EOT
    rsa_bits                      = 2048
}
```

### Extract the private key
```
$ terraform output -raw hellocloud_instance_private_key
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtz
c2gtZWQyNTUxOQAAACDT7PxyaBvlYkuqp0EhlrbXLz2bZXK0wcWcpyV/ahA9zgAA
AIjXM5dl1zOXZQAAAAtzc2gtZWQyNTUxOQAAACDT7PxyaBvlYkuqp0EhlrbXLz2b
ZXK0wcWcpyV/ahA9zgAAAECgCi073Xn9Ta9F9czAaRBSWY9Yorn4QedmUb4ghM8o
ldPs/HJoG+ViS6qnQSGWttcvPZtlcrTBxZynJX9qED3OAAAAAAECAwQF
-----END OPENSSH PRIVATE KEY-----
```
* Extract the private key to a file
```
terraform output -raw hellocloud_instance_private_key > mykey.pem
chmod 400 mykey.pem
```
* SSH into your instance
```
ssh -i mykey.pem ubuntu@35.79.113.219
```
### Referencing output values
![Diagram](assets/reference-output-values.png)
