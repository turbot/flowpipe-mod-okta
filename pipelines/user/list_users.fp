pipeline "list_users" {
  title       = "List Users"
  description = "Lists all users that do not have a status of 'DEPROVISIONED'."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  step "http" "list_users" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/users?limit=200"

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
    description = "List of active users."
    value       = flatten([for entry in step.http.list_users : entry.response_body])
  }
}
