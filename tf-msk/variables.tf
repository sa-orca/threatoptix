variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "to-msk-cluster"
}

variable "oidc_arn" {
  default = "arn:aws:iam::956327719689:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/F91B063F4B2E8BDFED054DD64DAB4368"
}

variable "oidc_id" {
  default = "oidc.eks.us-east-1.amazonaws.com/id/F91B063F4B2E8BDFED054DD64DAB4368:sub"
}

variable "eks_namespace" {
  default = "kafka"
}

variable "eks_vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "cluster_name_iam" {
  default = "to-msk-cluster-iam"
}

variable "eks_vpc_id" {
  default = "vpc-0563992318bccf5b6"
}