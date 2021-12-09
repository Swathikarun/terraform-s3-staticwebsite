# Terraform-S3-Static-Website

## Objective

This tells you how to build a tf file to host a static website on AWS S3 using Terraform

## Prerequisites

Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)

[AWS IAM user with access to S3](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_change-permissions.html#users_change_permissions-add-console)

Install [git](https://github.com/git-guides/install-git)

## Usage

Clone the repository


```html
$ git clone https://github.com/Swathikarun/terraform-s3-staticwebsite.git

$ cd terraform-s3-staticwebsite

$ terraform init

$ terraform apply
```


>> To begin with, we need an S3 bucket defined in our terraform project. The code block includes website block that sets up web hosting for the bucket. You need to enter the region, aws access key and secret key in the provider.tf file, bucket name and website file location in the s3.tf file.

 Also you can invoke awscli commands using null_resource provisioner to upload the contents in a folder, as suggested here.

```html
resource "null_resource" "remove_and_upload_to_s3" {
  provisioner "local-exec" {
    command = "aws s3 sync ${path.module}/s3Contents s3://${aws_s3_bucket.site.id}"
  }
}
```

## Result

A static website is hosted in S3 bucket and outputs the S3 bucket url.
