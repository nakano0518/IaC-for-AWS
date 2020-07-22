resource "aws_security_group" "db" {
  name        = "nazotoki_db"
  description = "It is a security group on db"
  vpc_id      = aws_vpc.nazotoki.id
}

resource "aws_security_group_rule" "ingress" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app.id
  security_group_id        = aws_security_group.db.id
}
