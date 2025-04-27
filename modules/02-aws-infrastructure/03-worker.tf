#iam ec2
resource "aws_iam_role" "worker_role" {
  name = "worker-${var.stage}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Stage = var.stage
  }

}

resource "aws_iam_instance_profile" "worker" {
    name = "worker-profile-${var.stage}"
    role = aws_iam_role.worker_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCoreWorker"{
    role = aws_iam_role.worker_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_instance" "worker" {
    count = var.aws_number_worker_nodes
    ami = var.aws_ami
    instance_type = var.aws_instance_type_worker_nodes
    availability_zone = var.aws_availability_zone
    subnet_id = aws_subnet.main_subnet.id

    associate_public_ip_address = true

    vpc_security_group_ids = [
        aws_security_group.k3s_ingress.id,
        aws_security_group.k3s_egress.id,
        aws_security_group.k3s_internal.id,
        var.expose_management_protocols ? aws_security_group.management_ingress.id : null
    ]

    iam_instance_profile = aws_iam_instance_profile.worker.name

    user_data_base64 = base64encode(templatefile("${path.module}/02-user-data.sh",{
        key_string = join("\n",var.ssh_public_keys)
    }))

    tags = {
        Name = "${var.stage}-worker-${count.index}"
        Stage = var.stage
    }
    depends_on = [ aws_security_group.k3s_egress, aws_security_group.k3s_ingress, aws_security_group.k3s_internal, aws_security_group.management_ingress ]
}