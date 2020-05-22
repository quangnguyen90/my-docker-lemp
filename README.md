# my-docker-lemp
### Set up
- install docker from docker hub
- run following command line to build image: docker-compose build
- run following command line to run container: docker-compose up -d
- ssh to lemp_php container: docker exec -it lemp_php bash

### Connect mysql
- host : mysql
- username : root
- password : 123456
- database : lemp_mysql
- port : 3306

### Stack
- nginx stable alpine
- php 7.4
- mysql:5.7.29
- redis: lastest
- phpMyAdmin