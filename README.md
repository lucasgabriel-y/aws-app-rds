# Terraform AWS


## Descrição
Este projeto construído em Terraform provisiona uma infraestrutura na AWS composta por recursos que fornecem alta disponibilidade, escalabilidade e segurança.

### Recursos provisionados:
**Instancia EC2**: Uma instância EC2 escalonada por um Auto Scaling Group (ASG). O ASG monitora a carga de trabalho e adiciona ou remove instâncias EC2 automaticamente de acordo com a demanda.

**SNS**: O sistema notifica via SNS (Simple Notification Service) sempre que ocorrer um escalonamento ou desligamento de instâncias EC2.

**ELB**: O ASG está localizado atrás de um ELB (Elastic Load Balancer) para distribuir o tráfego de entrada entre as instâncias EC2. Isso proporciona alta disponibilidade e escalabilidade horizontal.

**WAF**: O ELB é protegido por um WAF (Web Application Firewall) que faz a limitação do acesso à rede por IPs. O WAF é configurado para filtrar e bloquear tráfego malicioso ou indesejado, garantindo a segurança da aplicação.

**Subnets**: As instâncias EC2 estão em subnets públicas localizadas em zonas de disponibilidade distintas. Essa arquitetura distribuída permite que o sistema continue operando mesmo que uma zona de disponibilidade inteira fique indisponível.

**Banco de Dados**: As instâncias EC2 estão conectadas a um banco de dados que está em uma rede privada e abrange duas zonas de disponibilidade diferentes. Isso garante alta disponibilidade e recuperação de falhas para o banco de dados.

### Utilização:
* Execute o comando **terraform init** para inicializar o Terraform.
* Execute o comando **terraform plan** para visualizar as mudanças propostas pela configuração do Terraform.
* Execute o comando **terraform apply** para criar a infraestrutura na AWS.
