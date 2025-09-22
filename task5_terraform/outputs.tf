output "ec2_public_ip" {
  value = aws_instance.zconviction.public_ip
}
