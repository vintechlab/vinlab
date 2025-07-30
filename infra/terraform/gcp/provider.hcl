generate "provider_gcp" {
  path      = "generated_provider_gcp.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "google" {
      region      = local.gcp_region
      project     = local.gcp_project
      credentials = fileexists("/secrets/.gcp/sva-$${local.gcp_project}.json") ? file("/secrets/.gcp/sva-$${local.gcp_project}.json") : null
    }
    provider "google-beta" {
      region      = local.gcp_region
      project     = local.gcp_project
      credentials = fileexists("/secrets/.gcp/sva-$${local.gcp_project}.json") ? file("/secrets/.gcp/sva-$${local.gcp_project}.json") : null
    }
  EOF
}
