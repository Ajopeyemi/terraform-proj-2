resource "aws_vpc" "nov-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "nov-vpc"
  }
}

# public subnets
resource "aws_subnet" "Prod-pub-sub1" {
  vpc_id     = aws_vpc.nov-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "pub-sub1"
  }
}

resource "aws_subnet" "Prod-pub-sub2" {
  vpc_id     = aws_vpc.nov-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "pub-sub2"
  }
}

# private subnets
resource "aws_subnet" "Prod-priv-sub1" {
  vpc_id     = aws_vpc.nov-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "priv-sub1"
  }
}

resource "aws_subnet" "Prod-priv-sub2" {
  vpc_id     = aws_vpc.nov-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "priv-sub2"
  }
}

# public route table
resource "aws_route_table" "Prod-pub-route-table" {
  vpc_id = aws_vpc.nov-vpc.id

  tags = {
    Name = "public-RT"
  }
}

# private route table
resource "aws_route_table" "Prod-priv-route-table" {
  vpc_id = aws_vpc.nov-vpc.id

  tags = {
    Name = "private-RT"
  }
}

# public route association
resource "aws_route_table_association" "Pulic-RTA" {
  subnet_id      = aws_subnet.Prod-pub-sub1.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}

resource "aws_route_table_association" "Pulic-RTA-2" {
  subnet_id      = aws_subnet.Prod-pub-sub2.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}

# private route association
resource "aws_route_table_association" "Private-RTA" {
  subnet_id      = aws_subnet.Prod-priv-sub1.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

resource "aws_route_table_association" "Private-RTA-2" {
  subnet_id      = aws_subnet.Prod-priv-sub2.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

# internet gateway
resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.nov-vpc.id

  tags = {
    Name = "igw"
  }
}

# internet gateway association with public route table
resource "aws_route" "Prod-igw-association" {
  route_table_id            = aws_route_table.Prod-pub-route-table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.Prod-igw.id

}


# allocate elastic ip address
resource "aws_eip" "eip-for-nat-gateway" {
  domain   = "vpc"
}

# create nat gateway
 resource "aws_nat_gateway" "Prod-Nat-gateway" {
 allocation_id = aws_eip.eip-for-nat-gateway.id
 subnet_id = aws_subnet.Prod-priv-sub1.id
  tags = {
    Name = "Prod-Nat-gateway"
  }
 }