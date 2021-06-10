variable "profile" {
  type    = string
  default = "ACG"
}

variable "region-masterjenkins" {
  type    = string
  default = "us-east-1"
}
variable "region-slavesjenkins" {
  type    = string
  default = "us-west-2"
}
variable "external_ip" {
  type    = string
  default = "191.98.77.34/32"
}

variable "workers-count" {
  type    = number
  default = 2
}

variable "instance-type" {
  type    = string
  default = "t3.micro"
}

variable "webserver-port" {
  type    = number
  default = 80
}

variable "dns-name" {
  type    = string
  default = "sysops.com.co"
}
