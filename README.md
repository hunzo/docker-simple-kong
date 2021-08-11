# Kong installation
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
- upgrade kong  `--v(verbose)`, `--vv(debug)`
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
# Quick Start 
```shell
./quick_start.sh
```