FROM composer as build

ENV COMPOSER_MEMORY_LIMIT -1
ENV GIT_LHC https://github.com/LiveHelperChat/livehelperchat.git
ENV TAG_LHC 3.68v

WORKDIR /app
RUN apk upgrade --update && apk add \
    git \
    coreutils \
    freetype-dev \
    libjpeg-turbo-dev \
    libltdl \
    libmcrypt-dev \
    libpng-dev \
    && git clone --depth 1 --branch ${TAG_LHC}  ${GIT_LHC} lhc \
    && echo ${PWD} \
    && cd ./lhc/lhc_web \
    && composer install --no-dev --optimize-autoloader --no-ansi --no-interaction --profile --no-plugins --verbose --ignore-platform-reqs 

FROM php:fpm-alpine
COPY --from=build /app/lhc/lhc_web /var/www/lhc
WORKDIR /var/www/lhc

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS zlib-dev libpng libpng-dev \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-install mysqli pdo pdo_mysql gd \
    && cp $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini \
    && sed -i "s/;date.timezone =.*/date.timezone = America\/Sao_Paulo/" $PHP_INI_DIR/php.ini \
    && sed -i "s/error_reporting =.*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/" $PHP_INI_DIR/php.ini \
    && sed -i "s/display_errors = Off/display_errors = On/" $PHP_INI_DIR/php.ini \
    && sed -i "s/upload_max_filesize = .*/upload_max_filesize = 10M/" $PHP_INI_DIR/php.ini \
    && sed -i "s/post_max_size = .*/post_max_size = 12M/" $PHP_INI_DIR/php.ini \
    && sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" $PHP_INI_DIR/php.ini \
    && chown -R www-data:www-data /var/www/lhc/var /var/www/lhc/cache /var/www/lhc/settings 
