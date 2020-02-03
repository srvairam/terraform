variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}


variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AWS_AZ1" {
  default = "us-east-1a"
}

variable "AWS_AZ2" {
  default = "us-east-1b"
}


variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-062f7200baf2fa504 "
    us-west-2 = "ami-04590e7389a6e577c"    
  }
}

variable "EC2_INSTANCE_CLASS" {
  default = "db.t2.micro"
}


variable "DB_INSTANCE_CLASS" {
  default = "db.t2.micro"
}

variable "RDS_PASSWORD" {
  default = "admin123"
}

variable "VPC_CIDR" {
  default = "10.0.0.0/16"
}

variable "PUB_CIDR" {
  default = "10.0.1.0/24"
}

variable "PVT_CIDR" {
  
  default = "10.0.4.0/24"
}


variable "PVT2_CIDR" {
  
  default = "10.0.5.0/24"
}
