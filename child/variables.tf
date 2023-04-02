
variable "VPCId" {
  type = string
  default = "vpc-0d90d6d75b774b780"
}

variable "ec2_count" {
  type = number
  default = "1"
}

variable "ec2_availability_zones" {
  type = number
  default = "1"
}

variable "s3_bucket_Name" {
  type = string
  default = "1"
}

variable "ec2_configurations"{
    type = list(object({
        instance_type = string
        ami = string
        name = string
    }))

    validation {
    condition     = length(var.ec2_configurations) > 1
    error_message = "This application requires at least two private subnets."
  }
}

variable "generic_tags"{
    type = object({
    project = string
    code = string
  })
    
    default = {
        project = "test Project"
        code = "comp"
    }
}