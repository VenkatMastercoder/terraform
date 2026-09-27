resource "aws_instance" "aws_instance_1" {
  ami           = "ami-0199ac7c9fbf9ed83"
  instance_type = var.instance_type

  tags = {
    Name = "terraform-ec2"
  }
}