# Terraform AWS Infrastructure

This repository contains Terraform configurations for setting up an AWS infrastructure, including VPC, EC2 instances, security groups, ALB (Application Load Balancer), and RDS (Relational Database Service).


I have used my boilerplate Terraform modules that i use to work on daily for my clients. I was also a MERN stack developer so i used nodes js boilerplate code for building this application, there could be additional functionality that wasn't the requirement of the given task. 
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

- **ALB** with specified listener configuration (80 and 443) and associated security group lets it access from anywhere. (Static htmls via nginx) Certificate address must be given in https listener.

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
   cd git@github.com:hammadmalik956/DevOps_Task.git
2. **Initialize the Repo
   ```sh
   cd DevOps_Task
   cd Terraform
   terraform init
   terraform apply --var-file=configs/dev.tfvars
   ```
# Running Ansible Playbook    
Upon successfull execution it will create "secrets.env" file outside Terraform directory. The file contains the credentials and host for mysql database along with public load balancer dns to access the static index.html served by nginx after executing the ansible playbook. secrets.env file will look like this 
   ```sh 
   HOST=XXX
   DB_USERNAME=XXX
   DB_PASSWORD=XXX
   DB_NAME=XXX
   DB_PORT=XXX
   LOAD_B_DNS=XXX
   ```
Wait for EC2 to pass health check 2/2 before running ansible playbook. 
To run Ansible playbook to configure ec2 made with terraform to serve static files we need to run the following commands before running the command you need to copy Ec2 host value which is in secrets.env
   ```sh
   cd .. 
   cd Ansible 
   ansible-playbook -i inventory.ini playbook_nginx_config.yml
   ```
 It will setup nginx in ec2 and it can be validated via copying ```LOAD_B_DNS``` in browser. I will shows ```Hello Nginx! I am Malik Hammad Hameed```
# Running Node Js Application to interact with Infrastructure built
 Lastly you can run the application by following these commands 
   ```sh
   cd ..
   cd Application
   npm i 
   npm run dev  [ to run the node application ] [ apis can be triggered at http://localhost:4000/api/visitors GET req and http://localhost:4000/api/visitor POST req will take { "name": "Malik Hammad" } as      body
   ```
 To run test with **mocha** **chai** 
  ```sh
   npm run test [ 3 tests will pass ] 
   ```
# Remember to copy the required values from secret.env to Application/config/development.json. The host would be dns of EC2 and all other variables must also fill in. Since RDS is in Private subnet we have setup socat port forwarding so that we can use ec2's dns to forward the request to rds from ec2 while connecting to RDS mysql. 

## For Further Assitance in running the solution. You can fearlessly reach out to me. Thank you  
