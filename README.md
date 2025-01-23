The Below Snippet shows network Ingress and Egress within the Network Across all Availabiltiy Zones.

![image](https://github.com/user-attachments/assets/352cbe05-5bba-46ac-ab48-7d9a615a6f5f)

Based on the requirements, traffic from instances within public subnets go via the internet gateway to to the internet. While traffic from within private subnets instances to the internet can be are routed via the nat gateway if the access is requried.

The following Assumptions were made for this set-up
