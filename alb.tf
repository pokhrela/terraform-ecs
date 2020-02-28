resource "aws_lb" "default" {
  name               = "terraform-springboot-helloapp"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.default_lb.id}"]
  subnets            = ["subnet-0a78dc47", "subnet-f0726697"]
  enable_deletion_protection = false
  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "default" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vpc-8f7656f5"
  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = "5"
    port                = "8080"
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
  }
}

resource "aws_lb_listener" "default" {
  load_balancer_arn = "${aws_lb.default.arn}"
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.default.arn}"
  }
}
