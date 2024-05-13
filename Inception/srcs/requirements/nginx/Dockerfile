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

COPY ./tools/${DOMAIN_NAME}.crt /etc/ssl/${DOMAIN_NAME}.crt
COPY ./tools/${DOMAIN_NAME}.key /etc/ssl/${DOMAIN_NAME}.key

# Config cloning from host machine
COPY ./conf/nginx.conf /etc/nginx/sites-available/nginx.conf.template

# Variable expansion in config file
RUN envsubst '$DOMAIN_NAME' < /etc/nginx/sites-available/nginx.conf.template > /etc/nginx/sites-available/nginx.conf
RUN rm -f /etc/nginx/sites-available/nginx.conf.template

# Start NGINX Server
CMD ["nginx", "-g", "daemon off;"]