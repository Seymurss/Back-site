FROM php:8.1-apache

# Composer quraşdır
RUN apt-get update && apt-get install -y unzip git curl libzip-dev zip \
    && docker-php-ext-install pdo_mysql zip

# Laravel kodunu qovluğa kopyala
COPY . /var/www/html/

# Public folderi root kimi göstər
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Apache konfiqurasiya
RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!/var/www/html/public!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Apache mod rewrite aktiv et
RUN a2enmod rewrite

# Composer yüklə
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Laravel permission (opsional)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 80
