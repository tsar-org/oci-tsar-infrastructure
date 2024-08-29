# container instance
# https://www.oracle.com/jp/cloud/costestimator.html

data "oci_identity_availability_domains" "tsar_local_ads" {

  compartment_id = oci_identity_compartment.tsar_compartment.id
}

resource "oci_container_instances_container_instance" "tsar_container_instance" {

  availability_domain      = data.oci_identity_availability_domains.tsar_local_ads.availability_domains[0].name
  compartment_id           = oci_identity_compartment.tsar_compartment.id
  display_name             = "tsar-minecraft-container-instance"
  container_restart_policy = "ALWAYS"
  shape                    = "CI.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = 4
    ocpus         = 1
  }

  vnics {
    subnet_id             = oci_core_subnet.tsar_subnet.id
    display_name          = "tsar-minecraft-container-instance-vnics"
    is_public_ip_assigned = true
    nsg_ids               = []
  }

  containers {
    image_url             = "itzg/minecraft-server"
    display_name          = "tsar-minecraft-container-instance-containers"
    environment_variables = var.tsar_minecraft_container_instance_environment_variables
  }
}
