#! /bin/bash

id=$(docker compose ps --format json|jq -r --arg name "$1" 'select(.Name == $name)|.ID')
shift

/usr/bin/time --format %E docker exec -it "${id}" $@
