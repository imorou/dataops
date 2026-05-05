# Security Group for Database
# Controls who can access the RDS instance
resource "aws_security_group" "db_sg" {
  name        = "fluxio-db-sg"
  description = "Allow inbound PostgreSQL traffic"
  vpc_id      = aws_vpc.main_vpc.id # Corrigé pour correspondre à main_vpc

  # Inbound rule: Allow PostgreSQL (5432)
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
