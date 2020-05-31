CREATE DATABASE IF NOT EXISTS lemp_mysql;
USE lemp_mysql;
# import db: docker exec -i your_container_mysql_name mysql -uroot -pqwerty DB_NAME < your_local_db_dump.sql
# export db: docker exec -i your_container_mysql_name mysqldump -uroot -pqwerty DB_NAME > your_local_db_dump.sql