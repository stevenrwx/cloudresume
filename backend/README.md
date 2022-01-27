Goals:

* provision backend - s3 (storage)
https://www.deployawebsite.com/static-sites/s3-terraform/

policy on buckets >
https://docs.aws.amazon.com/AmazonS3/latest/userguide/example-bucket-policies.html

* cloudfront ssl/tls - aws cert manager
created a cloudfront distrubtion and whitelist of GB

* DNS - Amazon Route 53
* AWS Lamda
* AWS IAM
* Amazon DynamoDB
* Amazon API gateway

TODO

CI/CD for uploading using AWS code pipeline, codecommit, codebuild, codedeploy

QUICK fix


```
terraform init
```

test syntax
```
terraform validate
``` 
plan changes 
```
terraform plan
```
apply changes
```
terraform apply
```
