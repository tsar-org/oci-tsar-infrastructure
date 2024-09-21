## compartment
resource "oci_identity_compartment" "tsar_compartment" {
  compartment_id = data.sops_file.secrets.data["oci.config.tenancy_ocid"]
  description    = "tsar compartment"
  name           = "tsar-compartment"
}
