module "wait_for_mas_core" {
  source = "./module"

  cluster_config_file = module.dev_cluster.config_file_path
  core_namespace = module.mas_core.core_namespace
  entitlement_secret_name = module.mas_core.entitlement_secret_name
  mas_instance_id = module.mas_core.mas_instance_id
  mas_workspace_id = module.mas_core.mas_workspace_id
}
