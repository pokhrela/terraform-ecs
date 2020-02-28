resource "aws_ecs_service" "default" {
  name            = "api"
  cluster         = "${aws_ecs_cluster.default.id}"
  task_definition = "${aws_ecs_task_definition.default.arn}"
  desired_count   = 3
  iam_role        = "${aws_iam_role.ecs.arn}"
  depends_on      = ["aws_iam_role_policy.ecs"]

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
  container_definitions = "${file("task-definitions/service.json")}"

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-1b, us-east-1d]"
  }
}
