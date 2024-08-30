# VCN
resource "oci_core_vcn" "tsar_vcn" {

  compartment_id = oci_identity_compartment.tsar_compartment.id
  cidr_block     = "10.0.0.0/16"
  display_name   = "tsar-vcn"
  dns_label      = "tsarvcn"
}

# Security List
resource "oci_core_security_list" "tsar_sl" {

  compartment_id = oci_identity_compartment.tsar_compartment.id
  vcn_id         = oci_core_vcn.tsar_vcn.id
  display_name   = "tsar-security-list-for-public-subnet"

  ingress_security_rules {
    protocol    = "6" # TCP
    source_type = "CIDR_BLOCK"
    source      = "0.0.0.0/0"
    tcp_options {
      min = 25565
      max = 25565
    }
  }

  egress_security_rules {
    protocol         = "all"
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"
  }
}

# Subnet
resource "oci_core_subnet" "tsar_subnet" {

  cidr_block     = "10.0.0.0/24"
  compartment_id = oci_identity_compartment.tsar_compartment.id
  vcn_id         = oci_core_vcn.tsar_vcn.id
  # dhcp_options_id = oci_core_dhcp_options.test_oci_dhcp_options.id
  display_name = "tsar-container-instance-public-subnet"
  dns_label    = "containers"
  security_list_ids = [
    oci_core_security_list.tsar_sl.id
  ]
  route_table_id = oci_core_route_table.tsar_rt.id
}

# Internet Gateway
resource "oci_core_internet_gateway" "tsar_ig" {

  compartment_id = oci_identity_compartment.tsar_compartment.id
  vcn_id         = oci_core_vcn.tsar_vcn.id
  display_name   = "tsar-internet-gateway"
  enabled        = true
}

# Route Table
resource "oci_core_route_table" "tsar_rt" {

  compartment_id = oci_identity_compartment.tsar_compartment.id
  vcn_id         = oci_core_vcn.tsar_vcn.id
  display_name   = "tsar-internet-gateway-route-table"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.tsar_ig.id
  }
}
