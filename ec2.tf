resource "aws_instance" "public_ec2" {
  ami           = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro"

  tags = {
    Name = "public_ec2"
  }
}

# creating key pair

resource "aws_key_pair" "TF_key" {
  key_name = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "TF_key" {
  content = tls_private_key.rsa.private_key_pem
  filename = "TFkey"
}
# creating scurity groups
resource "aws_security_group" "expansion_SG" {
  name        = "security group using terraform"
  description = "security group using terraform"
  vpc_id      = aws_vpc.project-expansion.id

  tags = {
    Name = "expansion_SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "HTTP" {
  security_group_id = aws_security_group.expansion_SG.id
  cidr_ipv4         = aws_vpc.project-expansion.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "SSH" {
  security_group_id = aws_security_group.expansion_SG.id
  cidr_ipv4         = aws_vpc.project-expansion.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.expansion_SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.expansion_SG.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}