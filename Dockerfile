FROM php:8.2-cli

RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

RUN composer global require laravel/installer
ENV PATH="$PATH:/root/.composer/vendor/bin"