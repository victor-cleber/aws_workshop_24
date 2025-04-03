variable "region" {
  type        = string
  description = "AWS region where the infrastructure will be created"
  default     = "us-east-1"
  #default    = "ap-southeast-2"
}

variable "vpc_name" {
  type        = string
  description = "AWS vpc name"
  default     = "workshop_24"
}

variable "vpc_cidr" {
  type    = string
  default = "100.64.0.0/16"
}

variable "workshop_edition" {
  type    = string
  default = "workshop_24"
}

variable "author" {
  type    = string
  default = "Victor Cleber"
}

variable "group" {
  type    = string
  default = "Group 1"
}

variable "managed_by" {
  type    = string
  default = "terraform"
}

variable "subject" {
  type    = string
  default = "PHP Web App"
}

variable "course" {
  type    = string
  default = "Cloud Training - AWS bootcamp"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "web_server" {
  description = "PHP Web instance name"
  type        = string
  default     = "web_app"
}

variable "jh_server" {
  description = "Jump Host instance name"
  type        = string
  default     = "jh_host"
}