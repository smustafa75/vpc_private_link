# Protecting S3 Bucket through AWS Private Link

This repo will demonstarte a protected VPC Private Link feature for S3. 
Keeping security in consideration, the S3 bucket policy is modifieed to allow traffic only from VPC Endpoint, hence even the EC2 instances in public subnet would not be able to upload/download data from the S3 bucket.

Below infrastructure will be provisioned:

- 01 VPC
- 01 IGW
- 01 NAT GW
- 02 Public Subnets
- 02 Private Subnets
- 02 EC2 instances in each subnet
- 01 Instance Profile
    - 01 IAM Role
    - 01 IAM Policy
    - 01 CloudWatch Policy
- 01 S3 Bucket
- 01 S3 Bucket policy
- 01 VPC Gateway Endpoint


Once completed, the script will automatically install HTTP into EC2 insatnces and start the service.
You will see EC2 metrics in CloudWatch within 10 minutes.
The **tfvars** files is added as text, use it as desired.

### Terraform Version ###
Terraform v1.1.2
+ provider registry.terraform.io/hashicorp/aws v3.71.0
+ provider registry.terraform.io/hashicorp/random v3.1.0
+ provider registry.terraform.io/hashicorp/template v2.2.0


### Helpful community
Special Thanks to 
+ [Ervin](https://stackoverflow.com/users/7661119/ervin-szilagyi) for identifying a needle small bug in minutes that was hindering the whole efforts.
