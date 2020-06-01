FROM nginx:stable-alpine

COPY docker/local/nginx/conf.d/lempdemo.conf /etc/nginx/conf.d/lempdemo.conf
COPY docker/local/nginx/nginx.conf /etc/nginx/nginx.conf

COPY src/public /var/www/lempdemo/public