
# Variables

variable "project_id" {
  description = "Project id to deploy the application to."
  type        = string
}

variable "billing_account" {
  description = "Billing account id."
  type        = string
  default     = null
}

variable "project_parent" {
  description = "Parent folder or organization in 'folders/folder_id' or 'organizations/org_id' format."
  type        = string
  default     = null
  validation {
    condition     = var.project_parent == null || can(regex("(organizations|folders)/[0-9]+", var.project_parent))
    error_message = "Parent must be of the form folders/folder_id or organizations/organization_id."
  }
}

variable "project_create" {
  description = "Create project. When set to false, uses a data source to reference existing project."
  type        = bool
  default     = false
}

variable "add_user" {
  description = "User to add as editor to the project."
  type        = string
}
# Resources

# Project
module "project" {
  source          = "github.com/terraform-google-modules/cloud-foundation-fabric//modules/project?ref=v15.0.0"
  name            = var.project_id
  parent          = var.project_parent
  billing_account = var.billing_account
  project_create  = var.project_create
  services = [
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "compute.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudscheduler.googleapis.com",
    "run.googleapis.com",
    "bigquery.googleapis.com",
    "apigee.googleapis.com",
    "integrations.googleapis.com",
    "connectors.googleapis.com",
    "cloudkms.googleapis.com",
    "secretmanager.googleapis.com"
  ]
  policy_boolean = {
    "constraints/compute.requireOsLogin" = false
    "constraints/compute.requireShieldedVm" = false
  }
  policy_list = {
    "constraints/iam.allowedPolicyMemberDomains" = {
        inherit_from_parent: false
        status: true
        suggested_value: null
        values: [],
        allow: {
          all=true
        }
    },
    "constraints/compute.vmExternalIpAccess" = {
        inherit_from_parent: false
        status: true
        suggested_value: null
        values: [],
        allow: {
          all=true
        }
    }
  }
}

resource "time_sleep" "wait" {
  depends_on = [module.project]

  create_duration = "120s"
}

resource "google_project_iam_member" "member-role" {
  for_each = toset([
    "roles/editor",
    "roles/apigee.admin"
  ])
  role = each.key
  member = "user:${var.add_user}"
  project = module.project.project_id
  depends_on = [ time_sleep.wait ]
}