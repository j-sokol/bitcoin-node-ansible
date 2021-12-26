#!/bin/bash

BUCKET=$1
CHAN_BACKUP=$2

aws s3 mb "s3://$BUCKET/"
aws s3api put-bucket-versioning --bucket "$BUCKET" --versioning-configuration Status=Enabled

while true; do
    inotifywait $CHAN_BACKUP
    aws s3 cp $CHAN_BACKUP "s3://$BUCKET/"
done
