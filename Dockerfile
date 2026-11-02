FROM php:8.5-fpm-alpine

RUN apk upgrade --no-cache \
    && apk add --no-cache zip libzip \
    && apk add --no-cache --virtual .build-deps libzip-dev \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip pdo pdo_mysql \
    && apk del .build-deps

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY conf/security.ini /usr/local/etc/php/conf.d/zz-security.ini

WORKDIR /var/www/html

RUN addgroup -g 1000 www \
    && adduser -G www -g www -s /bin/sh -D www

USER www

EXPOSE 9000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD ["nc", "-z", "127.0.0.1", "9000"]
