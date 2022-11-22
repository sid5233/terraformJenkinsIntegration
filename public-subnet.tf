locals {
  az_names = "${data.aws_availability_zones.azs.names}"
  pub_sub_id = "${aws_subnet.public.*.id}"

}

resource "aws_subnet" "public" {
    count = "${length(local.az_names)}"
  vpc_id = "${aws_vpc.my_tf_app.id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"
  availability_zone = "${local.az_names[count.index]}"
  tags = {
    "Name" = "Public-Subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "tf-igw" {
    vpc_id = "${aws_vpc.my_tf_app.id}"

}

resource "aws_route_table" "public-rt" {
      vpc_id = "${aws_vpc.my_tf_app.id}"

      route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.tf-igw.id}"
      }
}

resource "aws_route_table_association" "pub_sub" {
  count = "${length(local.az_names)}"
  subnet_id = "${local.pub_sub_id[count.index]}"
  route_table_id = "${aws_route_table.public-rt.id}"
}