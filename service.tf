resource "aws_ecs_service" "default" {
  name            = "api"
  cluster         = "${aws_ecs_cluster.default.id}"
  task_definition = "${aws_ecs_task_definition.default.family}:${max("${aws_ecs_task_definition.default.revision}", 0)}"
  desired_count   = 3
  iam_role        = "${aws_iam_role.ecs.arn}"
  
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = "${aws_lb_target_group.default.arn}"
    container_name   = "nginx"
    container_port   = 80
  }
}

resource "aws_ecs_task_definition" "default" {
  family                = "nginx"
  container_definitions = <<DEFINITION
[
  {
    "name": "nginx",
    "image": "pokhrelaashish/helloapp-nginx:v1",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "memory": 512,
    "cpu": 1024
  }
]
DEFINITION
}
