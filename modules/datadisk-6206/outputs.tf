output "data_disk_uris" {
  value = azurerm_managed_disk.data_disk[*].id
}
