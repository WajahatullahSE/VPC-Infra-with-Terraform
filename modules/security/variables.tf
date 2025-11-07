variable "vpc_id" { type = string }
variable "env_tag" { type = string }
variable "my_ip" { 
    type = string 
    default = "0.0.0.0/0" 
} # replace in terraform.tfvars with your IP CIDR (/32)

