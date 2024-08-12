variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
}

variable "loadbalancer_name" {
  type        = string
  description = "Name of the load balancer"
}

variable "allocation_method" {
  type        = string
  description = "Allocation method for the public IP address"
}

variable "loadbalancer_backend_pool_association" {
  type        = any
  description = "Contains information about the NIC and load balancer's backend_pool association"
}

variable "loadbalancer-rules" {
  type        = map(string)
  description = "Contains information about the firewall rules for load balancer"
}
