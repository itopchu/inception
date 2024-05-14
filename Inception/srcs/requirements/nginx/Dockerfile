# base image for docker
FROM debian:bullseye

# Port for https connection
EXPOSE 443

# gettext-base is needed for env expasion
RUN apt-get update \
    && apt-get install -y nginx gettext-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG DOMAIN_NAME

# Certificate cloning from host machine
RUN mkdir -p /etc/nginx/

COPY ./tools/${DOMAIN_NAME}.crt /etc/nginx/ssl/
COPY ./tools/${DOMAIN_NAME}.key /etc/nginx/ssl/

# Config cloning from host machine
COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf.template

# Variable expansion in config file
RUN envsubst '$DOMAIN_NAME' < /etc/nginx/conf.d/nginx.conf.template > /etc/nginx/conf.d/nginx.conf
RUN rm -f /etc/nginx/conf.d/nginx.conf.template

# Start NGINX Server
CMD ["nginx", "-g", "daemon off;"]