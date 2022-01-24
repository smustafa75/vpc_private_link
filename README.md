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


## Post provision actions
- The script will automatically install HTTP server in machines inside public subnet and start the service.
- Once script will automatically insatll and configure AWS CLI in both machines inside private subnet.
- You will see EC2 metrics in CloudWatch within 10 minutes.
- The **tfvars** files is added as text having non sensitive variables.

## Test

- Login into machine in public subnet and try below command. The action will fail. 
- Try same commands in machine inside private subnet and it will work.
    - aws s3 ls
    - aws s3 cp FILENAME s3://BUCKET-NAME


### Terraform Version ###
Terraform v1.1.2
+ provider registry.terraform.io/hashicorp/aws v3.71.0
+ provider registry.terraform.io/hashicorp/random v3.1.0
+ provider registry.terraform.io/hashicorp/template v2.2.0


### Helpful community
Special Thanks to 
+ [Ervin](https://stackoverflow.com/users/7661119/ervin-szilagyi) for identifying a needle small bug in minutes that was hindering the whole efforts.
