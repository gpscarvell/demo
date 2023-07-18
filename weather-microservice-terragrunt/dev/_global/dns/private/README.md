# IMPORTANT

VPC in another account has to be assosiated:
See https://aws.amazon.com/premiumsupport/knowledge-center/route53-private-hosted-zone/

1. Comment VPN VPC in terragrunt.hcl:
```
      ...
      vpc = [
        {
          vpc_id     = dependency.vpc.outputs.vpc_id
          vpc_region = local.region.aws_region
        },
        # {
        #   vpc_id     = "vpc-xxxxxxxxx"
        #   vpc_region = "us-west-2"
        # },
      ]
      ...
```
2. Run terragrunt apply to create hosted zone.
3. Grab hosted zone id from output.
4. Create vpc association authorization (replace profile and hosted zone id with a value from previous step)
```
aws --profile prod route53 create-vpc-association-authorization --hosted-zone-id=Z06036121UWG3GNE1TUYT --vpc VPCRegion=us-west-2,VPCId=vpc-XXXXXXXXX
```
5. Uncomment VPN VPC in terragrunt.hcl
```
      ...
      vpc = [
        {
          vpc_id     = dependency.vpc.outputs.vpc_id
          vpc_region = local.region.aws_region
        },
        {
          vpc_id     = "vpc-xxxxxxxxx"
          vpc_region = "us-west-2"
        },
      ]
      ...
```
6. Apply changes.
