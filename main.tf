

# 2. VPC Creation (Virtual Private Cloud)
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "Fluxio-VPC"
    Project = "DataOps"
  }
}

# 3. Public Subnet creation (for testing purposes)
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "Fluxio-Public-Subnet"
  }
}

# 4. Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Fluxio-IGW"
  }
}

# 5. Route Table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # All traffic
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "Fluxio-Public-RT"
  }
}

# 6. Route Table Association
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# 8. Second subnet for RDS (Required for Subnet Group)
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1b" # Different zone

  tags = {
    Name = "Fluxio-Private-Subnet-2"
  }
}

# 9. RDS Subnet Group
resource "aws_db_subnet_group" "main_db_subnet_group" {
  name       = "fluxio-db-subnet-group"
  subnet_ids = [aws_subnet.public_subnet.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "Fluxio DB Subnet Group"
  }
}
# 10. RDS PostgreSQL Instance
resource "aws_db_instance" "postgres_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "16"
  instance_class       = "db.t3.micro"
  db_name              = "fluxiodb"
  username             = "toureadmin"
  password             = aws_secretsmanager_secret_version.db_password_val.secret_string  # À changer plus tard via Secret Manager
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true
  publicly_accessible  = false # Sécurité maximale
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main_db_subnet_group.name

  tags = {
    Name = "Fluxio-Postgres"
  }
}

# 11. Création du Secret dans Secrets Manager
resource "aws_secretsmanager_secret" "db_password_secret" {
  name        = "fluxio/rds/main_password_v2" # Nom unique du secret
  description = "Mot de passe principal pour la base RDS Fluxio"
  
  tags = {
    Project = "DataOps"
  }
}

# 12. Stockage de la valeur du mot de passe
resource "aws_secretsmanager_secret_version" "db_password_val" {
  secret_id     = aws_secretsmanager_secret.db_password_secret.id
  secret_string = "DataOps2026!Master" # Ton mot de passe sécurisé ici
}
