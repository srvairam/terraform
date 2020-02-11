resource "aws_security_group" "public-sg" {
  vpc_id      = aws_vpc.main-terrraform-vpc.id
  name        = "public-sg"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "public-sg"
  }
}


resource "aws_security_group" "rds-sg" {
  vpc_id      = aws_vpc.main-terrraform-vpc.id
  name        = "rds-sg"
  description = "security group that allows RDS Secure access"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"] incase if you struggle to access RDS, remove below line and uncomment this line.
	security_groups = [aws_security_group.public-sg.id] # allowing access from our example instance
  }
  tags = {
    Name = "my-rds-sg"
  }
}

