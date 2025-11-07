variable "vpc_id" { type = string }
variable "route_table_ids" { type = list(string) }
variable "env_tag" { type = string }
variable "region" { 
    type = string 
    default = "us-west-2" 
}

