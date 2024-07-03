resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terraform-VPC"
  }
}

data "aws_regions" "current" {
  all_regions = true
}

resource "aws_subnet" "Public-Subnet" {
  count = length(var.Public_Subnet_cidrs)
  vpc_id = "vpc-05554f9b90fbdff36"
  cidr_block = element(var.Public_Subnet_cidrs, count.index)

    tags = {
      Name = "Public-Subnet $(count.index + 1)"

    }
}

resource "aws_subnet" "Private-Subnet" {
  count = length (var.Private_Subnet_cidrs)
  vpc_id = "vpc-05554f9b90fbdff36"
  cidr_block =element(var.Private_Subnet_cidrs, count.index)

    tags = {
      Name = "Private-Subnet $(count.index +1)"

    }
  
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "vpc-05554f9b90fbdff36"

  tags = {
    Name = "Terraform-IGW"
  }
  
}

resource "aws_route_table" "second_route_table" {
  vpc_id = "vpc-05554f9b90fbdff36" 
  
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-0d8d596219dd6479d"
  }

  tags = {
    name = "2nd Internet_Gateway"
  }
}

resource "aws_route_table_association" "public_subnets_asso" {
  count = length(var.Public_Subnet_cidrs)
  subnet_id = element(aws_subnet.Public-Subnet[*].id, count.index)
  route_table_id = aws_route_table.second_route_table.id
   
}

