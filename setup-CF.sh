#!/bin/bash


#CREATING CLOUDFRONT DISTRIBUTION

aws cloudfront create-distribution --origin-domain-name mybucket-kuberlekhi.s3.amazonaws.com --default-root-object indexx.html


#RETRIEVE CLOUDFRONT DISTRIBUTION ID 

aws cloudfront list-distributions


#CHECK CLOUDFRONT'S STATUS

aws cloudfront get-distribution --id <Distribution-ID>       #Replace <Distribution-ID> with the actual distribution ID from the previous step.


#CREATE AN OAI [both works]

aws cloudfront create-cloud-front-origin-access-identity --cloud-front-origin-access-identity-config CallerReference=$(date +%s),Comment="My OAI"
                                                                OR
aws cloudfront create-cloud-front-origin-access-identity --cloud-front-origin-access-identity-config CallerReference=<your-unique-value>,Comment="OAI for mybucket-kuberlekhi"


#UPDATE THE BUCKET POLICY      [The policy we uploaded for s3]

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity <CloudFront-OAI-ID>"   
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::mybucket-kuberlekhi/*"
    }
  ]
}


 [[replace <CloudFront-OAI-ID> with the actual OAI ID created earlier.]]


#APPLY THAT POLICY 

aws s3api put-bucket-policy --bucket mybucket-kuberlekhi --policy file://policy.json


#VERIFY IF ITS APPLIED 

aws s3api get-bucket-policy --bucket mybucket-kuberlekhi


#RETRIEVE THE CLOUDFRONT DOMAIN NAME [Gives detail about cloudfront distribution including Distribution ID]

aws cloudfront list-distributions 


