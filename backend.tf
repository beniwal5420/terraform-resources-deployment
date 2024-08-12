terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate6206RG"
    storage_account_name = "tfstate6206sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}
