FROM nginx:stable-alpine

COPY docker/local/nginx/nginx.conf /etc/nginx/nginx.conf
COPY docker/local/nginx/sites-available/lempdemo.conf /etc/nginx/conf.d/lempdemo.conf
COPY docker/local/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

COPY src/public /var/www/lempdemo/public