FROM php:8.5-fpm-alpine

RUN apk add --no-cache zip libzip \
    && apk add --no-cache --virtual .build-deps libzip-dev \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip pdo pdo_mysql \
    && apk del .build-deps

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

RUN addgroup -g 1000 www \
    && adduser -G www -g www -s /bin/sh -D www

USER www
