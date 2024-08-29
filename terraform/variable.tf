data "sops_file" "secrets" {
  source_file = "../secret.enc.yaml"
  input_type  = "yaml"
}

variable "tsar_minecraft_container_instance_environment_variables" {
  type = object({
    EULA = string
  })
  default = {
    EULA = "TRUE"
  }
  description = "Environment variables for minecraft container"
}
