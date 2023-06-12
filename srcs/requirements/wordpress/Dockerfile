FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y php7.4-fpm php-pear php-cgi php-common php-zip php-mbstring php-net-socket php-gd php-xml-util php-mysql php-php-gettext php-bcmath wget mariadb-client mariadb-server sendmail

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/" /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

RUN touch /var/log/php7.4-fpm.log && \
	mkdir -p /var/www/html && \ 
    chown www-data:www-data /var/log/php7.4-fpm.log && \
    mkdir -p /var/www/wordpress && \
    chown -R www-data:www-data /var/www/wordpress /var/log/php7.4-fpm.log /var/www/html/ /var/www/ && \
    chmod -R u+w /var/www/html/ /var/www/wordpress /var/www/ /var/log/php7.4-fpm.log

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]
