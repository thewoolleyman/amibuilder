AMIBUILDER
==========

Scripts to automate building an Ubuntu EC2 EBS boot AMI, based on Eric Hammond's tutorial at http://alestic.com/2010/01/ec2-ebs-boot-ubuntu

Requirements
============
The following environment variables must be set.  You can paste this into ~/.amibuilderrc and it will be read automatically (replace with your proper values)

    # EC2 Tools
    export EC2_HOME=~/bin/ec2-api-tools # the path of your EC2 API Tools (http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88)
    export EC2_AMITOOL_HOME=~/bin/ec2-ami0tools # the path of your EC2 AMI Tools (http://developer.amazonwebservices.com/connect/entry.jspa?externalID=368&categoryID=88)

    # EC2 Credentials
    export EC2_PRIVATE_KEY=~/.ec2/pk-yourid.pem # the path of your private key (See X.509 Certificates at https://aws-portal.amazon.com/gp/aws/developer/account/index.html?action=access-key#access_credentials)
    export EC2_CERT=~/.ec2/cert-yourid.pem # the path of your cert (See X.509 Certificates at https://aws-portal.amazon.com/gp/aws/developer/account/index.html?action=access-key#access_credentials)
    export EC2_KEYPAIR=~/.ec2/keypair-yourid.pem # the path of your keypair private key (https://console.aws.amazon.com/ec2/home#c=EC2&s=KeyPairs)
    export EC2_KEYPAIR_NAME=yourid # the name of your keypair (https://console.aws.amazon.com/ec2/home#c=EC2&s=KeyPairs)

    # AMI Builder Settings
    export AMIBUILDER_INSTANCE_TYPE=m1.small # the type of instance you want, e.g. m1.small (See http://aws.amazon.com/ec2/instance-types/)
    export AMIBUILDER_BASE_AMI=ami-1515f67c # the AMI ID you wish to clone.  Make SURE this matches your AMIBUILDER_INSTANCE_TYPE - 32 or 64 bit.  Standard Ubuntu 9.10 is 'ami-1515f67c' for 32 bit and 'ami-ab15f6c2' for 64 bit
    export AMIBUILDER_NEW_AMI_PREFIX=cloned # a string with no spaces.  This string will be prepended to the name of your new AMI


Usage
=====
    . ./run.sh

Links
=====
* Building an Image: http://alestic.com/2010/01/ec2-ebs-boot-ubuntu
* Download Certs/Keys: https://aws-portal.amazon.com/gp/aws/developer/account/index.html
* Understanding Credentials: http://alestic.com/2009/11/ec2-credentials
* Protecting from data loss: http://alestic.com/2010/01/ec2-instance-locking
* https://help.ubuntu.com/community/EC2StartersGuide

Viewing Key Info
================
    openssl x509 -in cert-yourid.pem -text
    openssl rsa -in pk-yourid.pem -text

