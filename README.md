Debian - Python - Mod_Wsgi 
==========================

Based on [github user carlostighe's repo](https://github.com/carlostighe/apache-flask)

This repo is for use as a base image for multiple other services build on:

 - Debian buster
 - apache2
 - mod-wsgi
 - python3
 - flask

Many of the docker repo's out there use flask local server in their images.
This repo is for a more production ready environment.


Developers
----------

This image provides a base from wich other docker builds will add their own apps and conf files.

It exposes the folowing ENV variables:

 - SRV_DIR (/srv/www): this is where the app should put their code
 - INS_DIR (/var/lib): this is where app should create their instance folder
 - LOG_DIR (/var/log): this is where app should store their logs
 - CONF_DIR (/etc/apache2/sites-available): apps should copy their conf files to this dir and and use a2ensite ro enable them

Overwrite this ENV to change them, for example change SRV_DIR to /var/www

Ideally app should uses volumes to save their instance and log folders 
   

Run
---

The command to run the `Dockerfile` is:

    docker run -d -p 80:80 --name <name> wolfangtorres/base-apache2-flask

Alternatively, you can use docker-compose with:

    docker-compose up -d


Build
-----

Download the repo and build the image: 

    docker build -t base-apache2-flask .

### The docker file runs through the following steps:  

 - get the oficial image httpd:2.4 image
 - set metadata en enviroment variables  
 - install the requirements for python and flask on debian  
 - copies over our files including the default app
 - replaces the default config file for apache with one linking to our default app
 - expose port 80  
 - point the container to the application directory  
 - the run command. 
