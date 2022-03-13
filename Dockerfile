FROM ubuntu:20.04
LABEL maintainer="Mohamed Foly"
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install -y \
    supervisor \
    php8.1-cli \
    php8.1-mbstring \
    php8.1-bcmath \
    php8.1-xml \
    php8.1-zip \
    php8.1-mysql \
    php8.1-swoole \
    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && apt-get update \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY php.ini /etc/php/8.1/cli/conf.d/99-sizes.ini