# create spot instance
resource "aws_spot_instance_request" "spot" {
  count = var.SPOT_INSTANCE_COUNT  
  ami           = data.aws_ami.ami.image_id
  #spot_price    = "0.03"
  instance_type = var.SPOT_INSTANCE_TYPE
  wait_for_fulfillment = true
  #spot_type = "one-time"

  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}

resource "aws_instance" "app" {
    count = var.OD_INSTANCE_COUNT
    ami = data.aws_ami.ami.image_id
    instance_type = var.OD_INSTANCE_TYPE
  
}
