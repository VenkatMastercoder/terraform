output "ec2_instance_name" {
  value = aws_instance.aws_instance_1.id
}

output "ec2_instance_name_2" {
  value = aws_instance.aws_instance_2.id
}

output "ec2_instance_name_3" {
  value = aws_instance.aws_instance_3.arn
}