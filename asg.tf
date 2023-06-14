#Configuracao do launch template

resource "aws_launch_template" "lt_asg" {
  name_prefix   = "example-launch-template"
  image_id      = aws_ami.ami_app.id 
  instance_type = "t2.micro" 
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  #key_name      = file("/id_rsa")  

}

#Cria o recurso do ASG
resource "aws_autoscaling_group" "asg" {
  name             = "asg"
  min_size         = 1  
  max_size         = 2  
  desired_capacity = 1  
  health_check_type = "ELB"
  vpc_zone_identifier = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_b.id] 


  launch_template {
    id      = aws_launch_template.lt_asg.id
    version = "$Latest"
  }

}


# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.alb_target.arn
}