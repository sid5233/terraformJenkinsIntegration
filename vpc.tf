resource "aws_vpc" "my_tf_app" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  
  tags = {
    Name = "bizhomeVPC"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_subnet" "main" {
  count = 3
  
  vpc_id = "${aws_vpc.my_tf_app.id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"

  tags = {
    "Name" = "subnet-${count.index}"
  }
}