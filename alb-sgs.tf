resource "aws_security_group" "default_lb" {
	name = "load balancer"
	description = "Allow TLS inbound"
	vpc_id = "vpc-8f7656f5"

	ingress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
	}
}
