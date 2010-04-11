#!/bin/sh

# 64-bit
instanceid=$(ec2-run-instances   \
  --private-key "$privatekey" \
  --cert "$cert" \
  --availability-zone us-east-1a \
  --instance-type "$instancetype" \
  "$ami" |
  egrep ^INSTANCE | cut -f2)
echo "instanceid=$instanceid"
instanceid=$instanceid