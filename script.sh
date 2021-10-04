#!/bin/bash
apt update
apt install apache2 -y
service apache2 start
apt install -y  mariadb-server mariadb-client
service mariadb start
apt install -y  php libapache2-mod-php php-mysql
apt install -y  php-redis php-zip
service apache2 restart
