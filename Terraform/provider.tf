provider "aws" {
  profile = var.profile
  region  = var.region-masterjenkins
  alias   = "region-master"
}

provider "aws" {
  profile = var.profile
  region  = var.region-slavesjenkins
  alias   = "region-workers"
}

