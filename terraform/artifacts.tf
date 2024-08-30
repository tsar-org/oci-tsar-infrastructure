resource "oci_artifacts_container_repository" "minecraft_container_repository" {
  #Required
  compartment_id = oci_identity_compartment.tsar_compartment.id
  display_name   = "tsar-minecraft-container-repository-container-repository"

  is_immutable = false
  is_public    = false
}
