resource "aws_instance" "aws_instance_1" {
  ami           = "ami-0199ac7c9fbf9ed83"
  instance_type = var.instance_type

  tags = {
    Name = "terraform-Ubuntu-Server"
  }
}

resource "aws_instance" "aws_instance_2" {
  ami           = "ami-017d8f0ae2698d82d"
  instance_type = var.instance_type

  tags = {
    Name = "terraform-Windows-Server"
  }
}

resource "aws_instance" "aws_instance_3" {
  ami           = "ami-02e3c96eaee2fe306"
  instance_type = var.instance_type

  tags = {
    Name = "terraform-Redhat-Server"
  }
}