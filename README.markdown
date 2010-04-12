AMIBUILDER
==========

Scripts to automate building an Ubuntu EC2 EBS boot AMI, based on Eric Hammond's tutorial at http://alestic.com/2010/01/ec2-ebs-boot-ubuntu

Requirements
============
The following environment variables must be set.  You can paste this into ~/.amibuilderrc and it will be read automatically (replace with your proper values)

    ### EC2 Tools ###
    # EC2_HOME: the path of your EC2 API Tools (http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88)
    export EC2_HOME=~/bin/ec2-api-tools
    # EC2_AMITOOL_HOME: the path of your EC2 AMI Tools (http://developer.amazonwebservices.com/connect/entry.jspa?externalID=368&categoryID=88)
    export EC2_AMITOOL_HOME=~/bin/ec2-ami0tools

    ### EC2 Credentials ###
    # EC2_PRIVATE_KEY: the path of your private key (See X.509 Certificates at https://aws-portal.amazon.com/gp/aws/developer/account/index.html?action=access-key#access_credentials)
    export EC2_PRIVATE_KEY=~/.ec2/pk-yourid.pem
    # EC2_CERT: the path of your cert (See X.509 Certificates at https://aws-portal.amazon.com/gp/aws/developer/account/index.html?action=access-key#access_credentials)
    export EC2_CERT=~/.ec2/cert-yourid.pem
    # EC2_KEYPAIR: the path of your keypair private key (https://console.aws.amazon.com/ec2/home#c=EC2&s=KeyPairs)
    export EC2_KEYPAIR=~/.ec2/keypair-yourid.pem
    # EC2_KEYPAIR_NAME: the name of your keypair (https://console.aws.amazon.com/ec2/home#c=EC2&s=KeyPairs)
    export EC2_KEYPAIR_NAME=yourid

    ### AMI Builder Settings ###
    # AMIBUILDER_INSTANCE_TYPE: the type of instance you want, e.g. m1.small for 32 bit and m1.large for 64 bit (See http://aws.amazon.com/ec2/instance-types/)
    export AMIBUILDER_INSTANCE_TYPE=m1.small
    # AMIBUILDER_NEW_AMI_PREFIX: a string with no spaces.  This string will be prepended to the name of your new AMI
    export AMIBUILDER_NEW_AMI_PREFIX=cloned

Usage
=====
    ./amibuilder

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

