
# Variables

variable "project_id" {
  description = "Project id to deploy the application to."
  type        = string
}

variable "add_user" {
  description = "User to add as editor to the project."
  type        = string
}

# Resources

resource "google_project_iam_member" "member-role" {
  for_each = toset([
    "roles/editor",
    "roles/apigee.admin"
  ])
  role = each.key
  member = "user:${var.add_user}"
  project = module.project.project_id
}