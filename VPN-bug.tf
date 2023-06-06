provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "bugVPN" {
    tags = {
        Name = "bugVPN"
    }

    ami                    = "ami-0ee7c705255f9be61"
    instance_type          = "t2.micro"

    key_name               = var.ssh_key_name

    vpc_security_group_ids = [aws_security_group.bugVPN.id]

    root_block_device {
        volume_size           = var.volume_size
        delete_on_termination = true
    }
}

resource "aws_security_group" "bugVPN" {
    name = "bugVPN"

    tags = {
        Name = "bugVPN"
    }

    ingress {
        description = "SSH"
        from_port   = var.ssh_port
        to_port     = var.ssh_port
        protocol    = "tcp"
        cidr_blocks = var.cidr_block
    }

    ingress {
        description = "OpenVPN"
        from_port   = var.openvpn_port
        to_port     = var.openvpn_port
        protocol    = "tcp"
        cidr_blocks = var.cidr_block
    }

    ingress {
        description = "OpenVPN"
        from_port   = var.openvpn_port
        to_port     = var.openvpn_port
        protocol    = "udp"
        cidr_blocks = var.cidr_block
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# resource "aws_ebs_volume" "bugVPN" {
#     availability_zone = "eu-west-2a"
#     size              = 6
#
#     tags = {
#         Name = "bugVPN"
#     }
# }

output "public_ip" {
    value       = aws_instance.bugVPN.public_ip
    description = "The public IP of the server"
}
