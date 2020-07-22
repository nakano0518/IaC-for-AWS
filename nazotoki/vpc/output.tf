output "vpc_id" {
  value = aws_vpc.nazotoki.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_2.id
}

output "security_group_db_id" {
  value = aws_security_group.db.id
}

output "security_group_app_id" {
  value = aws_security_group.app.id
}

output "security_group_alb_id" {
  value = aws_security_group.alb.id
}