output "amiLinuxVirginia" {
  value = data.aws_ssm_parameter.linuxAmi
}

output "amiLinuxOregon" {
  value = data.aws_ssm_parameter.linuxAmiOregon
}
