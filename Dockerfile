FROM devopsedu/webapp

MAINTAINER Aravindh

#Update Repository
RUN apt update

#Install Apache
RUN apt -y install apache2

#Install PHP Modules
RUN apt -y install php libapache2-mod-php

#Copy Application Files
RUN rm -rf /var/www/html/*
COPY * /var/www/html/

#Open port 80
EXPOSE 8080

#Start Apache service
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]



