output "amiLinuxVirginia" {
  value = data.aws_ssm_parameter.linuxAmi
}

output "amiLinuxOregon" {
  value = data.aws_ssm_parameter.linuxAmiOregon
}

output "Jenkins-Main-Node-Public-IP" {
  value = aws_instance.jenkins-master.public_ip
}

output "Jenkins-Worker-Public-IPs" {
  value = {
    for instance in aws_instance.jenkins-worker-oregon :
    instance.id => instance.public_ip
  }
}

output "Jenkins-Worker-Private-IPs" {
  value = {
    for instance in aws_instance.jenkins-worker-oregon :
    instance.id => instance.private_ip
  }
}

output "LB-DNS-NAME" {
  value = aws_lb.application-lb.dns_name
}

