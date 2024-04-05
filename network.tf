resource "aws_vpc" "hkt_vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "hkt_vpc",
    Project = "vpb_hackathon",
  }
}

resource "aws_subnet" "hkt_one" {
  vpc_id            = aws_vpc.hkt_vpc.id
  cidr_block        = "10.0.0.0/25"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "hkt_one",
    Project = "vpb_hackathon",
  }
}

resource "aws_subnet" "hkt_two" {
  vpc_id            = aws_vpc.hkt_vpc.id
  cidr_block        = "10.0.0.128/25"
  availability_zone = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "hkt_two",
    Project = "vpb_hackathon",
  }
}

resource "aws_internet_gateway" "hkt_public_access_igw" {
  vpc_id = aws_vpc.hkt_vpc.id

  tags = {
    Name = "hkt_public_access_igw",
    Project = "vpb_hackathon",
  }
}

resource "aws_route" "hkt_public_access_route_table" {
  route_table_id         = aws_vpc.hkt_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.hkt_public_access_igw.id
}