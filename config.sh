#!/bin/sh

# http://alestic.com/2009/11/ec2-credentials

if [ -e ~/.amibuilderrc ]; then
  . ~/.amibuilderrc
fi

# EC2 Tools
ec2home=${EC2_HOME:?Please set EC2_HOME to the path of your EC2 API Tools (http://developer.amazonwebservices.com/connect/entry.jspa?externalID=351&categoryID=88)}
ec2amitoolhome=${EC2_AMITOOL_HOME:?Please set EC2_AMITOOL_HOME to the path of your EC2 AMI Tools (http://developer.amazonwebservices.com/connect/entry.jspa?externalID=368&categoryID=88)}
export PATH=$ec2home/bin:$ec2amitoolhome/bin:$PATH

# EC2 Credentials
privatekey=${EC2_PRIVATE_KEY:?Please set EC2_PRIVATE_KEY to the path of your private key (See X.509 Certificates at https://aws-portal.amazon.com/gp/aws/developer/account/index.html?action=access-key#access_credentials)}
cert=${EC2_CERT:?Please set EC2_CERT to the path of your cert (See X.509 Certificates at https://aws-portal.amazon.com/gp/aws/developer/account/index.html?action=access-key#access_credentials)}
keypair=${EC2_KEYPAIR:?Please set EC2_KEYPAIR to the path of your keypair private key (https://console.aws.amazon.com/ec2/home#c=EC2&s=KeyPairs)}
keypairname=${EC2_KEYPAIR_NAME:?Please set EC2_KEYPAIR_NAME to the name of your keypair (https://console.aws.amazon.com/ec2/home#c=EC2&s=KeyPairs)}

# AMI Builder Settings
instancetype=${AMIBUILDER_INSTANCE_TYPE:?Please set AMIBUILDER_INSTANCE_TYPE to the type of instance you want, e.g. m1.small (See http://aws.amazon.com/ec2/instance-types/)}
ami=${AMIBUILDER_BASE_AMI:?Please set AMIBUILDER_BASE_AMI to the AMI ID you wish to clone.  Make SURE this matches your AMIBUILDER_INSTANCE_TYPE - 32 or 64 bit.  Standard Ubuntu 9.10 is 'ami-1515f67c' for 32 bit and 'ami-ab15f6c2' for 64 bit}
newamiprefix=${AMIBUILDER_NEW_AMI_PREFIX:?Please set AMIBUILDER_NEW_AMI_PREFIX to a string with no spaces.  This string will be prepended to the name of your new AMI}
