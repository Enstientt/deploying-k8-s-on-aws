provider "aws" {
  region = "us-east-1" # Specify your preferred region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

# Create a Subnet for All Instances
resource "aws_subnet" "app_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24" # Using a single subnet for all instances

  map_public_ip_on_launch = true

  tags = {
    Name = "app-subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Create a Route Table for the Subnet
resource "aws_route_table" "app_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "app-route-table"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "app_route_table_association" {
  subnet_id      = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.app_route_table.id
}

# Create a Security Group for All Instances
resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.main.id
#worker1@10.0.1.35 / worker210.0.1.206
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (for testing, you can restrict later)
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Allow ping within the subnet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}

# Create EC2 Instances in the Subnet
resource "aws_instance" "app" {
  count         = 3
  ami           = "ami-0e86e20dae9224db8" # Use an appropriate AMI ID for your region
  instance_type = "t2.medium"

  subnet_id              = aws_subnet.app_subnet.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "Instance-${count.index + 1}"
  }

  key_name = "id_rsa" # Ensure you have this key pair in your AWS account
}
