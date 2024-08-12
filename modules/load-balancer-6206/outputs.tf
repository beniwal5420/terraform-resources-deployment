output "load_balancer_name" {
  description = "The name of the load balancer"
  value       = azurerm_lb.n01656206-loadbalancer.name
}

output "loadbalancer_fqdn" {
  value = azurerm_public_ip.n01656206-loadbalancer-pip.fqdn
  description = "The fully qualified domain name (FQDN) of the load balancer"
}
