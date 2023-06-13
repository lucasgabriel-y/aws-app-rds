provider "aws" {
  region = var.region
}

#Cria o recurso para usar uma chave de acesso  
resource "aws_key_pair" "key-pair" {
  key_name   = "tf-app-rds"
  public_key = file("/id_rsa.pub")

}

#Cria a instancia EC2
resource "aws_instance" "terraform" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.public_security_group.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key-pair.key_name #Associa a chave de acesso a instancia


  tags = {
    Name = "RDS terraform"
  }

#Promove o acesso SSH a instancia
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = var.user_ssh
      private_key = file("/id_rsa")
    }

#Promove a instalação de recursos na instancia
    inline = [
      "sudo apt install update -y",
      "sudo apt install apache2 -y",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2",
    ]
  }

}

#Associa um IP elastico a uma instancia
resource "aws_eip" "eip" {
  instance = aws_instance.terraform.id
}

#Exibe o IP publico associado
output "IP" {
  value = aws_eip.eip.public_ip

}








