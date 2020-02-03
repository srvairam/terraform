resource "aws_key_pair" "myaccesskey" {
  key_name   = "myaccesskey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

