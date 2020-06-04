# Debian - Python - Mod_Wsgi
# 

Based on [github user carlostighe's repo](https://github.com/carlostighe/apache-flask)

This repo is for use as a base image for multiple other services build on:
    
    - Debian buster
    - apache2
    - mod-wsgi
    - python3
    - flask

Other docker builds will add their own apps and conf files

Many of the docker repo's out there use flask local server in their images.
This repo is for a more production ready environment.

The command to run the `Dockerfile` is:

`docker run -d -p 80:80 --name <name> base-apache2-flask`

Alternatively, you can use docker-compose with:

`docker-compose up -d`

 * Download the repo
 * build the image: `docker build -t base-apache2-flask .`


#### The docker file runs through the following steps:  

 - get the latest debian image  
 - install the requirements for python and flask on debian  
 - copies over our files including the default app
 - replaces the default config file for apache with one linking to our default app
 - expose port 80  
 - point the container to the application directory  
 - the run command. 
