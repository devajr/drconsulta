FROM alpine:3.14

# Install packages and remove default server definition
RUN apk --no-cache add \
  curl \
  nginx \
  php8 \
  php8-ctype \
  php8-curl \
  php8-dom \
  php8-fpm \
  php8-gd \
  php8-intl \
  php8-json \
  php8-mbstring \
  php8-mysqli \
  php8-opcache \
  php8-openssl \
  php8-phar \
  php8-session \
  php8-xml \
  php8-xmlreader \
  php8-zlib \
  php8-redis \
  php8-xmlwriter \
  php8-tokenizer \
  php8-pdo \
  php8-pdo_mysql \
  supervisor

# Create symlink so programs depending on `php` still function
RUN ln -s /usr/bin/php8 /usr/bin/php

# Add composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer


# Configure nginx


# Add application
WORKDIR /var/www/html/

# Install composer dependencies
RUN composer install

# Expose the port nginx is reachable on
EXPOSE 80

# Entrypoint script starts supervisord
# Use it for any processing during container launch
# Example generate .env file from a secrets manager
