resource "azurerm_lb" "n01656206-loadbalancer" {
  name                = var.loadbalancer_name
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "${var.loadbalancer_name}-ipconfig"
    public_ip_address_id = azurerm_public_ip.n01656206-loadbalancer-pip.id
  }

  sku = "Basic"

  depends_on = [azurerm_public_ip.n01656206-loadbalancer-pip]

  tags = var.tags
}

resource "azurerm_public_ip" "n01656206-loadbalancer-pip" {
  name                = "${var.loadbalancer_name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location

  domain_name_label     = "n01656206lb"
  allocation_method     = var.allocation_method
  idle_timeout_in_minutes = 30

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "n01656206-loadbalancer-address_pool" {
  name            = "${var.loadbalancer_name}-address_pool"
  loadbalancer_id = azurerm_lb.n01656206-loadbalancer.id
}

resource "azurerm_network_interface_backend_address_pool_association" "n01656206-loadbalancer-nic-backend_pool_association" {
  count                   = var.loadbalancer_backend_pool_association.count
  network_interface_id    = var.loadbalancer_backend_pool_association.nic_ids[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.n01656206-loadbalancer-address_pool.id
  ip_configuration_name   = "internal"
}

resource "azurerm_lb_rule" "n01656206-loadbalancer-rules" {
  loadbalancer_id                = azurerm_lb.n01656206-loadbalancer.id
  name                           = var.loadbalancer-rules.name
  protocol                       = var.loadbalancer-rules.protocol
  frontend_port                  = var.loadbalancer-rules.frontend_port
  backend_port                   = var.loadbalancer-rules.backend_port
  frontend_ip_configuration_name = "${var.loadbalancer_name}-ipconfig"
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.n01656206-loadbalancer-address_pool.id]
}
