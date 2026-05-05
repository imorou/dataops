# Security Group for Database
# Controls who can access the RDS instance
resource "aws_security_group" "db_sg" {
  name        = "fluxio-db-sg"
  description = "Allow inbound PostgreSQL traffic"
  vpc_id      = aws_vpc.main.id

  # Inbound rule: Allow PostgreSQL (5432)
  # Replace 0.0.0.0/0 with your specific IP for better security later
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Outbound rule: Allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fluxio-db-security-group"
  }
}
