generate "locals" {
  path      = "generated_locals.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<-EOF

  locals {
    gcp_project        = "data-sandbox-dmql-sgxt7g"
    gcp_region         = "me-central2"
    gcp_zone           = "me-central2-a"
    gcp_project_number = "955649792918"
  }
  EOF
}

locals {
  gcp_project        = "data-sandbox-dmql-sgxt7g"
  gcp_region         = "me-central2"
  gcp_zone           = "me-central2-a"
  gcp_project_number = "955649792918"
}
