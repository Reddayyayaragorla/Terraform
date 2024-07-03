variable "Public_Subnet_cidrs" {
      type = list(string)
      description ="Public-subent-cidr-valus"
      default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

variable "Private_Subnet_cidrs"{
      type = list(string)
      description ="Private-subnest-cidrs"
      default = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
}
