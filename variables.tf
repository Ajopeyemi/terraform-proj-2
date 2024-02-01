variable "vpc_cidr" {
    description = "vpc cidr"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr_1" {
    description = "public subnet cidr 1"
    type = string
    default = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
    description = "public subnet cidr 2"
    type = string
    default = "10.0.2.0/24"
}

variable "private_subnet_cidr_1" {
    description = "private subnet cidr 1"
    type = string
    default = "10.0.3.0/24"
}

variable "private_subnet_cidr_2" {
    description = "private subnet cidr 2"
    type = string
    default = "10.0.4.0/24"
}