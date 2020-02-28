terraform {
  backend "s3" {
    bucket = "petclinicdeploy"
    key    = "terraform/dev/ecs-nginx"
    region = "us-east-1"
    profile = "aashish"
  }
}
