locals {
  user_common_param = {
    first_name   = "firstName"
    last_name    = "lastName"
    email        = "email"
    login        = "login"
    mobile_phone = "mobilePhone"
  }

  application_common_param = {
    name         = "name"
    label        = "label"
    sign_on_mode = "signOnMode"
    status       = "status"
  }
}

# Common descriptions
locals {
  api_token_param_description      = "The personal api_token to authenticate to the Okta APIs."
  domain_param_description         = "The domain of your Okta account."
  group_id_param_description       = "The ID of the group."
  application_id_param_description = "Application ID."
  user_id_param_description        = "The unique key for the user."
}