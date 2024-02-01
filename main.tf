resource "aws_vpc" "project-expansion" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "project_expansion"
  }
}

# public subnets
resource "aws_subnet" "Public-subnet-expansion-1" {
  vpc_id     = aws_vpc.project-expansion.id
  cidr_block = var.public_subnet_cidr_1

  tags = {
    Name = "pub-sub-expansion-1"
  }
}

resource "aws_subnet" "Public-subnet-expansion-2" {
  vpc_id     = aws_vpc.project-expansion.id
  cidr_block = var.public_subnet_cidr_2

  tags = {
    Name = "pub-sub-expansion-2"
  }
}

# private subnets
resource "aws_subnet" "Private-subnet-expansion-1" {
  vpc_id     = aws_vpc.project-expansion.id
  cidr_block = var.private_subnet_cidr_1

  tags = {
    Name = "priv-sub-expansion-1"
  }
}

resource "aws_subnet" "Private-subnet-expansion-2" {
  vpc_id     = aws_vpc.project-expansion.id
  cidr_block = var.private_subnet_cidr_2

  tags = {
    Name = "priv-sub-expansion-2"
  }
}

# public route tables
resource "aws_route_table" "public-RT1" {
  vpc_id = aws_vpc.project-expansion.id

  tags = {
    Name = "public-RT1"
  }
}

resource "aws_route_table" "public-RT2" {
  vpc_id = aws_vpc.project-expansion.id

  tags = {
    Name = "public-RT2"
  }
}
# private route tables
resource "aws_route_table" "private-RT1" {
  vpc_id = aws_vpc.project-expansion.id

  tags = {
    Name = "private-RT1"
  }
}

resource "aws_route_table" "private-RT2" {
  vpc_id = aws_vpc.project-expansion.id

  tags = {
    Name = "private-RT2"
  }
}
# public route association
resource "aws_route_table_association" "Pulic-RTA-1" {
  subnet_id      = aws_subnet.Public-subnet-expansion-1.id
  route_table_id = aws_route_table.public-RT1.id
}

resource "aws_route_table_association" "Pulic-RTA-2" {
  subnet_id      = aws_subnet.Public-subnet-expansion-2.id
  route_table_id = aws_route_table.public-RT2.id
}

# private route association
resource "aws_route_table_association" "Private-RTA-1" {
  subnet_id      = aws_subnet.Private-subnet-expansion-1.id
  route_table_id = aws_route_table.private-RT1.id
}

resource "aws_route_table_association" "Private-RTA-2" {
  subnet_id      = aws_subnet.Private-subnet-expansion-2.id
  route_table_id = aws_route_table.private-RT2.id
}

# internet gateway
resource "aws_internet_gateway" "igw-project-expansion" {
  vpc_id = aws_vpc.project-expansion.id

  tags = {
    Name = "igw"
  }
}

# internet gateway association with the public route tables
resource "aws_route" "igw-association-1" {
  route_table_id            = aws_route_table.public-RT1.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw-project-expansion.id

}

resource "aws_route" "igw-association-2" {
  route_table_id            = aws_route_table.public-RT2.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw-project-expansion.id

}
