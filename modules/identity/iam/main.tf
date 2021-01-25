#--------------------------------------------------------------
#  IAM templates module 
#--------------------------------------------------------------

module "iam_templates" {
  source                            = "/home/gabo/github.com/aguamala/terraform-aws-iam-templates/"
  managed_policies_templates        = "${var.managed_policies_templates}"
  managed_policies_groups_templates = "${var.managed_policies_groups_templates}"
  custom_policies_templates         = "${var.custom_policies_templates}"
  custom_policies_groups_templates  = "${var.custom_policies_groups_templates}"
  users_templates                   = "${var.users_templates}"
}