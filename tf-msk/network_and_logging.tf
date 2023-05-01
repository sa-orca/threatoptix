resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/22"
  tags = {
    "Name" = "TO MSK"
  }
}

data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_subnet" "subnet_az1" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  cidr_block        = "10.0.0.0/24"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "SubnetAZ1Private"
  }
}

resource "aws_subnet" "subnet_az2" {
  availability_zone = data.aws_availability_zones.azs.names[1]
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "SubnetAZ2Private"
  }
}

resource "aws_subnet" "subnet_az3" {
  availability_zone = data.aws_availability_zones.azs.names[2]
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "SubnetAZ3Private"
  }
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "sg_kms_2181" {
  type      = "ingress"
  from_port = 2181
  to_port   = 2181
  protocol  = "tcp"
  cidr_blocks = [
    var.eks_vpc_cidr
  ]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "sg_kms_2182" {
  type      = "ingress"
  from_port = 2182
  to_port   = 2182
  protocol  = "tcp"
  cidr_blocks = [
    var.eks_vpc_cidr
  ]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "sg_kms_9092" {
  type      = "ingress"
  from_port = 9092
  to_port   = 9092
  protocol  = "tcp"
  cidr_blocks = [
    var.eks_vpc_cidr
  ]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "sg_kms_9094" {
  type      = "ingress"
  from_port = 9094
  to_port   = 9094
  protocol  = "tcp"
  cidr_blocks = [
    var.eks_vpc_cidr
  ]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "sg_kms_9096" {
  type      = "ingress"
  from_port = 9096
  to_port   = 9096
  protocol  = "tcp"
  cidr_blocks = [
    var.eks_vpc_cidr
  ]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "sg_kms_9098" {
  type      = "ingress"
  from_port = 9098
  to_port   = 9098
  protocol  = "tcp"
  cidr_blocks = [
    var.eks_vpc_cidr
  ]
  security_group_id = aws_security_group.sg.id
}

resource "aws_kms_key" "kms" {
  description = "TO MSK"
}

resource "aws_cloudwatch_log_group" "aws_cloudwatch_log_group" {
  name = "msk_broker_logs"
}