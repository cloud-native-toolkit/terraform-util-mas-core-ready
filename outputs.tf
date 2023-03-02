
output "core_instance_namespace" {
  description = "Namespace where mas-core operator has been installed"
  value = var.core_instance_namespace
  depends_on = [null_resource.wait_for_mas_core_license]
}

output "mas_instance_id" {
  description = "The instance id for the MAS suite"
  value = var.mas_instance_id
  depends_on = [null_resource.wait_for_mas_core_license]
}
