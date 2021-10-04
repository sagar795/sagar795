FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
COPY ./script.sh /
RUN chmod +x /script.sh
RUN /script.sh
COPY ./info.php /var/www/html/info.php
RUN apt-get install wget -y
RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN cp -R wordpress /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 775 /var/www/html
COPY ./user.sh /
RUN chmod +x /user.sh
RUN /user.sh
RUN cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
RUN sed -i 's/database_name_here/mysite/' /var/www/html/wp-config.php
RUN sed -i 's/username_here/mysiteadmin/' /var/www/html/wp-config.php
RUN sed -i 's/password_here/123s/' /var/www/html/mysite.com/wp-config.php
RUN cd /etc/apache2/sites-enabled/
RUN service apache2 restart
RUN service mysql restart
EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]
