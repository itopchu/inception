FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y nginx \
    && mkdir -p /etc/nginx/ssl

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/*.crt /etc/nginx/ssl/
COPY tools/*.key /etc/nginx/ssl/

CMD ["nginx", "-g", "daemon off;"]