# Terraform-S3-Static-Website

## Objective

This tells you how to provision a static website on AWS S3 using Terraform

## Prerequisites

- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)

- [AWS IAM user with access to S3](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_change-permissions.html#users_change_permissions-add-console)

- Install [git](https://github.com/git-guides/install-git)

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## How to configure

1. To begin with, we need an S3 bucket defined in our terraform project. The code block includes website block that sets up web hosting for the bucket. You need to enter the region, aws access key and secret key in the provider.tf file, bucket name and website file location in the s3.tf file.

```html
resource "null_resource" "remove_and_upload_to_s3" {
  provisioner "local-exec" {
    command = "aws s3 sync ${path.module}/website s3://${aws_s3_bucket.bucket.id}"
  }
}
resource "aws_s3_bucket" "bucket" {
  bucket = "s3web.devopsstudy.tech"
  acl    = "public-read"
  policy = file("policy.json")

   website {
    index_document = "index.html"
    error_document = "error.html"
}

  tags = {
    Name        = "s3web.devopsstudy.tech"
  }

output "site-url" {
    value = aws_s3_bucket.bucket.website_endpoint
}

```

2. A bucket policy with necessary previlege is attached to the bucket to grant access permissions.

```html
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
	           "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::s3web.devopsstudy.tech/*"
        }
    ]
}
```

## Usage

- Clone the repository


```html
$ git clone https://github.com/Swathikarun/terraform-s3-staticwebsite.git

$ cd terraform-s3-staticwebsite

$ terraform init

$ terraform apply
```


- Also you can invoke awscli commands using null_resource provisioner to upload the contents in a folder, as suggested here.

```html
resource "null_resource" "remove_and_upload_to_s3" {
  provisioner "local-exec" {
    command = "aws s3 sync ${path.module}/s3Contents s3://${aws_s3_bucket.site.id}"
  }
}
```

## Result

A static website is hosted in S3 bucket and outputs the S3 bucket url.
