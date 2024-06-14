resource "aws_security_group" "batch-security-group" {
  name        = "batch-security"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = "vpc-0f1137b4737ab703d"

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "batch-security-group-ingress" {
  security_group_id = aws_security_group.batch-security-group.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "batch-security-group-egress" {
  security_group_id = aws_security_group.batch-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
