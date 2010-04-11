Private setup for RailsCI

Usage
=====
. ./config.sh

Links
=====
* Building an Image: http://alestic.com/2010/01/ec2-ebs-boot-ubuntu
* Info on Certs/Keys: http://solutions.amazonwebservices.com/connect/message.jspa?messageID=115688
* Download Certs/Keys: https://aws-portal.amazon.com/gp/aws/developer/account/index.html

Viewing Key Info
================

    openssl x509 -in cert-ec2-username.pem -text
    openssl rsa -in pk-ec2_username.pem -text

