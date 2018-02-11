provider "aws" {
  region = "eu-west-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}


module "elb_http" {
  source = "terraform-aws-modules/elb/aws"

  name = "my-cluster-elb"

  subnets         = ["subnet-b6df2bd2"]
  security_groups = ["sg-a8d2e9cc"]
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
  ]

  health_check = [
    {
      target              = "HTTP:80/"
      interval            = 10
      healthy_threshold   = 3
      unhealthy_threshold = 2
      timeout             = 5
    },
  ]

  // access_logs = [
  //   {
  //     bucket = "my-access-logs-bucket"
  //   },
  // ]

  // ELB attachments
  // number_of_instances = 2
  // instances           = ["i-06ff41a77dfb5349d", "i-4906ff41a77dfb53d"]

  tags = {
    Owner       = "Ignas"
    Environment = "dev"
  }
}