pipeline "list_member_users" {
  title       = "List Member Users"
  description = "Lists all users that are a member of a group."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  # TODO: Add pagination once multiple response headers are returned
  step "http" "list_member_users" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/groups/${param.group_id}/users?limit=1000"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }
  }

  output "group_members" {
    description = "List of users that are members of the group."
    value       = step.http.list_member_users.response_body
  }
}
