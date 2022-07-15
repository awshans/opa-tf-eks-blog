package terraform.allowed_resources

import input as tfplan

# Allowed Terraform resources
allowed_resources = [
  #For Network
  "aws_subnet",
  "aws_route_table_association",
  "aws_route_table",
  "aws_route",
  #"aws_nat_gateway",
  "aws_eip",
  "aws_security_group",
  #"aws_vpc",
  "aws_internet_gateway",
  "aws_default_security_group",
  "aws_default_route_table",
  "aws_default_network_acl",
  #For Backups
  "aws_kms_key",
  "aws_kms_alias",
  "aws_backup_plan",
  "aws_backup_selection",
  "aws_backup_vault",
  #IAM 
  "aws_iam_policy",
  "aws_iam_role",
  "aws_iam_role_policy_attachment",
  "aws_iam_instance_profile",
  "aws_eks_node_group",
  "aws_security_group_rule",
  #EKS
  "helm_release",
  "kubernetes_namespace_v1",
  "aws_iam_openid_connect_provider",
  "aws_eks_cluster",
  "aws_ec2_tag",
  "kubernetes_config_map",
  "kubernetes_service_account_v1",
  #Database
  "aws_ssm_parameter",
  "aws_rds_cluster_parameter_group", 
  "aws_rds_cluster_instance",
  "aws_rds_cluster",
  "aws_db_subnet_group", 
  "aws_db_parameter_group",
  "random_password",
  "random_id"
]


array_contains(arr, elem) {
  arr[_] = elem
}

deny[reason] {
    resource := tfplan.resource_changes[_]
    action := resource.change.actions[count(resource.change.actions) - 1]
    array_contains(["create", "update"], action)  # allow destroy action

    not array_contains(allowed_resources, resource.type)

    reason := sprintf(
        "%s: resource type %q is not allowed",
        [resource.address, resource.type]
    )
}
