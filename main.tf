module "TFModuleSimple"{
    source = "./child"
    ec2_configurations = [
        {
            ami = "ami-00c39f71452c08778"
            instance_type = "t2.micro"
            name = "EC2-1"
        },
        {
            ami = "ami-00c39f71452c08778"
            instance_type = "t2.micro"
            name = "EC2-2"
        }
    ]
    s3_bucket_Name = "TestBucket007Hello007"
}

output "id"{
    value = module.TFModuleSimple.VPCId
}