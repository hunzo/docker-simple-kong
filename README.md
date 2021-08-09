# Kong installation
- start kong database
```
docker-compose up -d kong-db
```
- kong database migrations `--v(verbose), --vv(debug)`
```
docker-compose run --rm kong kong migrations bootstrap --vv
```
- start kong
```
docker-compose up -d kong
```

# Konga installation
- konga database migration
```
docker-compose run konga-init
```
- start konga
```
docker-compose up -d konga
```

# Upgrade Kong Version
> chage version in .env file ex. TAG=version_number
- upgrade kong  `--v(verbose), --vv(debug)`
```
docker-compose run --rm kong kong migrations up --vv
```
- confirm upgrade 
```
docker-compose run --rm kong kong migrations finish --vv
```
- start kong
```
docker-compose up -d kong
```