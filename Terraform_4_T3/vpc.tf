resource "aws_vpc" "T3_VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "T3_VPC"
  }
}

resource "aws_subnet" "T3_SUBNET" {
  vpc_id     = aws_vpc.T3_VPC.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "T3_IGW" {
  vpc_id = aws_vpc.T3_VPC.id

  tags = {
    Name = "T3_IGW"
  }
}

resource "aws_route_table" "T3_RT" {
  vpc_id = aws_vpc.T3_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.T3_IGW.id
  }

  tags = {
    Name = "T3_RT"
  }

}

resource "aws_route_table_association" "T3_RTA" {
  subnet_id      = aws_subnet.T3_SUBNET.id
  route_table_id = aws_route_table.T3_RT.id
}