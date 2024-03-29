FROM node:16.17.0 AS node
FROM php:7.4-fpm-buster

COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /opt /opt
COPY --from=composer:1.10.26 /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
  cron \
  git \
  gzip \
  libbz2-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng-dev \
  libsodium-dev \
  libssh2-1-dev \
  libxslt1-dev \
  libzip-dev \
  lsof \
  default-mysql-client \
  vim \
  zip \
  wget \
  zsh fish \
  gnupg libonig-dev \
  nodejs npm yarn

RUN pecl install apcu

RUN docker-php-ext-enable apcu

RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install \
  bcmath \
  bz2 \
  calendar \
  exif \
  gd \
  gettext \
  intl \
  mysqli \
  opcache \
  pcntl \
  pdo_mysql \
  soap \
  sockets \
  sodium \
  sysvmsg \
  sysvsem \
  sysvshm \
  xsl \
  zip

RUN pecl channel-update pecl.php.net
RUN pecl install xdebug-3.1.6

RUN docker-php-ext-enable xdebug 

RUN groupadd -g 1000 app \
 && useradd -g 1000 -u 1000 -d /var/www -s /bin/zsh app

RUN printf '* *\t* * *\tapp\t%s/usr/local/bin/php /var/www/html/update/cron.php\n' >> /etc/crontab \
  && printf '* *\t* * *\tapp\t%s/usr/local/bin/php /var/www/html/bin/magento cron:run\n' >> /etc/crontab \
  && printf '* *\t* * *\tapp\t%s/usr/local/bin/php /var/www/html/bin/magento setup:cron:run\n#\n' >> /etc/crontab

COPY ./www.conf /usr/local/etc/php-fpm.d/
COPY ./php.ini /usr/local/etc/php/
COPY ./php-fpm.conf /usr/local/etc/
COPY bin/cronstart /usr/local/bin/

RUN mkdir -p /etc/nginx/html /var/www/html /sock \
  && chown -R app:app /etc/nginx /var/www /usr/local/etc/php/conf.d /sock

RUN chown -R 1000:1000 /var/www/html

USER app:app

VOLUME /var/www

WORKDIR /var/www/html

EXPOSE 9001
EXPOSE 9003
ENV XDEBUG_PORT 9003
