variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "Public subnet CIDR"
}

variable "ami" {
  type   = string
  default = "ami-04c74730fc7ccdc41"
}

variable "InstanceType" {
  type        = string
  default     = "t3.small"
  description = "instance type"
}

variable KeyPair {
  type        = string
  default     = "CICD-Project"
  description = "Pem file"
}

variable InstanceNames {
  type        = list
  default     = ["Application_Server", "Jenkins_Server"]
  description = "ec2 Instance names"
}


