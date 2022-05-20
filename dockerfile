FROM alpine:3.13

# for laravel lumen run smoothly
RUN apk --no-cache add \
php8 \
php8-fpm \
php8-pdo \
php8-mbstring \
php8-openssl

# for our code run smoothly
RUN apk --no-chace add \
php8-json \
php8-dom \
curl \
php8-curl

# for swagger run smoothly
RUN apk --no-cache add \
php8-tokenizer

# for composer & our project depency run smoothly
RUN apk --no-cache add \
php8-phar \
php8-xml \
php8-xmlwriter

# if need composer to update plugin / vendor used
RUN php8 -r "copy('http://getcomposer.org/installer', 'composer-setup.php');" && \
php8 composer-setup.php --install-dir=/usr/bin --filename=composer && \
php8 -r "unlink('composer-setup.php');"

# copy all of the file in folder to /src
COPY . /src
WORKDIR /src

RUN composer update

# run the php server service
# move this command to -> docker-compose.yml
# CMD php -S 0.0.0.0:8080 public/index.php