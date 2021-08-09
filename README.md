## start kong database
```
docker-compose up -d kong-db
```
## kong database migrations
```
docker-compose run --rm kong kong migrations bootstrap --vv
```
## start kong
```
docker-compose up -d kong
```
## konga database migration
```
docker-compose run konga-init
```
## start konga
```
docker-compose up -d konga
```
### upgrade kong
```
docker-compose run --rm kong kong migrations up --vv
```
### confirm upgrade 
```
docker-compose run --rm kong kong migrations finish --vv
```