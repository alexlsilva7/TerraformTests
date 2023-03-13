resource "aws_key_pair" "key" {
  key_name   = "aws-vm-key"
  public_key = file("./aws-vm-key.pub")
}

resource "aws_instance" "vm" {
  ami           = "ami-005f9685cb30f234b"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name
  subnet_id     = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids = [
    data.terraform_remote_state.vpc.outputs.security_group_id
  ]
  associate_public_ip_address = true

  tags = {
    Name = "aws-vm"
  }

  user_data = file("./user-data.sh")
}