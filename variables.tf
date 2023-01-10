variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "AppServerInstance"
}
variable "instance_type" {
  description = "Value of the instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_ami" {
  description = "Value of the instance type for the EC2 instance"
  type        = string
  default     = "ami-830c94e3"
}