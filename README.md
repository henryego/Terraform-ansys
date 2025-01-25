The Below Snippet shows network Ingress and Egress within the Network Across all Availabiltiy Zones.

![image](https://github.com/user-attachments/assets/a0353960-937e-46f1-a84d-925894b8a004)


Based on the requirements, traffic from instances within public subnets go via the internet gateway to to the internet. While the private subnets instances access to internet is blocked as no public IP is attached and traffic goes via the default route to the VPC's local CIDR block (10.0.0.0/16 local) for communication within the VPC.

Deliverables
1.   The repository link includes all necessary Terraform code to provision the infrastructure.
2.   Commit messages reflect all my thought process and implementation steps.

The following Assumptions were made for this set-up
1.  AWS credentials is already configured for Terraform to access AWS services.
2.  Linux ec2 instances are required to run the nginx services.
3.  Deployment of this resources are to be done across the us-east-1 region.

