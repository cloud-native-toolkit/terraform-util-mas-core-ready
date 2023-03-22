# MAS Core Ready module

Module that connects to a cluster and watches the MAS Core "Suite" resource to determine when the instance is installed 
and ready for use (e.g. license applied).

## Module overview

### Description

The module waits for the core namespace to be created and for the Suite resource to be created in the namespace. Then
it watches the status of the resource to see how the installation is progressing. There are three statuses in particular
that are of interest - Progressing, MissingLicenseFile, and Ready.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

### Software dependencies

The module depends on the following software components:

#### Command-line tools

- terraform >= v0.15

#### Terraform providers

- Cloud Native Toolkit clis

### Module dependencies

This module makes use of the output from other modules:

- Cluster - github.com/cloud-native-toolkit/terraform-ibm-container-platform.git
- MAS Core - github.com/cloud-native-toolkit/terraform-gitops-mas-core.git

### Example usage

```hcl-terraform
module "wait_for_mas_core" {
  source = "github.com/cloud-native-toolkit/terraform-util-mas-core-ready.git"

  cluster_config_file = module.dev_cluster.config_file_path
  core_namespace = module.mas_core.core_namespace
  entitlement_secret_name = module.mas_core.entitlement_secret_name
  mas_instance_id = module.mas_core.mas_instance_id
  mas_workspace_id = module.mas_core.mas_workspace_id
}
```
