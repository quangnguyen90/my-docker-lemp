# my-docker-lemp
### 🚀 Set up
- install docker from docker hub & also docker-compose
   * (MacOS use Docker for mac)
   * (Window 10 pro use Docker for window)
   * (Window 10 Home use Docker toolbox)

- run following command line to build image: docker-compose build
- run following command line to run container: docker-compose up -d
- ssh to lemp_php container: docker exec -it lemp_php bash

### 🚀 Docker command
- List the containers: docker-compose ps
- Stop containers docker compose: docker-compose stop
- Remove containers docker compose: docker-compose rm -f
- Stop all Docker containers: docker stop $(docker ps -a -q)
- Remove all Docker containers: docker rm $(docker ps -a -q)
- Remove all Docker images: docker rmi $(docker images -q)
- stop docker-compose: docker-compose down
- Restart service docker-compose: docker-compose restart

### 🚀 Connect mysql
- host : 127.0.0.1
- username : root
- password : 123456
- database : lemp_mysql
- port : 3307

### 🚀 Using a virtual host

- On your machine, run `$ sudo nano /etc/hosts` and add `127.0.0.1  www.lempdemo.local`
- Change the server name in `docker/local/nginx/conf.d/lempdemo.conf` to `lempdemo.local`
- Run `$ docker-compose up` again.

### Check Browser
- localhost:8000 -> web
- localhost:8080 -> phpMyAdmin
- localhost:8081 -> redisCommander

### 🚀 Stack
- nginx stable alpine
- php 7.2
- mysql:5.7
- redis: latest
- redisCommander: latest
- phpMyAdmin