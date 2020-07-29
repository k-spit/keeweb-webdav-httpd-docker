FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y apache2 \
    && apt-get install -y unzip \
    && apt-get install -y git \
    && apt-get install -y wget \
    && apt-get install apache2-utils -y \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/keeweb/keeweb/releases/download/v1.14.0/KeeWeb-1.14.0.html.zip \
    && unzip KeeWeb-1.14.0.html.zip -d /keeweb

RUN mkdir /certs
COPY cert.pem /certs
COPY key.pem /certs

RUN mkdir -p /keeweb/kdbx
COPY keeweb.kdbx /keeweb/kdbx
COPY config.json /keeweb/config.json
RUN cp -r /keeweb /var/www/

COPY htpasswd /var/www/keeweb/htpasswd

RUN sed -i 's#<meta name="kw-config" content="(no-config)">#<meta name="kw-config" content="config.json">#' /keeweb/index.html

COPY keeweb.conf /etc/apache2/sites-available/keeweb.conf

RUN a2enmod ssl

RUN a2enmod dav

RUN a2enmod dav_fs

WORKDIR /var/www/keeweb

RUN chown -R www-data:www-data kdbx

RUN chmod -R g+rw kdbx

WORKDIR /etc/apache2/sites-available

RUN a2ensite keeweb.conf 

EXPOSE 80 443

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
