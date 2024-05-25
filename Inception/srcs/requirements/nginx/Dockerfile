FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y nginx openssl \
    && mkdir -p /etc/nginx/ssl

COPY ./tools /etc/nginx/ssl
COPY ./conf/nginx.conf /tmp/default.conf

RUN sed -i "s/\${DOMAIN_NAME}/${DOMAIN_NAME}/g" /tmp/default.conf \
    && echo < /tmp/default.conf > /etc/nginx/sites-available/default \
    && mv /etc/nginx/ssl/index.html /var/www/html/index.html

CMD ["nginx", "-g", "daemon off;"]