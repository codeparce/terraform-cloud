

## Terraform

terraform apply 



## AWS CLI

aws ec2 describe-vpcs --output table  > vpc

aws ec2 describe-subnets  --filters Name=vpc-id,Values=vpc-06d355649c974a105   --output table > subnet