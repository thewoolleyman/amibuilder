#!/bin/sh

while host=$(ec2-describe-instances \
  --private-key "$privatekey" \
  --cert "$cert" \
   "$instanceid" | \
  egrep ^INSTANCE | cut -f4) && test -z $host; do echo -n .; sleep 1; done
echo host=$host