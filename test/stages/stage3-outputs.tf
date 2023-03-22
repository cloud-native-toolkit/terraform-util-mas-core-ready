
resource local_file write_outputs {
  filename = "gitops-output.json"

  content = jsonencode({
    core_namespace = module.wait_for_mas_core.core_namespace
    instance_id = module.wait_for_mas_core.mas_instance_id
  })
}
