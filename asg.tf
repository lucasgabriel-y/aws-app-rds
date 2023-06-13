#Configuracao do launch template

resource "aws_launch_template" "lt_asg" {
  name_prefix   = "example-launch-template"
  image_id      = aws_ami.ami_app.id 
  instance_type = "t2.micro" 
  #key_name      = file("/id_rsa")  

}

#Cria o recurso do ASG
resource "aws_autoscaling_group" "asg" {
  name             = "ASG"
  min_size         = 2  
  max_size         = 4  
  desired_capacity = 2  
  vpc_zone_identifier = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_b.id] 

  launch_template {
    id      = aws_launch_template.lt_asg.id
    version = "$Latest"
  }

}