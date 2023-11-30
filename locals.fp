locals {
  user_common_param = {
    email        = "email"
    first_name   = "firstName"
    last_name    = "lastName"
    login        = "login"
    mobile_phone = "mobilePhone"
  }

  application_common_param = {
    label        = "label"
    name         = "name"
    sign_on_mode = "signOnMode"
    status       = "status"
  }
}

# Common descriptions
locals {
  api_token_param_description      = "The personal api_token to authenticate to the Okta APIs."
  application_id_param_description = "Application ID."
  domain_param_description         = "The domain of your Okta account."
  group_id_param_description       = "The ID of the group."
  user_id_param_description        = "The unique key for the user."
}
