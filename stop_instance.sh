#!/bin/sh

echo "stopping $instanceid"
result=$(ec2-stop-instances   \
  --private-key "$privatekey" \
  --cert "$cert" \
  "$instanceid")
echo "$result"
