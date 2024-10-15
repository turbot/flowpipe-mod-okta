pipeline "list_member_users" {
  title       = "List Member Users"
  description = "Lists all users that are a member of a group."

  param "conn" {
    type        = connection.okta
    description = local.conn_param_description
    default     = connection.okta.default
  }

  param "group_id" {
    type        = string
    description = local.group_id_param_description
  }

  step "http" "list_member_users" {
    method = "get"
    url    = "${param.conn.domain}/api/v1/groups/${param.group_id}/users?limit=1000"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.conn.token}"
    }

    loop {
      until = length(split(",", result.response_headers["Link"])) < 2

      url = regex("<([^>]+)>; rel=\"next\"", element([for s in split(",", result.response_headers["Link"]) : s if strcontains(s, "rel=\"next\"")], 0))[0]
    }
  }

  output "group_members" {
    description = "List of users that are members of the group."
    value       = flatten([for entry in step.http.list_member_users : entry.response_body])
  }
}
