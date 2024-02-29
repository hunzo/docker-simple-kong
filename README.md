# Kong installation

- create docker network

```shell
docker network rm proxy-network
docker network create proxy-network
```

- start kong database

```shell
docker-compose up -d kong-db
```

- kong database migrations `--v(verbose)`, `--vv(debug)`

```shell
docker-compose run --rm kong kong migrations bootstrap --vv
```

- start kong

```shell
docker-compose up -d kong
```

# Konga installation

- konga database migration

```shell
docker-compose run konga-init
```

- start konga

```shell
docker-compose up -d konga
```

# Upgrade Kong Version

> chage version in .env file ex. TAG=version_number

- upgrade kong `--v(verbose)`, `--vv(debug)`

```shell
docker-compose run --rm kong kong migrations up --vv
```

- confirm upgrade

```shell
docker-compose run --rm kong kong migrations finish --vv
```

- start kong

```shell
docker-compose up -d kong
```

# Migrate Kong

## Export database

### create .pgpass for kong database password

```
kong
```

- create export script

```bash
#!/bin/bash

kongdb=kong
kongadb=konga_db
kong_version=kong:3.0.0-alpine

docker compose exec -t kong-db pg_dump -c --username=kong --dbname=$kongdb > dump_"$kongdb"_"$kong_version"_`date +%Y-%m-%d`.sql
docker compose exec -t kong-db pg_dump -c --username=kong --dbname=$kongadb > dump_"$kongadb"_`date +%Y-%m-%d`.sql
```

## Import database

### import kong db

```bash
cat dump_kong_kong:3.0.0-alpine_2024-02-29.sql | docker exec -i kong-db psql -U kong -d kong
```

### import konga db

```bash
docker compose exec -t kong-db psql -U kong -c 'CREATE DATABASE konga_db;'
cat dump_konga_db_2024-02-29.sql | docker exec -i kong-db psql -U kong -d konga_db
```

# Quick Start

```shell
./quick_start.sh
```

```shell
./start.sh
```
