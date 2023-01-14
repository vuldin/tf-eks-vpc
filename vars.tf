# see terraform.tfvars for default values

variable "az_count" {
  type = number
  validation {
    condition     = var.az_count < 4
    error_message = "az_count must be less than 4"
  }
}

variable "az_suffixes" {
  type    = list(string)
  default = ["a", "b", "c"]
}

#variable "availability_zones" {
#  description = "A list of availability zones in which to create subnets"
#  type        = list(string)
#  default     = ["test1", "test2", "test3"]
#}

variable "cidr_block" {
  type = string
}

variable "project_name" {
  type = string
}

variable "region" {
  type = string
}
