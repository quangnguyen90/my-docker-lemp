FROM php:7.4-fpm-alpine

LABEL author="Quang Nguyen Phu"
LABEL maintainer="nguyenphuquang90@gmail.com"
LABEL build_date="2020-05-22"

ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set working directory
WORKDIR /var/www/lempdemo

# Install dependencies
RUN apt-get update && apt-get install -y \
    autoconf \
	dpkg-dev \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libicu-dev \
    libxslt1-dev \ 
    sendmail-bin \ 
    sendmail \ 
    sudo \
    libonig-dev \
    libzip-dev
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libmcrypt-dev \
    mysql-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install required PHP extensions
RUN docker-php-ext-install mcrypt pdo_mysql mbstring zip exif pcntl gd dom soap

# Configure the gd library
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --no-scripts

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