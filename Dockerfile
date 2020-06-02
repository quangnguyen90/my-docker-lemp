FROM php:7.2-fpm

LABEL author="Quang Nguyen Phu"
LABEL maintainer="nguyenphuquang90@gmail.com"
LABEL build_date="2020-05-22"

RUN mkdir /var/www/lempdemo

COPY ./src/composer.json /var/www/lempdemo/

# Set working directory
WORKDIR /var/www/lempdemo

# Set timezone
ENV TZ=Asia/Ho_Chi_Minh
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
    && docker-php-ext-install pdo_mysql mysqli \
    && docker-php-ext-enable mcrypt

# Install nodejs
RUN apt-get -y install nodejs && apt-get -y install npm

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

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --no-scripts

# Add user for web application
RUN groupmod -g 1000 www-data && \
    usermod -u 1000 www-data

# Copy existing application directory contents
COPY ./src /var/www/lempdemo
COPY ./docker/local/php/php.ini /usr/local/etc/conf.d/php.ini
COPY ./docker/local/php/www.conf /usr/local/etc/php-fpm.d/www.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/lempdemo/public

# Add user for web application
#RUN groupadd -g 1000 www
#RUN useradd -u 1000 -ms /bin/bash -g www www

#Copy existing application directory permissions
#COPY --chown=www:www . /var/www/lempdemo

# Change current user to www
#USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
