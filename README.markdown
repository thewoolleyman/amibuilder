Scripts to automate building an Ubuntu EC2 EBS boot AMI, based on Eric Hammond's tutorial at http://alestic.com/2010/01/ec2-ebs-boot-ubuntu

Usage
=====
    . ./config.sh
    . ./run_instance.sh
    . ./get_host.sh
    . ./upload_credentials.sh
    . ./upgrade_tools.sh
    . ./create_ebs_ami.sh

Links
=====
* Building an Image: http://alestic.com/2010/01/ec2-ebs-boot-ubuntu
* Download Certs/Keys: https://aws-portal.amazon.com/gp/aws/developer/account/index.html
* Understanding Credentials: http://alestic.com/2009/11/ec2-credentials
* Protecting from data loss: http://alestic.com/2010/01/ec2-instance-locking
* https://help.ubuntu.com/community/EC2StartersGuide

Viewing Key Info
================
    openssl x509 -in cert-ec2-username.pem -text
    openssl rsa -in pk-ec2_username.pem -text

