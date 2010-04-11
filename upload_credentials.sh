#!/bin/sh

rsync \
  --rsh="ssh -i $keypair" \
  --rsync-path="sudo rsync" \
  $privatekey \
  ubuntu@$host:/mnt/

rsync \
  --rsh="ssh -i $keypair" \
  --rsync-path="sudo rsync" \
  $cert \
  ubuntu@$host:/mnt/
