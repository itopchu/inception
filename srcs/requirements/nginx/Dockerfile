FROM debian:bullseye

EXPOSE 80
EXPOSE 443

RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /run/nginx
RUN mkdir -p /etc/nginx/conf.d/

RUN apt-get update && apt-get install -y \
nginx \
openssl

COPY ../tools/ /etc/nginx/ssl/
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]