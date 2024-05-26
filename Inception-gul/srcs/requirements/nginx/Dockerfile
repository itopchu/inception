FROM debian:bullseye

RUN apt update -y \
    && apt upgrade -y \
    && apt-get install -y nginx openssl \
    && mkdir -p /etc/nginx/ssl && chmod 700 /etc/nginx/ssl && \
    mkdir -p /var/www/wordpress && \
    mkdir -p /run/nginx

COPY ./tools /etc/nginx/ssl
COPY ./conf/nginx.conf /tmp/default.conf

RUN sed -i "s/\${DOMAIN_NAME}/${DOMAIN_NAME}/g" /tmp/default.conf \
    && echo < /tmp/default.conf > /etc/nginx/conf.d/default.conf \
    && mv /etc/nginx/ssl/index.html /var/www/html/index.html

CMD ["nginx", "-g", "daemon off;"]