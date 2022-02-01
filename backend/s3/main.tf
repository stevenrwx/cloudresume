provider "aws" {
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
}

resource "aws_s3_bucket" "steven-website-01" {
  bucket = "steven-website-01"
  acl    = "private"
  /* policy to steven-website-01.s3.amazonaws.com/ */
  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [{
    "Sid": "AllowPublicRead",
    "Effect": "Allow",
    "Principal": {
      "AWS": "*"
    },
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::steven-website-01/*"
  }]
}
EOF
  website {
    index_document = "index.html"
  }

}
resource "aws_cloudfront_distribution" "steven-website-01" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  origin {
    domain_name = aws_s3_bucket.steven-website-01.bucket_domain_name
    origin_id   = "sofcloud.link"
  }
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["GB"]
    }
  }
  default_cache_behavior {
    target_origin_id = "sofcloud.link"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 7200
    max_ttl                = 86400
  }

  aliases = ["sofcloud.link"]

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:466384468619:certificate/7021e82f-4991-4418-a385-686731d03ff4"
    ssl_support_method  = "sni-only"
  }
}

data "aws_route53_zone" "main-a-record" {
  name = "sofcloud.link"
}

resource "aws_route53_record" "sofcloud" {
  zone_id = data.aws_route53_zone.main-a-record.zone_id
  name    = "sofcloud.link"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.steven-website-01.domain_name
    zone_id                = aws_cloudfront_distribution.steven-website-01.hosted_zone_id
    evaluate_target_health = false
  }
}
