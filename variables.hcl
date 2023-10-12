variable "okta_domain" {
  type        = string
  description = "The URL of the Okta domain. Exmaple1: 'https://dev-50078045.okta.com'"
  default     = ""
}

variable "token" {
  type        = string
  description = "The Okta personal access token to authenticate to the okta APIs, e.g., '00B630jSCGU4jV4o5Yh4KQMAdqizwE2OgVcS7N9UHb'. Please see https://developer.okta.com/docs/guides/create-an-api-token/main/#oauth-2-0-instead-of-api-tokens for more information."
  default     = null
}