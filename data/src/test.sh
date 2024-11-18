#! /bin/bash

echo "removing destination data"
ssh dst "find /data/mail/ -mindepth 1 -maxdepth 1 -print0|xargs -0 rm -rf"

for task in full delta; do
  echo "src: $task push sync to destination"
  USER=placeholder /usr/bin/time --format %E doveadm \
    -o mail_uid=1000 \
    -o mail_gid=1000 \
    -o mail_home=/tmp \
    -o mail_location=maildir:/data/mail \
  sync -1 ssh dst doveadm \
    -o mail_uid=1000 \
    -o mail_gid=1000 \
    -o mail_fsync=never \
    -o mail_home=/tmp \
    -o mail_location=maildir:/data/mail dsync-server
done
