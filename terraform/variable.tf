variable "ami" {
  default = "ami-0078a63645c7b8a87" #Amazon Linux 2 AMI (HVM), SSD Volume Type for us-east-1
  description = "The AMI ID for the EC2 instance"
  type = string
}

variable "inst-type" {
  default = "m7i-flex.large"
  description = "The instance type for the EC2 instance"
  type = string
}