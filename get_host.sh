#!/bin/sh

while host=$(ec2-describe-instances \
  --private-key "$privatekey" \
  --cert "$cert" \
   "$instanceid" | \
  egrep ^INSTANCE | cut -f4) && test -z $host; do echo -n .; sleep 1; done
sleep 5 # give SSH daemon time to come up - should be another while loop
echo host=$host