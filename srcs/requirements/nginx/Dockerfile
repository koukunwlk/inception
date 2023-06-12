from debian:bullseye-slim

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y openssl

COPY /conf/nginx.conf /etc/nginx/sites-available/default
COPY /tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

entrypoint ["/tmp/entrypoint.sh"]

expose 443
