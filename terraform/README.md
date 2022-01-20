### General Setup

```
# S3
$ docker-compose run --rm -w /app/terraform/providers/aws/general/ap-northeast-1/s3 terraform init
$ docker-compose run --rm -w /app/terraform/providers/aws/general/ap-northeast-1/s3 terraform apply

# Cloud Trail
$ docker-compose run --rm -w /app/terraform/providers/aws/general/ap-northeast-1/cloudtrail terraform init
$ docker-compose run --rm -w /app/terraform/providers/aws/general/ap-northeast-1/cloudtrail terraform apply
```

#### Development Setup

```
# IAM
$ docker-compose run --rm -w /app/terraform/providers/aws/development/global/iam terraform init
$ docker-compose run --rm -w /app/terraform/providers/aws/development/global/iam terraform apply

# VPC
$ docker-compose run --rm -w /app/terraform/providers/aws/development/ap-northeast-1/vpc terraform init
$ docker-compose run --rm -w /app/terraform/providers/aws/development/ap-northeast-1/vpc terraform apply

# Security Group
$ docker-compose run --rm -w /app/terraform/providers/aws/development/ap-northeast-1/security_group terraform init
$ docker-compose run --rm -w /app/terraform/providers/aws/development/ap-northeast-1/security_group terraform apply

# EC2 (dev-ubuntu)
$ docker-compose run --rm -w /app/terraform/providers/aws/development/ap-northeast-1/ec2/dev-ubuntu terraform init
$ docker-compose run --rm -w /app/terraform/providers/aws/development/ap-northeast-1/ec2/dev-ubuntu terraform apply
```
