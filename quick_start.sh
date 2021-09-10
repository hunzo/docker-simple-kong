#!/bin/bash

# Start kong database 
docker-compose up -d kong-db

# Check database start finished
export CHECK="starting"

while [ "$CHECK" != "healthy" ]
do
    CHECK=$(docker inspect --format {{.State.Health.Status}} kong-db)
    sleep 3
    echo "db state = $CHECK"
done

# Kong database migration
echo "Start Database Migrations"
echo "-------------------------"
docker-compose run --rm kong kong migrations bootstrap --vv

# Start kong
echo "Start Kong"
echo "-------------------------"
docker-compose up -d kong

# Konga Database migrations
echo "Start Konga database migrations"
echo "-------------------------"
docker-compose run konga-init

# Start Konga
echo "Start Konga"
echo "-------------------------"
docker-compose up -d konga

echo "Installed Successfully"
echo "kong admin: http://localhost:8001"
echo "kong service: http://localhost:80"
echo "konga: http://localhost:1337"
