provider "oci" {
  tenancy_ocid = data.sops_file.secrets.data["oci.config.tenancy_ocid"]
  region       = data.sops_file.secrets.data["oci.config.region"]
}
