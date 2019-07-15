variable "resource_group_name" {
  type        = string
  description = "The resource group where the resources should be created."
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "The azure datacenter location where the resources should be created."
}

variable "name" {
  description = "The name for the function app. Without environment naming."
}

variable "app_service_plan_id" {
  type        = string
  default     = ""
  description = "The ID of an existing app service plan to use for the Function App."
}

variable "sku" {
  type        = string
  default     = "Basic_B1"
  description = "The SKU of an app service plan to create for the Function App."
}

variable "runtime_version" {
  default     = "~2"
  description = "The runtime version the function app should have."
}

variable "always_on" {
  type        = bool
  default     = true
  description = "Either `true` to ensure the web app gets loaded all the time, or `false` to to unload after being idle."
}

variable "https_only" {
  type        = bool
  default     = true
  description = "Redirect all traffic made to the web app using HTTP to HTTPS."
}

variable "client_affinity_enabled" {
  type        = bool
  default     = false
  description = "Either `true` to enables sending session affinity cookies, or `false` to disable it."
}

variable "app_settings" {
  type        = map(string)
  default     = {}
  description = "Application settings to insert on creating the function app. Following updates will be ignored, and has to be set manually. Updates done on application deploy or in portal will not affect terraform state file."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}
