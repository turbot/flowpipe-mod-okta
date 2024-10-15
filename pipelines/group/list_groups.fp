pipeline "list_groups" {
  title       = "List Groups"
  description = "Lists all groups."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  step "http" "list_groups" {
    method = "get"
    url    = "${param.conn.domain}/api/v1/groups?limit=10000"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
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
