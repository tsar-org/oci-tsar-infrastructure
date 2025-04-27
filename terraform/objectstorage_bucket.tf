resource "oci_objectstorage_bucket" "terraform_state_bucket" {
  compartment_id = oci_identity_compartment.tsar_compartment.id
  name           = "terraform-state-bucket"
  namespace      = data.sops_file.secrets.data["oci.config.namespace"]

  # Optional
  access_type  = "NoPublicAccess"
  auto_tiering = "InfrequentAccess"
}
