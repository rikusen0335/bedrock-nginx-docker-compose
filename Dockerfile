FROM php:fpm
# https://hub.docker.com/_/php?tab=tags

RUN apt-get update && docker-php-ext-install mysqli pdo_mysql