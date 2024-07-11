resource "azurerm_resource_group" "main" {
    name = "${var.student_number}-RG"
    location = var.location
    tags = var.tags

}