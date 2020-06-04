############################################################
# Dockerfile to build Flask App
# Based on
############################################################

# Set the base image and metadata
FROM debian:buster-slim
LABEL maintainer="wolfang.torres@gmail.com"
LABEL version="0.5"
LABEL description="This is custom Docker Image for debian Buster, apache2, mod-wsgi, python3 and flask"

# install all basics dependencies
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-wsgi-py3 \
    python3 \
    python3-pip \
    python3-wheel \
    python3-flask* \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/*

# Copy over the apache configuration file and wsgi
COPY . /var/www/default
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Run configurations
RUN a2enmod headers
EXPOSE 80
WORKDIR /var/www/default

CMD  /usr/sbin/apache2ctl -D FOREGROUND
