Goals:

* provision backend - s3 (storage)
>policy on buckets

* cloudfront ssl/tls - aws cert manager
>created ssl/tls cert for sofcloud.link

* DNS - Amazon Route 53
>created DNS "A" record pointing to cdn (cloudflare url)
** custom domain requires ssl cert from acm **

* AWS Lamda
>update dynamodb table, increment value +1
>read the new value
>output the value

** aws lambda requires deployment packages **

* AWS IAM

* Amazon DynamoDB

* Amazon API gateway

TODO

* CI/CD for uploading using AWS code pipeline, codecommit, codebuild, codedeploy
* Refactor main.tf into buckets.tf, cdn.tf, dns.tf, variables.tf

QUICK fix

* fix manual steps (SSL cert)

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
terraform apply -refresh-only
```

##ref section

* i) s3 creation ref: https://www.deployawebsite.com/static-sites/s3-terraform/creating-bucket/
* ii) s3 policy on buckets ref: https://docs.aws.amazon.com/AmazonS3/latest/userguide/example-bucket-policies.html
* iii) aws lambda deployment ref: https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-package.html
* iv) aws boto3 dynamodb ref: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb.html#DynamoDB.Client.update_item
* v) terraform docs on api gateway creation ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api
* vii) aws api gateway docs ref https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html

