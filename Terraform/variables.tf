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
