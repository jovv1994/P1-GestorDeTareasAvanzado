FROM php:8.2-fpm

RUN useradd -u 1000 -ms /bin/bash app

RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

WORKDIR /var/www/html

RUN chown -R app:app /var/www/html

USER app

RUN composer global require laravel/installer
ENV PATH="$PATH:/home/app/.composer/vendor/bin"