provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "VPN-bug" {
    tags = {
        Name = "VPN-bug"
    }

    ami                    = "ami-006a0174c6c25ac06"
    instance_type          = "t2.micro"

    key_name               = var.ssh_key_name

    vpc_security_group_ids = [aws_security_group.VPN-bug.id]

    root_block_device {
        volume_size           = var.volume_size
        delete_on_termination = true
    }
}

resource "aws_security_group" "VPN-bug" {
    name = "VPN-bug"

    tags = {
        Name = "VPN-bug"
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

# resource "aws_ebs_volume" "VPN-bug" {
#     availability_zone = "eu-west-2a"
#     size              = 6
#
#     tags = {
#         Name = "VPN-bug"
#     }
# }

output "public_ip" {
    value       = aws_instance.VPN-bug.public_ip
    description = "The public IP of the server"
}
