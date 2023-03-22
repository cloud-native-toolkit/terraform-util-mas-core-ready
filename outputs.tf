
output "core_namespace" {
  description = "Namespace where mas-core operator has been installed"
  value = var.core_namespace
  depends_on = [null_resource.wait_for_mas_core_license]
}

output "entitlement_secret_name" {
  description = "The name of the secret that contains the entitlement_key"
  value = var.entitlement_secret_name
  depends_on = [null_resource.wait_for_mas_core_license]
}

output "mas_instance_id" {
  description = "The instance id for the MAS suite"
  value = var.mas_instance_id
  depends_on = [null_resource.wait_for_mas_core_license]
}

output "mas_workspace_id" {
  description = "The identifier of the MAS workspace that was created"
  value = var.mas_workspace_id
  depends_on = [null_resource.wait_for_mas_core_license]
}
