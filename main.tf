module "srvr-1" {
  source = "./hellocloud-app-aws"

  prefix         = "khs"
  address_space  = "10.0.0.0/16"
  environment    = var.environment
  subnet_prefix  = "10.0.10.0/24"
  instance_type  = var.instance_type
  department     = var.department
  placeholder    = var.placeholder
  placeholder_id = var.placeholder_id
  width          = var.width
  height         = var.height
}

module "srvr-2" {
  source = "./hellocloud-app-aws-2"

  prefix         = "khs_2"
  address_space  = "10.1.0.0/16"
  environment    = var.environment
  subnet_prefix  = "10.1.10.0/24"
  instance_type  = var.instance_type
  department     = var.department
  placeholder    = var.placeholder
  placeholder_id = var.placeholder_id
  width          = var.width
  height         = var.height
}