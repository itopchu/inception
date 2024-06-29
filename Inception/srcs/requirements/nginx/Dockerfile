FROM debian:bullseye

EXPOSE 443

RUN apt-get update && apt-get install -y \
	nginx \
	openssl

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/
COPY ./tools/create_cert.sh /tmp/

RUN chmod +x /tmp/create_cert.sh

ENTRYPOINT ["/tmp/create_cert.sh"]

CMD ["nginx", "-g", "daemon off;"] 
