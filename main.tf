data "ibm_pi_catalog_images" "catalog_images" {
  sap                  = true
  vtl                  = true
  pi_cloud_instance_id = var.pid
}

data "ibm_pi_images" "images" {
  pi_cloud_instance_id = var.pid
}

resource "ibm_pi_image" "image" {
  count = length(local.image) == 0 ? 1 : 0
  pi_cloud_instance_id = var.pid
  pi_image_id = local.catalog_image[0].image_id
  // This argument is not needed for image copy; should be made optional in the provider
  pi_image_name = "test"
}

locals {
  image = [for x in data.ibm_pi_images.images.image_info : x if x.name == var.stock_image_name]
  catalog_image = [for x in data.ibm_pi_catalog_images.catalog_images.images : x if x.name == var.stock_image_name]
  image_id = length(local.image) == 0 ? ibm_pi_image.image[0].image_id : local.image[0].id
}

data "ibm_pi_key" "key" {
  pi_cloud_instance_id = var.pid
  pi_key_name          = var.ssh_key_name
}

data "ibm_pi_network" "power_network" {
  pi_cloud_instance_id = var.pid
  pi_network_name      = var.network_name
}

resource "ibm_pi_instance" "instance1" {
  pi_cloud_instance_id = var.pid
  pi_memory            = var.memory
  pi_processors        = var.processors
  pi_instance_name     = "${var.instance_name}-1"
  pi_proc_type         = var.processor_type
  pi_image_id          = local.image_id
  pi_key_pair_name     = data.ibm_pi_key.key.id
  pi_sys_type          = var.sys_type
  pi_storage_type   = "tier1"
  pi_network {
    network_id = data.ibm_pi_network.power_network.id
  }
}
resource "ibm_pi_instance" "instance2" {
  pi_cloud_instance_id = var.pid
  pi_memory            = var.memory
  pi_processors        = var.processors
  pi_instance_name     = "${var.instance_name}-2"
  pi_proc_type         = var.processor_type
  pi_image_id          = local.image_id
  pi_key_pair_name     = data.ibm_pi_key.key.id
  pi_sys_type          = var.sys_type
  pi_storage_type   = "tier3"
  pi_network {
    network_id = data.ibm_pi_network.power_network.id
  }
}
