FROM php:apache AS apache
RUN docker-php-ext-install pdo pdo_mysql mysqli
RUN mkdir /var/www/llibres && mkdir /var/www/camisetes
RUN mkdir /etc/apache2/certs
COPY ./volumes/certs/ /etc/apache2/certs/
COPY ./volumes/llibres/ /var/www/llibres	
COPY ./volumes/llista-camisetes/ /var/www/camisetes
COPY ./volumes/conf/llibres.conf /etc/apache2/sites-available/
COPY ./volumes/conf/camisetes.conf /etc/apache2/sites-available/
RUN a2ensite llibres.conf && a2ensite camisetes.conf







FROM mysql:8.0 AS db

COPY ./volumes/llibres/books.sql /docker-entrypoint-initdb.d/



FROM phpmyadmin:latest as myadmin
