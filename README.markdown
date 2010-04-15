AMIBuilder
==========
Script to automate building a customized Ubuntu EC2 EBS boot AMI, based on Eric Hammond's tutorial at http://alestic.com/2010/01/ec2-ebs-boot-ubuntu

Warning and Disclaimer
======================
WARNING!  This script will automatically create EC2 resources for which you will be charged!  It automatically starts and stops an instance, but if the script fails or is killed the instance may be left running.  Learn how to delete any unwanted resources via the the EC2 console before using this script:  https://console.aws.amazon.com/ec2/home

Requirements
============
An Amazon EC2 account and credentials

Usage
============
Invoke directly from bash or embed and invoke from another tool:

    ./amibuilder

The following environment variables must be set.  You can set them yourself, or paste this into ~/.amibuilderrc and they will be read automatically (replace with your proper values):

    # ~/.amibuilderrc
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

You can also specify an optional <code>AMIBUILDER\_CUSTOM\_SETUP_URL</code> specify the URL of a custom script which will be automatically downloaded and run on the image before the AMI is created:

    ### Custom Image Setup ###
    # AMIBUILDER_CUSTOM_SETUP_URL: the URL of a custom script which will be automatically downloaded and run on the image before the AMI is created
    export AMIBUILDER_CUSTOM_SETUP_URL='http://github.com/username/project/raw/master/custom_image_setup'

You can use a different config location if you wish:

    AMIBUILDER_CONFIG=~/path/to/my/config

Links
=====
* Building an Image: http://alestic.com/2010/01/ec2-ebs-boot-ubuntu
* Download Certs/Keys: https://aws-portal.amazon.com/gp/aws/developer/account/index.html
* Understanding Credentials: http://alestic.com/2009/11/ec2-credentials
* Protecting from data loss: http://alestic.com/2010/01/ec2-instance-locking
* Ubuntu EC2 Images: https://help.ubuntu.com/community/EC2StartersGuide

Viewing Key Info
================
    openssl x509 -in cert-yourid.pem -text
    openssl rsa -in pk-yourid.pem -text
    openssl rsa -in keypair-yourid.pem -text

Developers and Debugging
========================
The following environment variable flags are useful for debugging failing steps of the build without performing a full run each time:

    AMIBUILDER_NO_BUILD: if set, just load the functions, don't run the build
    AMIBUILDER_HOST: if set, use this host for build instead of starting a new instance.  Also skips step to terminate instance
    AMIBUILDER_NO_UPLOAD_CREDENTIALS: if set, skip step to upload EC2 credentials
    AMIBUILDER_NO_UPGRADE_EC2_TOOLS: if set, skip step to upgrade EC2 tools
    AMIBUILDER_NO_TERMINATE_INSTANCE: if set, skip step to terminate instance
    AMIBUILDER_NO_BUILD_IMAGE: if set, skip the step to build the base image
    AMIBUILDER_NO_CUSTOM_SETUP: if set, skip the step to perform custom user image setup
    AMIBUILDER_NO_COPY_IMAGE_TO_AMI: if set, skip the step to copy the completed image to the AMI

So, to leave an instance running so you can debug a custom setup script, you would invoke amibuilder, but not terminate the instance:

    AMIBUILDER_NO_TERMINATE_INSTANCE=true ./amibuilder

When the build completes, look for the hostname in the output:

    ec2-174-129-181-254.compute-1.amazonaws.com was NOT terminated.

Then create a '<code>~/.amibuilderrc\_debug</code>' file with debugging defaults which you can override or disable in order to debug a specific step of the build.  For example, you can use the following to debug your custom setup:

    # ~/.amibuilderrc_debug
    source ~/.amibuilderrc
    export AMIBUILDER_NO_BUILD=false  # set to true if you want to skip entire build and invoke functions manually
    export AMIBUILDER_HOST=ec2-x-x-x-x.compute-1.amazonaws.com  # use running host from previous non-terminated run
    export AMIBUILDER_NO_UPLOAD_CREDENTIALS=true
    export AMIBUILDER_NO_UPGRADE_EC2_TOOLS=true
    export AMIBUILDER_NO_TERMINATE_INSTANCE=true
    export AMIBUILDER_NO_BUILD_IMAGE=true
    export AMIBUILDER_NO_CUSTOM_SETUP=false # set to false to debug your custom setup
    export AMIBUILDER_NO_COPY_IMAGE_TO_AMI=true
    export AMIBUILDER_CUSTOM_SETUP_URL='http://yourserver.com/amibuilder_custom_setup' # Host and edit your file with debugging on some public server

Now you can run amibuilder repeatedly with the debug config, and it will only run the steps you have enabled:

    AMIBUILDER_CONFIG=~/.amibuilderrc_debug ./amibuilder

Now you can create and edit the debugging version of your custom setup script (on yourserver.com/amibuilder\_custom\_setup), then run amibuilder with the debug config repeatedly to download and run it:

    # load debug config
    source ~/.amibuilderrc_debug
    ./amibuilder
    
You could even call functions directly:

    # load debug config
    source ~/.amibuilderrc_debug
    # source amibuilder to load functions without performing build
    AMIBUILDER_NO_BUILD=true source amibuilder
    custom_setup

License
=======
    (The MIT License)

    Copyright (c) 2010 Chad Woolley

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
    documentation files (the 'Software'), to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
    to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of
    the Software.

    THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
    THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
    CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.