provider "aws" {
  region = "us-east-1"
}

locals {
  policy_ref = "v6.8.2"
}

variable "policy_ref" {
  default = "v6.8.2"
}

module "iam_policy_local" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-policy?ref=${local.policy_ref}"

  name   = "policy_local"
  policy = data.aws_iam_policy_document.allow-ro.json
}

module "iam_policy_variable" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-policy?ref=${var.policy_ref}"

  name   = "policy_var"
  policy = data.aws_iam_policy_document.allow-ro.json
}


module "iam_policy_local_in_locals_file" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-policy?ref=${local.policy_ref_in_locals_file}"

  name   = "policy_local_in_locals_file"
  policy = data.aws_iam_policy_document.allow-ro.json
}

module "iam_policy_variable_in_variable_file" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-policy?ref=${var.policy_ref_in_variable_file}"

  name   = "policy_variable_in_variable_file"
  policy = data.aws_iam_policy_document.allow-ro.json
}


data "aws_iam_policy_document" "allow-ro" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:List*",
      "s3:Get*",
    ]
    resources = [
      "*"
    ]
  }
}
