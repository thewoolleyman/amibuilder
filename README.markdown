Private setup for RailsCI

Usage
=====
. ./config.sh
. ./run_instance.sh
. ./get_host.sh
. ./upload_credentials.sh

Links
=====
* Building an Image: http://alestic.com/2010/01/ec2-ebs-boot-ubuntu
* Download Certs/Keys: https://aws-portal.amazon.com/gp/aws/developer/account/index.html
* Understanding Credentials: http://alestic.com/2009/11/ec2-credentials
* https://help.ubuntu.com/community/EC2StartersGuide

Viewing Key Info
================

    openssl x509 -in cert-ec2-username.pem -text
    openssl rsa -in pk-ec2_username.pem -text

