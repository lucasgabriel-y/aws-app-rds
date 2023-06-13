resource "aws_lb" "test" {
  name               = "apprds-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = false


  tags = {
    Environment = "test"
  }
}