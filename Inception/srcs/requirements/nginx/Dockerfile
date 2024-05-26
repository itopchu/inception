FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y nginx \
    && mkdir -p /etc/nginx/ssl

COPY tools/*.crt /etc/nginx/ssl/
COPY tools/*.key /etc/nginx/ssl/
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
RUN sed -i "s/\${DOMAIN_NAME}/${DOMAIN_NAME}/g" /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]