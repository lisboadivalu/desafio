FROM php:8.3-fpm

WORKDIR /var/www

COPY composer.lock composer.json /var/www/

RUN apt-get update && apt-get install -y \
    zip \
    nano \
    vim \
    unzip \
    git \
    curl

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . .
COPY .env .

COPY --chown=www:www . /var/www
EXPOSE 9000
CMD ["php-fpm"]
