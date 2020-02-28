resource "aws_iam_role" "ecs" {
    name                = "terraform-ecs-service-role-nginx"
    assume_role_policy  = "${data.aws_iam_policy_document.ecs.json}"
}
resource "aws_iam_role_policy_attachment" "ecs" {
    role       = "${aws_iam_role.ecs.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
data "aws_iam_policy_document" "ecs" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type        = "Service"
            identifiers = ["ecs.amazonaws.com"]
        }
    }
}
