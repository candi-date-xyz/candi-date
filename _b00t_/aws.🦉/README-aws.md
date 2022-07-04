# aws service notes

# aws cli
alias aws='docker run --rm -it -v ~/.aws:/root/.aws docker.io/amazon/aws-cli'


# s3 & ses
root ARN: arn:aws:organizations::968589500754:root/o-uxk7egql7c/r-4xci
account id: 968589500754
org id: o-uxk7egql7c
principal zone: us-east-1
https://elasticv.signin.aws.amazon.com/console


Error: not_a_saml_app

Provided application is not a SAML app

Request Details
idpid=C048sulds
spid=978804386508
forceauthn=false


# sso portal
https://aws.amazon.com/identity/federation/

https://b00t.awsapps.com/start
arn:aws:iam::968589500754:role/GoogleSAMLPowerUserRole,arn:aws:iam::968589500754:saml-provider/GoogleWorkspace
arn:aws:iam::968589500754:role/GoogleSAMLViewOnlyAccessRole,arn:aws:iam:: 968589500754:saml-providerGoogleWorkspace
# setup ses=>s3 access policy?

    - 🤓 https://aws.amazon.com/blogs/security/how-to-set-up-federated-single-sign-on-to-aws-using-google-workspace/

zyx.candi-date.xyz is arn:aws:ses:us-east-1:968589500754:identity/zyx.candi-date.xyz

```json
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AllowSESPuts",
      "Effect":"Allow",
      "Principal":{
        "Service":"ses.amazonaws.com"
      },
      "Action":"s3:PutObject",
      "Resource":"arn:aws:s3:::myBucket/*",
      "Condition":{
        "StringEquals":{
          "AWS:SourceAccount":"968589500754",
          "AWS:SourceArn": "arn:aws:ses:us-east-1:968589500754:receipt-rule-set/rule_set_name:receipt-rule/receipt_rule_name"
        }
      }
    }
  ]
}
```
