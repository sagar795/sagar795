#!/bin/bash
service mysql start
mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE mysite;
CREATE USER 'mysiteadmin'@'localhost' IDENTIFIED BY '123s';
GRANT ALL PRIVILEGES ON *.* TO 'mysiteadmin'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
