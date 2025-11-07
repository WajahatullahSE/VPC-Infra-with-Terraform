variable "region" {
  type    = string
  default = "us-west-2"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.0.0/24","10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24","10.0.3.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-west-2a","us-west-2b"]
}

variable "env_tag" {
  type    = string
  default = "wu-test"
}

variable "key_name" {
  type    = string
  default = "wu-key"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami_owner" {
  type    = string
  default = "amazon"
}

