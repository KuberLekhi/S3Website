# S3 Static Website and CloudFront Setup

This repository contains two Bash scripts to automate the setup of an Amazon S3 bucket for hosting a static website and configuring CloudFront distribution with OAC (Origin Access Control) for secure access.

## Scripts Overview

### 1. `setup-s3-website.sh`
This script automates the following tasks for your S3 bucket:
- **Create an S3 bucket**: The bucket is named and created in the specified region.
- **Enable static website hosting**: This allows your S3 bucket to act as a static website.
- **Upload files**: Syncs your local static website files to the S3 bucket.
- **Apply bucket policy**: Makes the website publicly accessible by applying a bucket policy.

### 2. `setup-CF.sh`
This script handles the configuration of CloudFront distribution for the S3 bucket and ensures secure access using OAC. It includes:
- **Create CloudFront distribution**: The script creates a CloudFront distribution that points to the S3 bucket.
- **Set up Origin Access Control (OAC)**: Ensures that the bucket is accessible only through CloudFront using OAC, blocking direct access to the S3 URL.
- **Update Bucket Policy**: The bucket policy is updated to allow access only via CloudFront's OAC.

## Features
- **S3 Static Website Hosting**: Serve static website files directly from S3.
- **CloudFront with OAC**: Secure delivery of your website via CloudFront, preventing direct S3 access.
- **Automated Setup**: Both the S3 and CloudFront setups are automated using Bash scripts.


