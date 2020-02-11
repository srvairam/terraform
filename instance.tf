resource "aws_instance" "terr-ec2-instance" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet to be attached
  subnet_id = aws_subnet.main-public-1.id

  # the security group to be attached
  vpc_security_group_ids = [aws_security_group.public-sg.id]

  # the public SSH key ssh to access the server
  key_name = aws_key_pair.mykeypair.key_name
  
    tags = {
    Name = "HelloTerraform"
		   }	
  
}

resource "aws_db_instance" "my-test-sql" {
  instance_class          = var.DB_INSTANCE_CLASS
  engine                  = "mysql"
  engine_version          = "5.7"
  multi_az                = "false"
  storage_type            = "gp2"
  allocated_storage       = 20
  name                    = "mytestrds"
  username                = "admin"
  password                = "admin123"
  apply_immediately       = "true"
  backup_retention_period = 10
  backup_window           = "09:46-10:16"
 # db_subnet_group_name    = "${aws_db_subnet_group.my-rds-db-subnet.name}"
 # vpc_security_group_ids  = [aws_security_group.rds-sg.id]
  skip_final_snapshot       = true
}
  