FROM php:7.2-fpm

LABEL author="Quang Nguyen Phu"
LABEL maintainer="nguyenphuquang90@gmail.com"
LABEL build_date="2020-05-22"

RUN mkdir /var/www/lempdemo

# Set working directory
WORKDIR /var/www/lempdemo

# Set timezone
ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN "date"

RUN apt-get update && apt-get -y install git && apt-get -y install vim

# Install dependencies
RUN apt-get install -y libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/include \
    && docker-php-ext-install gd

RUN  apt-get install -y libmcrypt-dev \
    libmagickwand-dev --no-install-recommends \
    && pecl install mcrypt-1.0.2 \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-enable mcrypt

#install zip extensions`
RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install required PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl dom soap

# Configure the gd library
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/

# Install nodejs
RUN apt-get -y install nodejs && apt-get -y install npm

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
COPY ./src /var/www/lempdemo

# Copy existing application directory permissions
COPY --chown=www:www . /var/www/lempdemo

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]