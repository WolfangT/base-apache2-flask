############################################################
# Dockerfile to build Flask App
# Based on httpd on buster-slim
############################################################

# Set the base image and metadata
FROM httpd:2.4
LABEL maintainer="wolfang.torres@gmail.com"
LABEL version="0.6"
LABEL description="This is custom Docker Image for debian Buster, apache2, mod-wsgi, python3 and flask"

ENV SRV_DIR /srv/www
ENV INS_DIR /var/lib
ENV LOG_DIR /var/log
ENV CONF_DIR /etc/apache2/sites-available
RUN mkdir ${INS_DIR}/default_app ${LOG_DIR}/default_app

# install all basics dependencies
RUN apt update && apt-get install -y \
    libapache2-mod-wsgi-py3 \
    python3 \
    python3-pip \
    python3-wheel \
 && apt clean \
 && apt autoremove \
 && rm -rf /var/lib/apt/lists/* 

# Copy over the apache configuration file and wsgi
COPY . ${SRV_DIR}/default
COPY ./000-default.conf ${CONF_DIR}/000-default.conf
RUN a2enmod headers
WORKDIR ${SRV_DIR}/default
RUN python -m pip install -e .

# Run configurations
VOLUME ${LOG_DIR}/apache2
EXPOSE 80
CMD ["httpd-foreground"]
