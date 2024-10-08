#!/bin/bash

#FILE1

#CREATING THE BUCKET 

#Bucket name here is taken as "mybucket-kuberlekhi"
#Index page here is taken as "indexx.html"

# Variables
BUCKET_NAME="mybucket-kuberlekhi"  # Pre-defined bucket name
REGION="ap-south-1"  # You can change the region
INDEX_FILE="indexx.html"  # Index file name [uploaded directly to cloudshell]
LOCAL_DIR="./website-files"  # Folder containing your static website files

# Step 1: Create an S3 bucket (only if the bucket doesn't already exist)
aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION

# Step 2: Enable static website hosting on the S3 bucket (no error file provided)
aws s3 website s3://$BUCKET_NAME/ --index-document $INDEX_FILE

# Step 3: Upload the website files to the bucket
aws s3 sync $LOCAL_DIR s3://$BUCKET_NAME/

# Step 4: Skip making the bucket public and setting object ACL (You will handle this separately)

# Step 5: Skip outputting the website URL (since you're using CloudFront)
echo "Your website files have been uploaded to the bucket: $BUCKET_NAME"


#jSON POLICY TO BE STORED IN A TEXT EDITOR LIKE NANO eg "policy.json"


{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::mybucket-kuberlekhi/*"
    }
  ]
}


#APPLY THAT POLICY 

aws s3api put-bucket-policy --bucket mybucket-kuberlekhi --policy file://policy.json


#VERIFY IF ITS APPLIED 

aws s3api get-bucket-policy --bucket mybucket-kuberlekhi


#ENABLE STATIC WEBSITE 

aws s3 website s3://$mybucket-kuberlekhi --index-document $indexx.html


#To upload "indexx.html" to your S3 bucket

aws s3 cp indexx.html s3://mybucket-kuberlekhi/
                 OR
aws s3 cp ./index.html s3://mybucket-kuberlekhi


#If you want to upload multiple files                                       

aws s3 cp . s3://mybucket-kuberlekhi/ --recursive


{{{. means the current directory , --recursive will copy all files and directories under your current location.}}}                                                                     


#Confirm Static Website Hosting is Enabled
aws s3api get-bucket-website --bucket mybucket-kuberlekhi


#If it's not enabled or returns an error, you need to enable static website hosting
aws s3 website s3://mybucket-kuberlekhi --index-document index.html


#Check Bucket Permissions and Public Access

aws s3api put-public-access-block --bucket mybucket-kuberlekhi --public-access-block-configuration BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false


#Then, verify that the policy is correctly applied by retrieving the policy

aws s3api get-bucket-policy --bucket mybucket-kuberlekhi


#WEBSITE URL

#http://mybucket-kuberlekhi.s3-website.ap-south-1.amazonaws.com
