FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx

COPY ../conf/nginx.conf /etc/nginx/nginx.conf

COPY ../conf/certificate.crt /etc/nginx/ssl/certificate.crt
COPY ../conf/private.key /etc/nginx/ssl/private.key

EXPOSE 443
