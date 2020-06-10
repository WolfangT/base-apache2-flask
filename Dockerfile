############################################################
# Dockerfile to build Flask App
# Based on httpd on bullseye-slim
############################################################

# Set the base image and metadata
FROM debian:bullseye-slim

LABEL maintainer="wolfang.torres@gmail.com"
LABEL version="0.8"
LABEL description="This is custom Docker Image for debian bullseye, apache2, mod-wsgi, python3 and flask"

ARG DEBIAN_FRONTEND=noninteractive
ENV SRV_DIR /srv/www
ENV INS_DIR /var/lib
ENV LOG_DIR /var/log
ENV CONF_DIR /etc/apache2/sites-enabled

# install all basics dependencies
RUN apt update && apt install -y \
    python3 \ 
    python3-pip \
    python3-wheel \
    apache2 \
    libapache2-mod-wsgi-py3 \
 && apt clean -y \
 && apt autoremove -y \
 && rm -rf /var/lib/apt/lists/* 

# Copy over the apache configuration file and wsgi
WORKDIR ${SRV_DIR}/default
COPY . ${SRV_DIR}/default
COPY ./000-default.conf ${CONF_DIR}/000-default.conf
RUN mkdir ${INS_DIR}/default_app ${LOG_DIR}/default_app \
 && chown www-data:www-data ${INS_DIR}/default_app ${LOG_DIR}/default_app \
 && python3 -m pip install -e . \
 && a2enmod headers

# Run configurations
VOLUME ${LOG_DIR}/apache2
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
