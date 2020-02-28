data "aws_iam_policy_document" "ecs" {
  {
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ecs.amazonaws.com", "ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}

resource "aws_iam_role" "ecs" {
    name = "terraform-ecs"
    assume_role_policy = "${data.aws_iam_policy_document.default.json}"
}
