#! /bin/bash

for host in dst src; do
  echo "FLUSH VM CACHES"
  sync; echo 3 |sudo tee /proc/sys/vm/drop_caches >/dev/null
  ./exec.sh $host /data/test.sh
done
