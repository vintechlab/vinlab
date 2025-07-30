include "parrent" {
  path = find_in_parent_folders()
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

terraform {
  source = "https://github.com/terraform-google-modules/terraform-google-network?ref=v8.1.0"
}

inputs = {
  project_id = include.env.locals.gcp_project
  network_name = "dwh-sandbox"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name = "dwh-pcs-consumer"
      subnet_ip = "10.90.0.0/26"
      subnet_region = include.env.locals.gcp_region
      subnet_private_access = "true"
      subnet_flow_logs = "true"
    },
    {
      subnet_name = "dwh-dataops"
      subnet_ip = "10.90.1.0/24"
      subnet_region = include.env.locals.gcp_region
      subnet_private_access = "true"
      subnet_flow_logs = "true"
    },
  ]

  routes = [
    {
      name              = "engress-internet"
      description       = "route through IGM to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]

  ingress_rules = [
    {
      name          = "allow-ssh"
      description   = "Allow SSH access on port 22"
      priority      = 1000
      source_ranges = ["0.0.0.0/0"]

      allow = [
        {
          protocol = "tcp"
          ports    = ["22"]
        }
      ]
    },
  ]
}
