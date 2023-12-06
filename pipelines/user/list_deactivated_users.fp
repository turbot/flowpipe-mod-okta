pipeline "list_deactivated_users" {
  title       = "List Deactivated Users"
  description = "Lists all users that have a status of 'DEPROVISIONED'."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  step "http" "list_deactivated_users" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/users?filter=status+eq+%22DEPROVISIONED%22&limit=200"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }

    loop {
      until = length(split(",", result.response_headers["Link"])) < 2

      url = regex("<([^>]+)>; rel=\"next\"", element([for s in split(",", result.response_headers["Link"]) : s if strcontains(s, "rel=\"next\"")], 0))[0]
    }
  }

  output "users" {
    description = "List of deactivated users."
    value       = flatten([for entry in step.http.list_deactivated_users : entry.response_body])
  }
}
