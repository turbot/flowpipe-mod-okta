pipeline "create_user_assign_to_group" {
  title       = "User Creation and Group Assignment"
  description = "Create a user and assign them to a group."

  param "api_token" {
    type        = string
    description = "The Okta personal access api_token to authenticate to the okta APIs."
    default     = var.api_token
  }

  param "domain" {
    type        = string
    description = "The URL of the Okta domain."
    default     = var.okta_domain
  }

  param "group_id" {
    description = "The ID of a group."
    type        = string
  }

  param "first_name" {
    type        = string
    description = "The first name of the user."
    optional    = true
  }

  param "last_name" {
    type        = string
    description = "The last name of the user."
    optional    = true
  }

  param "email" {
    type        = string
    description = "The email address associated with the user's account."
    optional    = true
  }

  param "login" {
    type        = string
    description = "The username or identifier used for the user to log in."
    optional    = true
  }

  param "mobile_phone" {
    type        = string
    description = "The user's mobile phone number."
    optional    = true
  }

  param "credential_pwd" {
    type        = string
    description = "The user's password for authentication."
    optional    = true
  }

  step "pipeline" "create_user" {
    pipeline = pipeline.create_user
    args = {
      first_name     = param.first_name
      last_name      = param.last_name
      email          = param.email
      login          = param.login
      credential_pwd = param.credential_pwd
    }
  }

  step "http" "create_user_assign_to_group" {
    depends_on = [step.pipeline.create_user]
    method     = "put"
    url        = "${param.domain}/api/v1/groups/${param.group_id}/users/${jsondecode(step.pipeline.create_user.user).id}"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "SSWS ${param.api_token}"
    }
  }

  output "user" {
    description = "User details."
    value       = step.pipeline.create_user.response_body
  }
  output "assignment" {
    description = "Group assignment details for a user."
    value       = step.http.create_user_assign_to_group.response_body
  }
}