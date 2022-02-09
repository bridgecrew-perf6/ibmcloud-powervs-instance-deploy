#variable "ibmcloud_api_key" {
#  description  = "IBM Cloud API key"
#  sensitive    = true
#}
variable "region" { default = "dal" }
variable "zone" { default = "dal12" }
variable "pid" { default = "6021a723-bcab-4d3f-9985-d0cb2f864f35" }
variable "stock_image_name" { default = "Linux-CentOS-8-3" }

variable "memory" { default = 4 }
variable "processors" { default = 0.25 }
variable "instance_name" {}
variable "processor_type" { default = "shared" }
variable "sys_type" { default = "s922" }
variable "ssh_key_name" {}
variable "network_name" {}

