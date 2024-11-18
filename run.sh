docker compose build
find data/dst/mail/ -mindepth 1 -maxdepth 1 -print0|xargs -0 rm -rf
docker compose up
