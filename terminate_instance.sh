#!/bin/sh

echo "terminating $instanceid"
result=$(ec2-terminate-instances   \
  --private-key "$privatekey" \
  --cert "$cert" \
  "$instanceid")
echo "$result"
