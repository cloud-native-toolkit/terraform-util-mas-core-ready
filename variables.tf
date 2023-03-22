variable "cluster_config_file" {
  type        = string
  description = "Cluster config file for Kubernetes cluster."
}

variable "core_namespace" {
  type        = string
  description = "Namespace where mas-core operator has been installed. If not provided, the value will be derived from the mas_instance_id"
  default     = ""
}

variable "entitlement_secret_name" {
  type        = string
  description = "The name of the secret that contains the entitlement_key"
}

variable "mas_instance_id" {
  type        = string
  description = "The instance id for the MAS suite"
}

variable "mas_workspace_id" {
  type        = string
  description = "The identifier of the MAS workspace that was created"
}
