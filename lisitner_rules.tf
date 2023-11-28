
## Generates a random integer in the range
resource "random_integer" "priority" {
  min = 100
  max = 500
  
}


# create a rule in the private loadbalancer listner

resource "aws_lb_listener_rule" "app_rule" {
    count = var.INTERNAL ? 1 : 0
    listener_arn = data.terraform_remote_state.alb.outputs.PRIVATE_LISTENER_ARN
    priority = random_integer.priority.result         
## we cannot give a fixed priority number, as it has has to be unique for each 
## lisitner. so we use random integer fuction to assign 

    action {
      type = "forward"
      target_group_arn = aws_lb_target_group.app.arn

    }

    condition {
      host_header {
        values = ["${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_NAME}"]
      }
    }
}