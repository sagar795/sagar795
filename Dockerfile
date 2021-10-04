FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
COPY ./info.php /
COPY ./script.sh /
RUN chmod +x /script.sh
RUN /script.sh
EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]
