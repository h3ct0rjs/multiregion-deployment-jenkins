#Create and bootstrap EC2 in us-east-1 for jenkins master
resource "aws_instance" "jenkins-master" {
  provider                    = aws.region-master
  ami                         = data.aws_ssm_parameter.linuxAmi.value
  instance_type               = var.instance-type
  key_name                    = aws_key_pair.master-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins-sg.id]
  subnet_id                   = aws_subnet.subnet_1.id

  tags = {
    Name = "jenkins_master_tf"
  }

  depends_on = [aws_main_route_table_association.set-master-default-rt-assoc]
  #Jenkins Master Provisioner:

  provisioner "local-exec" {
    command = <<EOF
        aws --profile ${var.profile} ec2 wait instance-status-ok --region ${var.region-masterjenkins} --instance-ids ${self.id}
        ansible-playbook --key-file="~/.ssh/ACG/id_rsa" --extra-vars 'passed_in_hosts=tag_Name_${self.tags.Name}' ansible_templates/jenkins-master.yml
      EOF
  }
}

#Create EC2 in us-west-2 for jenkins workers.
resource "aws_instance" "jenkins-worker-oregon" {
  provider                    = aws.region-workers
  count                       = var.workers-count
  ami                         = data.aws_ssm_parameter.linuxAmiOregon.value
  instance_type               = var.instance-type
  key_name                    = aws_key_pair.workers-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins-sg-oregon.id]
  subnet_id                   = aws_subnet.subnet_1_oregon.id

  tags = {
    Name = join("_", ["jenkins_worker_tf", count.index + 1])
  }
  depends_on = [aws_main_route_table_association.set-worker-default-rt-assoc, aws_instance.jenkins-master]
  provisioner "local-exec" {
    command = <<EOF
      aws --profile ${var.profile} ec2 wait instance-status-ok --region ${var.region-slavesjenkins} --instance-ids ${self.id}
      ansible-playbook  --key-file="~/.ssh/ACG/id_rsa" --extra-vars 'passed_in_hosts=tag_Name_${self.tags.Name}' ansible_templates/jenkins-worker.yml
    EOF
  }
}
