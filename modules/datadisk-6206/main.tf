resource "azurerm_managed_disk" "data_disk" {
  count                = 4
  name                 = "${var.student_number}-disk-${count.index}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  count              = length(concat(var.linux_vm_uris, var.windows_vm_uris))
  managed_disk_id    = azurerm_managed_disk.data_disk[count.index % length(azurerm_managed_disk.data_disk)].id
  virtual_machine_id = element(concat(var.linux_vm_uris, var.windows_vm_uris), count.index)
  lun                = count.index
  caching            = "ReadWrite"
}
