variable "managed_policies_templates" {
  default = []
}

variable "managed_policies_groups_templates" {
  default = [
    "ReadOnlyAccess",
    "AdministratorAccess",
    "DatabaseAdministrator",
    "SystemAdministrator",
    "NetworkAdministrator",
    "Billing",
    "ViewOnlyAccess",
    "SupportUser",
  ]
}

variable "custom_policies_templates" {
  default = []
}

variable "custom_policies_groups_templates" {
  default = [
    "TerraformBucketReadOnlyAccess",
  ]
}

variable "users_templates" {
  default = []
}