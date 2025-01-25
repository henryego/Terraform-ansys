The Below Snippet shows network Ingress and Egress within the Network Across all Availabiltiy Zones.

![image](https://github.com/user-attachments/assets/a0353960-937e-46f1-a84d-925894b8a004)


Based on the requirements, traffic from instances within public subnets go via the internet gateway to to the internet. While the private subnets instances access to internet is blocked as no public IP is attached and traffic goes via the default route to the VPC's local CIDR block (10.0.0.0/16 local) for communication within the VPC.

The following Assumptions were made for this set-up
