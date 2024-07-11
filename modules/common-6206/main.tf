resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "${var.student_number}-log-analytics"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                = "recoveryVault-${var.student_number}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags = var.tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.student_number}storage"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

