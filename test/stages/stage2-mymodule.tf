module "wait_for_mas_core" {
  source = "./module"

  cluster_config_file = module.dev_cluster.config_file_path
  core_instance_namespace = ""
  mas_instance_id = module.mas_core.mas_instance_id
}
