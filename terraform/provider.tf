terraform {
  required_version = "= 1.9.3"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.9.0"
    }
  }
}
