
locals {
  namespace = var.core_instance_namespace != "" ? var.core_instance_namespace : "mas-${var.mas_instance_id}-core"
}

data clis_check clis {
  clis = ["jq", "oc", "kubectl"]
}

resource "null_resource" "wait_for_mas_core" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/wait-for-mas-core.sh '${local.namespace}' '${var.mas_instance_id}'"

    environment = {
      KUBECONFIG = var.cluster_config_file
      BIN_DIR = data.clis_check.clis.bin_dir
    }
  }
}

resource "null_resource" "wait_for_mas_core_license" {
  depends_on = [null_resource.wait_for_mas_core]

  provisioner "local-exec" {
    command = "${path.module}/scripts/wait-for-mas-core-license.sh '${local.namespace}' '${var.mas_instance_id}'"

    environment = {
      KUBECONFIG = var.cluster_config_file
      BIN_DIR = data.clis_check.clis.bin_dir
    }
  }
}
