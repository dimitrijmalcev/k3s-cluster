#!/bin/bash


yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_arm64/amazon-ssm-agent.rpm
systemctl start amazon-ssm-agent
echo "${key_string}" | tee -a "/root/.ssh/authorized_keys" > /dev/null
