# Terraform AWS Infrastructure

This repository contains Terraform configurations for setting up an AWS infrastructure, including VPC, EC2 instances, security groups, ALB (Application Load Balancer), and RDS (Relational Database Service).

## Resources Created

### VPC

- **VPC** with specified CIDR block
- Public and private subnets
- Optional NAT Gateway configuration

### Security Groups

- **EC2 Security Group**: Allows inbound SSH (port 22) and MySQL (port 3306) traffic.
- **ALB Security Group**: Allows inbound HTTP (port 80) and HTTPS (port 443) traffic.
- **RDS Security Group**: Allows inbound MySQL (port 3306) traffic from the EC2 instances.

### EC2 Instances

- **EC2 Instances** with specified AMI, instance type, and associated security group.

### Application Load Balancer (ALB)

- **ALB** with specified listener configuration and associated security group.

### RDS Instance

- **RDS Instance** with specified engine, version, instance class, and associated security group.

### Key Pair

- **SSH Key Pair** for accessing the EC2 instances.

## How to Run

### Prerequisites

- Ensure you have Terraform v1.0+ installed.
- Ensure AWS CLI is installed and configured with appropriate permissions.

### Steps

1. **Clone the Repository**:
   ```sh
   git clone <repository-url>
   cd <repository-directory>
