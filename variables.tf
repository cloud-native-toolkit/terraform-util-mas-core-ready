variable "cluster_config_file" {
  type        = string
  description = "Cluster config file for Kubernetes cluster."
}

variable "core_instance_namespace" {
  type        = string
  description = "Namespace where mas-core operator has been installed"
}

variable "mas_instance_id" {
  type        = string
  description = "The instance id for the MAS suite"
}
