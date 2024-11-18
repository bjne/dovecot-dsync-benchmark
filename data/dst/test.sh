#! /bin/bash
#
echo "removing destination data"
find /data/mail/ -mindepth 1 -maxdepth 1 -print0|xargs -0 rm -rf

for task in full delta; do
  echo "dst: $task pull sync from src"
  USER=placeholder /usr/bin/time --format %E doveadm \
    -o mail_uid=1000 \
    -o mail_gid=1000 \
    -o mail_fsync=never \
    -o mail_home=/tmp \
    -o mail_location=maildir:/data/mail \
  sync -1 -R ssh src doveadm \
    -o mail_uid=1000 \
    -o mail_gid=1000 \
    -o mail_home=/tmp \
    -o mail_location=maildir:/data/mail dsync-server
done
