resource "oci_objectstorage_bucket" "terraform_state_bucket" {
  compartment_id = oci_container_instances_container_instance.tsar_minecraft_container_instance.compartment_id
  name           = "terraform-state-bucket"
  namespace      = data.sops_file.secrets.data["oci.config.namespace"]

  # Optional
  access_type  = "NoPublicAccess"
  auto_tiering = "InfrequentAccess"
}
