#Configuracao do launch template

resource "aws_launch_template" "example" {
  name_prefix   = "example-launch-template"
  image_id      = aws_ami.ami_app.id  # Substitua pelo ID da AMI desejada
  instance_type = "t2.micro"  # Substitua pelo tipo de instância desejado
  #security_groups      = [aws_security_group.asg_sg.id]  # Substitua pelo ID do grupo de segurança desejado
  key_name      = file("/id_rsa")  # Substitua pelo nome da chave SSH desejada

}
