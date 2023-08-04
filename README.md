# Bootcamp Course Service
This service is have feature to 
1. validate auth with hit auth microservice server
2. create course (only can access with Header Authorization JWT oken)
3. list course with pagination (only can access with Header Authorization JWT oken)



## Setup and Installation

1. clone this repository 
2. create new database to store bootcamp.sql
3. import database to mysql 
```
mysql -u username -p database_name < path/to/bootcamp.sql
```
4. copy .env.example file and rename to .env 
5. fill the env with your credentials, you must add database credential and this 
```
APP.AUTH_SERVICE_BASE_URL=base-url-auth-service
APP.AUTH_SERVICE_VALIDATE_URL=path-url-to-the-service
```
6. run go generate command in root project to setup project
```
go generate ./...
```

## Run and Test
To run this server, run this command in root terminal 
```
go run . 
```