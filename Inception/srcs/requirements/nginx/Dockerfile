# base image for docker
FROM debian:bullseye

# Port for https connection
EXPOSE 443

RUN apt-get update && \
    apt upgrade -y && \
    apt-get install -y nginx openssl

RUN mkdir -p /var/www/wordpress && \
    mkdir -p /run/nginx && \
    mkdir -p /etc/nginx/ssl && chmod 700 /etc/nginx/ssl

ARG DOMAIN_NAME

COPY ./tools/${DOMAIN_NAME}.crt /etc/nginx/ssl/
COPY ./tools/${DOMAIN_NAME}.key /etc/nginx/ssl/

COPY ./tools/index.html /var/www/html

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /etc/nginx/conf.d/default.conf

# Start NGINX Server
CMD ["nginx", "-g", "daemon off;"]