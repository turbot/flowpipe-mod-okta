pipeline "list_groups" {
  title       = "List Groups"
  description = "Lists all groups."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  step "http" "list_groups" {
    method = "get"
    url    = "${credential.okta[param.cred].domain}/api/v1/groups?limit=10000"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${credential.okta[param.cred].token}"
    }

    loop {
      until = length(split(",", result.response_headers["Link"])) < 2

      url = regex("<([^>]+)>; rel=\"next\"", element([for s in split(",", result.response_headers["Link"]) : s if strcontains(s, "rel=\"next\"")], 0))[0]
    }
  }

  output "groups" {
    description = "List of groups."
    value       = flatten([for entry in step.http.list_groups : entry.response_body])
  }
}
