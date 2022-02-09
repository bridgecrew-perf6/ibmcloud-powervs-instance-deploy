terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}
provider "ibm" {
  #  ibmcloud_api_key  = var.ibmcloud_api_key
  region = var.region
  zone   = var.zone
}

