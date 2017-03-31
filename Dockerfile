FROM php:7.0.6-fpm

RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install pdo pdo_mysql
# directory structure is important
#COPY ./etc/php /usr/local/etc/

RUN mkdir -p /var/www/web

WORKDIR /var/www

ENV SYMFONY__DATABASE_PORT=3306

COPY /vendor ./vendor
COPY ./app ./app
COPY ./src ./src
COPY ./bin ./bin
COPY ./var/bootstrap.php.cache ./var/bootstrap.php.cache
COPY ./entrypoint.sh ./entrypoint.sh
COPY ./web/ ./web/

# workaround
RUN chown -R www-data:www-data /var/www && usermod -u 1000 www-data

VOLUME /var/www/

ENTRYPOINT ["/var/www/entrypoint.sh"]
CMD ["php-fpm"]
