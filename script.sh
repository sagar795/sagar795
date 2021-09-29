#!/bin/bash
apt update
apt install apache2 -y
service apache2 start
apt install -y  mariadb-server mariadb-client
service mariadb start
apt install -y  php libapache2-mod-php php-mysql
apt install -y  php-redis php-zip
cp  /info.php /var/www/html/info.php
apt-get install wget -y
wget http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
cp -R wordpress /var/www/html/mysite.com
chown -R www-data:www-data /var/www/html/mysite.com
chmod -R 775 /var/www/html/mysite.com
service mysql start
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE mysite;
CREATE USER 'mysiteadmin'@'%' IDENTIFIED BY '123s';
GRANT ALL PRIVILEGES ON mysite.* TO 'mysiteadmin'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
service mysql restart
cp /var/www/html/mysite.com/wp-config-sample.php /var/www/html/mysite.com/wp-config.php
sed -i 's/database_name_here/mysite/' /var/www/html/mysite.com/wp-config.php
sed -i 's/username_here/mysiteadmin/' /var/www/html/mysite.com/wp-config.php
sed -i 's/password_here/123s/' /var/www/html/mysite.com/wp-config.php
cd /etc/apache2/sites-enabled/
sed -i "s,/var/www/html,/var/www/html/mysite.com,g" /etc/apache2/sites-enabled/000-default.conf
service apache2 restart
service mysql restart
