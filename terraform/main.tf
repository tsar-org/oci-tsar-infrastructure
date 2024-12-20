terraform {
  required_version = "= 1.9.5"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.21.0"
    }

    sops = {
      source  = "carlpett/sops"
      version = "~> 1.1.0"
    }
  }

  backend "s3" {
    bucket                      = "terraform-state-bucket"
    region                      = "ap-tokyo-1"
    key                         = "terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
    endpoints = {
      s3 = "https://nr2antbqwqi2.compat.objectstorage.ap-tokyo-1.oraclecloud.com"
    }
  }
}
