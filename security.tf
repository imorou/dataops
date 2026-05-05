resource "aws_security_group" "db_sg_v2" {
  name        = "fluxio-db-sg-v2"
  description = "Allow inbound PostgreSQL traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fluxio-db-security-group-v2"
  }
}
