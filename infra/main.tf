terraform {
  required_version = ">=1.8.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.1.0"
    }
  }
}
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      workshop   = var.workshop_edition
      managed_by = var.managed_by
      author     = var.author
      group      = var.group
      course     = var.course
      subject    = var.subject
    }
  }
}

