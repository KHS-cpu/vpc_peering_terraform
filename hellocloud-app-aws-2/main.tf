module "my-app-aws" {
  source = "../hellocloud-app-aws"

  prefix         = var.prefix
  address_space  = var.address_space
  environment    = var.environment
  subnet_prefix  = var.subnet_prefix
  instance_type  = var.instance_type
  department     = var.department
  placeholder    = var.placeholder
  placeholder_id = var.placeholder_id
  width          = var.width
  height         = var.height
}