
generate "variable" {
  path      = "generated_variable.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    locals {
      default_tags = {
        ManagedBy = "Terraform"
        TerraformPath = "gcp/${path_relative_to_include()}"
      }
    }
  EOF
}


remote_state {
  backend = "gcs"
  config = {
    bucket      = "dwh-sandbox-backend"
    prefix      = "gcp/${path_relative_to_include()}"
    credentials = fileexists("/secrets/.gcp/sva-dwh-sandbox.json") ? "/secrets/.gcp/sva-dwh-sandbox.json" : null
  }

  generate = {
    path      = "generated_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
