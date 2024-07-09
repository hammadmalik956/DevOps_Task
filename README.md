# Terraform AWS Infrastructure

This repository contains Terraform configurations for setting up an AWS infrastructure, including VPC, EC2 instances, security groups, ALB (Application Load Balancer), and RDS (Relational Database Service).

## Resources Created

### VPC

- **VPC** with specified CIDR block
- Public and private subnets
- Optional NAT Gateway configuration

### Security Groups

- **EC2 Security Group**: Allows inbound SSH (port 22) and MySQL (port 3306) traffic via port forwarding with socat. 
- **ALB Security Group**: Allows inbound HTTP (port 80) and HTTPS (port 443) traffic which is redirected to port 443 from port 80.
- **RDS Security Group**: Allows inbound MySQL (port 3306) traffic from the EC2 instances because RDS is in Private Subnet

### EC2 Instances

- **EC2 Instances** with ubuntu jammy 22.04 AMI, instance type = t2.micro.

### Application Load Balancer (ALB)

- **ALB** with specified listener configuration (80 and 443) and associated security group lets it access from anywhere. (Static htmls via nginx

### RDS Instance

- **RDS Instance** with mysql engine and associated security group.

### Key Pair

- **SSH Key Pair** for accessing the EC2 instances.

## How to Run

### Prerequisites

- Ensure you have Terraform v1.0+ installed.
- Ensure AWS CLI is installed and configured with appropriate permissions.

### Steps

1. **Clone the Repository**:
   ```sh
   git clone 
   cd <repository-directory>
2. **Initialize the Repo
   ```sh
   cd Terraform
   terraform init
   terraform apply --var-file=configs/dev.tfvars

##Upon successfull execution it will create "secrets.env" file outside Terraform directory. The file contains the credentials and host for mysql database along with public load balancer dns to access the static index.html served by nginx after executing the ansible playbook. secrets.env file will look like this 
```sh 
HOST=XXX
DB_USERNAME=XXX
DB_PASSWORD=XXX
DB_NAME=XXX
DB_PORT=XXX
LOAD_B_DNS=XXX



