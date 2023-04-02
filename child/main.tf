data "aws_vpc" "vpc_selected" {
  id = var.VPCId
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "TrainingSubnet" {
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id     = data.aws_vpc.vpc_selected.id
  cidr_block = "10.2.16.0/20"

  tags = {
    Name = "TrainingSubnet"
  }
}

resource "aws_instance" trainging_ec2 {
  count = var.ec2_count # create four similar EC2 instances

  ami = "ami-00c39f71452c08778"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.TrainingSubnet.id

  tags = {
    Name = "Server ${count.index}"
  }
}

resource "aws_instance" trainging_ec3_with_foreach {
  for_each = {for singleConfig, config in var.ec2_configurations: singleConfig => config}

  ami = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.TrainingSubnet.id


  tags = "${merge(var.generic_tags, {Name = "${each.value.name}"})}"
}


locals{
  s3BucketChanged = lower(join("s",["CompanyBucket", var.s3_bucket_Name]))
}


resource "aws_s3_bucket" "s3Bucket" {
  bucket = local.s3BucketChanged

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}