FROM php:8.3-apache-bullseye

# Systempakete installieren
RUN apt-get update && apt-get install -y \
    nano \
    apache2-utils \
    libc-client-dev \
    libssl-dev \
    libkrb5-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libzip-dev \
    libonig-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype-dev \
    libwebp-dev \
    libxpm-dev \
    unzip \
    git \
    curl \
    ca-certificates \
    && docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-configure gd --with-jpeg --with-freetype --with-webp --with-xpm \
    && docker-php-ext-install imap mysqli soap curl xml zip mbstring gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y libldap2-dev \
    && docker-php-ext-install ldap \
    && docker-php-ext-enable ldap

# Cron installieren
RUN apt-get update && apt-get install -y cron

# Composer installieren
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"


# ionCube Loader installieren
RUN curl -sSL https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o ioncube.tar.gz \
    && tar -xzf ioncube.tar.gz \
    && PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;") \
    && EXT_DIR=$(php -r "echo ini_get('extension_dir');") \
    && cp ioncube/ioncube_loader_lin_${PHP_VERSION}.so $EXT_DIR \
    && echo "zend_extension=$EXT_DIR/ioncube_loader_lin_${PHP_VERSION}.so" > /usr/local/etc/php/conf.d/00-ioncube.ini \
    && rm -rf ioncube.tar.gz ioncube

# Cron installieren
RUN apt-get update && apt-get install -y cron

# Cronjob für starter2.php einrichten
RUN echo "* * * * * www-data /usr/local/bin/php /var/www/html/cronjobs/starter2.php > /dev/null 2>&1" >> /etc/crontab

# Rechte setzen
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html

COPY memory.ini "$PHP_INI_DIR/conf.d/"

# Port freigeben
EXPOSE 80

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

