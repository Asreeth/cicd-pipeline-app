provider "aws" {
    region = "ap-south-2"
}

resource "aws_vpc" "vpc"{
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "Project VPC"
    }
}

resource "aws_subnet" "public_subnets"{
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.vpc.id
    cidr_block= element(var.public_subnet_cidrs, count.index)
    map_public_ip_on_launch = true

    tags = {
        Name = "Public Subnet ${count.index + 1}"
    }
}

resource "aws_internet_gateway" "gateway"{
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "Project VPC IG"
    }
}

resource "aws_route_table" "route_table"{
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
    }

    tags = {
        Name = "Project VPC Route table"
    }
}

resource "aws_route_table_association" "Public_subnet_asso" {
    count = length(var.public_subnet_cidrs)
    subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
    route_table_id = aws_route_table.route_table.id
}
