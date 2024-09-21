terraform {
  required_version = "= 1.9.5"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.10.0"
    }

    sops = {
      source  = "carlpett/sops"
      version = "~> 1.1.0"
    }
  }
}

provider "oci" {
  tenancy_ocid = data.sops_file.secrets.data["oci.config.tenancy_ocid"]
  region       = data.sops_file.secrets.data["oci.config.region"]
}
