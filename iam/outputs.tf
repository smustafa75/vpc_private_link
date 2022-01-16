output "iam_role" {
  value = aws_iam_role.ec2_access_role.name
}
output "iam_role_arn" {
  value = aws_iam_role.ec2_access_role.arn
}
output "iam_instance_profile_arn" {
  value = aws_iam_instance_profile.iam_profile.name
}


