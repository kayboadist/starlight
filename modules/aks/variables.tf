variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
  default = "starlight-aks"
}

variable "node_count" {
  description = "The number of nodes in the default node pool"
  type        = number
}

variable "dns_prefix" {
  type        = string
  description = "The DNS prefix for the AKS cluster"
  default     = "starlightaks"
}
variable "vm_size" {
  description = "The size of the VM for the AKS nodes"
  type        = string
  default     = "Standard_D2_v2"
}

variable "environment" {
  description = "The environment tag for the resources"
  type        = string
  default     = "production"
}