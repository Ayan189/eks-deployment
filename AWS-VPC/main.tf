resource "aws_vpc" "main" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = var.vpc_instance_tenancy
  enable_dns_support               = var.vpc_enable_dns_support
  enable_dns_hostnames             = var.vpc_enable_dns_hostnames
  assign_generated_ipv6_cidr_block = var.vpc_assign_generated_ipv6_cidr_block

  tags = var.vpc_tags
}

#IGW

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = var.internet_gateway_tags
}

#SUBNET
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_public_1
  availability_zone       = var.subnet_availability_zone_public_1
  map_public_ip_on_launch = var.subnet_map_public_ip_on_launch

  tags = merge(
    {
      Name = "public_us_east_1a"
    },
    var.subnet_pub_tags
  )
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_public_2
  availability_zone       = var.subnet_availability_zone_public_2
  map_public_ip_on_launch = var.subnet_map_public_ip_on_launch

  tags = merge(
    {
      Name = "public_us_east_1b"
    },
    var.subnet_pub_tags
  )
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_private_1
  availability_zone = var.subnet_availability_zone_private_1

  tags = merge(
    {
      Name = "private_us_east_1a"
    },
    var.subnet_pri_tags
  )
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_private_2
  availability_zone = var.subnet_availability_zone_private_2

  tags = merge(
    {
      Name = "private_us_east_1b"
    },
    var.subnet_pri_tags
  )
}

#NAT

resource "aws_eip" "Eip1" {
  depends_on = [aws_internet_gateway.gw]

}

resource "aws_eip" "Eip2" {
  depends_on = [aws_internet_gateway.gw]
}


resource "aws_nat_gateway" "NatGateway1" {
  allocation_id = aws_eip.Eip1.id
  subnet_id     = aws_subnet.public_1.id
  tags          = var.nat_gateway_tags_1
}

resource "aws_nat_gateway" "NatGateway2" {
  allocation_id = aws_eip.Eip2.id
  subnet_id     = aws_subnet.public_2.id
  tags          = var.nat_gateway_tags_2
}

#RT

resource "aws_route_table" "Public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.public_route_cidr
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table" "Private_rt1" {
  vpc_id = aws_vpc.main.id
  route  {
    cidr_block = var.private_route_cidr
    gateway_id = aws_nat_gateway.NatGateway1.id
  }
}

resource "aws_route_table" "Private_rt2" {
  vpc_id = aws_vpc.main.id
  route  {
    cidr_block = var.private_route_cidr
    gateway_id = aws_nat_gateway.NatGateway2.id
  }
}

resource "aws_route_table_association" "Public_rt_association1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.Public_rt.id
}

resource "aws_route_table_association" "Public_rt_association2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.Public_rt.id
}

resource "aws_route_table_association" "Private_rt_association1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.Private_rt1.id
}

resource "aws_route_table_association" "Private_rt_association2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.Private_rt2.id
}