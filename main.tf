module "resource_group" {
  source              = "./modules/rgroup-6206"
  student_number           = var.student_number
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

module "network" {
  source              = "./modules/network-6206"
  student_number           = var.student_number
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on          = [module.resource_group]
   tags = var.tags
}

module "common" {
  source              = "./modules/common-6206"
  student_number           = var.student_number
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on          = [module.resource_group]
  tags = var.tags
}

module "vmlinux" {
  source                = "./modules/vmlinux-6206"
  student_number             = var.student_number
  location              = var.location
  resource_group_name   = module.resource_group.resource_group_name
  subnet_id             = module.network.subnet_id
  storage_account_uri   = module.common.storage_account_uri
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  public_key_path       = var.public_key_path
  private_key_path      = var.private_key_path
  tags                  = var.tags
  linux_vm_names        = var.linux_vm_names
  linux_vm_size         = var.linux_vm_size
  linux_vm_nics         = var.linux_vm_nics
  availability_set_name = "${var.student_number}-avs"
  depends_on            = [module.network, module.common]
}

module "vmwindows" {
  source              = "./modules/vmwindows-6206"
  student_number           = var.student_number
  location            = var.location
  windows_avs_name    = local.windows_avs_name
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.network.subnet_id
  storage_account_uri = module.common.storage_account_uri
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password
  windows_vm_count    = var.windows_vm_count
  windows_vm_size     = var.windows_vm_size
  tags                = var.tags
  depends_on          = [module.network, module.common]
}


locals {
  windows_avs_name = "windows-avs-${var.student_number}"
}

module "loadbalancer" {
  source = "./modules/load-balancer-6206"

  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  tags                      = var.tags
  loadbalancer_name = "n01656206-loadbalancer"
  allocation_method = "Static"

  loadbalancer_backend_pool_association = {
    count     = length(module.vmlinux.vm_hostnames)
    hostnames = values(module.vmlinux.vm_hostnames)
    nic_ids   = values(module.vmlinux.nic_uris)
  }

  loadbalancer-rules = var.loadbalancer-rules
}

module "datadisk" {
  source              = "./modules/datadisk-6206"
  student_number           = var.student_number
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  linux_vm_uris        = values(module.vmlinux.linux_vm_uris)
  windows_vm_uris      = tolist(module.vmwindows.windows_vm_ids)
  depends_on          = [module.vmlinux, module.vmwindows]
}

module "database" {
  source                  = "./modules/database-6206"
  student_number               = var.student_number
  location                = var.location
  resource_group_name     = module.resource_group.resource_group_name
  admin_username          = var.admin_username
  admin_password          = var.admin_password
  tags                    = var.tags
  psql_version      = var.psql_version
  ssl_enforcement_enabled = var.ssl_enforcement_enabled
  depends_on              = [module.common]
}