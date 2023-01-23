This repo contains terraform modules required to create a lambda function, lambda role, api gateway, and dynamodb for the portfolio’s back-end. Keeping reusability in mind, the variable file allows customization of names, regions, and settings.

The front-end.tf file is a draft of the terraform modules required for front-end resources such as s3 buckets, cloudfront distributions, and route 53 records. 
