#!/bin/sh

# http://alestic.com/2009/11/ec2-credentials

# NOTES: cert file MUST be permissions 644

# thewoolleyman@gmail.com
#private-key=~/.ssh/pk-ec2-thewoolleyman.pem
#cert=~/.ssh/cert-ec2-thewoolleyman.pem
#keypair=~/.ssh/keypair-ec2-thewoolleyman.pem
#keypairname=thewoolleyman

# rails-ci@engineyard.com
privatekey=~/.ssh/pk-ec2-rails-ci.pem
cert=~/.ssh/cert-ec2-rails-ci.pem
keypair=~/.ssh/keypair-ec2-rails-ci.pem
keypairname=rails-ci

instancetype=m1.large
ami=ami-ab15f6c2   # ubuntu 9.10
newamiprefix=test-
