FROM alpine:3.8

LABEL Maintainer="Anugerah Erlaut <aerlaut@live.com>" \
      Description="Container based on trafex/alpine-nginx-php7"

# Add User and group, then change directory
RUN addgroup -g 1024 dev && \
    adduser -D -u 500 -G dev dev

# Install packages
RUN apk --no-cache add php7 \
    php7-json \
    php7-mbstring \
    php7-openssl \
    php7-pdo_mysql \
    php7-session \
    php7-common \
    php7-tokenizer \
    php7-mcrypt \
    php7-fileinfo \
    php7-cli \
    php7-zip \
    php7-fpm \
    php7-curl \
    php7-xml \
    php7-dom \
    php7-xmlreader \
    php7-ctype \
    php7-gd \
    nginx \
    supervisor \
    curl

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zz-custom.conf
COPY config/php.ini /etc/php7/conf.d/zz-custom.ini

# Configure supervisord 
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www/html
COPY src/ /var/www/html/public/

RUN chown -R dev:dev /var/www/html

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
