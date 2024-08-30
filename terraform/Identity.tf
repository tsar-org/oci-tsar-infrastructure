## compartment
resource "oci_identity_compartment" "tsar_compartment" {
  compartment_id = data.sops_file.secrets.data["oci.config.tenancy_ocid"]
  description    = "tsar compartment"
  name           = "tsar-compartment"
}

## identity user
### https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_user
resource "oci_identity_user" "user_leoleo" {
  compartment_id = data.sops_file.secrets.data["oci.config.tenancy_ocid"]
  description    = "identify user for tsar"
  name           = "leoleo"

  email = data.sops_file.secrets.data["oci.identity-user.leoleo.email"]
}

## identity group
### https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_group
resource "oci_identity_group" "tsar_compartment_maintainer_group" {
  #Required
  compartment_id = data.sops_file.secrets.data["oci.config.tenancy_ocid"]
  description    = "tsar compartment maintainer group"
  name           = "tsar-compartment-maintainer-group"
}

## identity user group membership
### https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_user_group_membership
resource "oci_identity_user_group_membership" "tsar_compartment_maintainer_group_membership_leoleo" {
  group_id = oci_identity_group.tsar_compartment_maintainer_group.id
  user_id  = oci_identity_user.user_leoleo.id
}

## identity policy
### https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy
resource "oci_identity_policy" "tsar_compartment_maintainer_policy" {
  compartment_id = data.sops_file.secrets.data["oci.config.tenancy_ocid"]
  description    = "Allow group ${oci_identity_group.tsar_compartment_maintainer_group.name} to manage all-resources in ${oci_identity_compartment.tsar_compartment.name}"
  name           = "tsar-compartment-maintainer-policy"
  statements = [
    "Allow group ${oci_identity_group.tsar_compartment_maintainer_group.name} to manage all-resources in compartment ${oci_identity_compartment.tsar_compartment.name}"
  ]
}
