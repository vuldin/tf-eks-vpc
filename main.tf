resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_subnet" "az" {
  count             = var.az_count*2
  vpc_id            = aws_vpc.main.id
  availability_zone = "${var.region}${var.az_suffixes[count.index%var.az_count]}"
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index+1)

  tags = {
    Name = "${var.project_name}-subnet-${count.index > var.az_count - 1 ? "private" : "public"}${(count.index%var.az_count)+1}-${var.region}${var.az_suffixes[count.index%var.az_count]}"
    "kubernetes.io/cluster/${var.project_name}" = "shared"
    "kubernetes.io/role/${count.index > var.az_count - 1 ? "internal-" : ""}elb" : "1"
  }
}
