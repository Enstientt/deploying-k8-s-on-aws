variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "instance_count" {
  description = "Number of instances to create"
  default     = 3
}

variable "instance_type" {
  description = "The type of instance to create"
  default     = "t2.micro"
}