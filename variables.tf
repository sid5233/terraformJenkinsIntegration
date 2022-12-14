variable "vpc_cidr" {
  description = "Choose cidr for VPC"
  type = string
  default = "10.20.0.0/16"
}

variable "region" {
  description = "choose regin stack"
  type = string
  default = "us-east-1"
}

variable "tenancy" {
  default = "default"
}
