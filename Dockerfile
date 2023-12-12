FROM php:8.1-apache-bullseye
ENV ENV_FILE_PATH .env

RUN cd /tmp && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN cd /tmp && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

RUN cd /tmp && php composer-setup.php

RUN cd /tmp && php -r "unlink('composer-setup.php');"
RUN mv /tmp/composer.phar /usr/local/bin/composer

RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash -

RUN apt-get update -y && apt install git libzip-dev libpng-dev unzip nodejs libcurl4-openssl-dev pkg-config libssl-dev -y

RUN docker-php-ext-install zip gd mysqli pdo pdo_mysql

RUN pecl install mongodb && docker-php-ext-enable mongodb

RUN rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY ./run.sh /usr/local/bin/run.sh

RUN chmod u+x /usr/local/bin/run.sh
