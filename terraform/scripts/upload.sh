#!/bin/bash

public_ip=$(aws ec2 describe-instances --instance-id ${1} --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

mkdir -p ~/.ssh

touch ~/.ssh/known_hosts

ssh-keyscan -H $public_ip >> ~/.ssh/known_hosts

ssh -i ./keypair/mission_link.pem ubuntu@$public_ip "mkdir -p /home/ubuntu/.ssh/mlink"

scp -i ./keypair/mission_link.pem ./keypair/mlink_worker_node.pem ubuntu@$public_ip:/home/ubuntu/.ssh/mlink/

ssh -i ./keypair/mission_link.pem ubuntu@$public_ip "chmod 400 /home/ubuntu/.ssh/mlink/mlink_worker_node.pem"