#!/bin/bash

# create network
docker network create proxy-network

# start db
docker compose up -d kong-db

# check db start
while [ "$CHECK" != "healthy" ]
do
    CHECK=$(docker inspect --format {{.State.Health.Status}} kong-db)
    sleep 3
    echo -e "\ndb state = $CHECK"
done


# create kong database
docker compose exec -t kong-db psql -U kong -c 'CREATE DATABASE kong;'

# import kong database
cat ./dump_kong.sql | docker exec -i kong-db psql -U kong -d kong


export LIST_UPGRADE="2.7.1-ubuntu 2.8-ubuntu 3.4-ubuntu 3.5-ubuntu 3.6-ubuntu"

for i in $LIST_UPGRADE
do
  export TAG=$i
  docker compose stop kong
  docker compose run --rm kong kong migrations up --vv
  docker compose run --rm kong kong migrations finish --vv
  docker compose up -d kong

  echo -e "\nUpdate Kong to verions $i success"
  sleep 5
done

# create konga database
docker compose exec -t kong-db psql -U kong -c 'CREATE DATABASE konga_db;'

# import kongadb
cat ./dump_konga_db.sql | docker exec -i kong-db psql -U kong -d konga_db

# start konga services
docker compose up -d konga

echo -e "\nStart konga Success"
