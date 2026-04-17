resource "aws_instance" "ec2"{

    count = length(var.public_subnet_cidrs)
    ami = var.ami
    instance_type = var.InstanceType
    key_name = var.KeyPair
    subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
    vpc_security_group_ids = [
        element([aws_security_group.app_sg.id, aws_security_group.jenkins_sg.id],count.index)
        ]

    tags = {
        Name = element(var.InstanceNames[*], count.index)
    }
}
