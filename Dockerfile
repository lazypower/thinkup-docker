FROM ubuntu:trusty

MAINTAINER "Charles Butler <charles.butler@ubuntu.com>"

# Fetch predependencies
RUN apt-get update && apt-get install -y git apache2 \
                                             php5-mysql \
                                             libapache2-mod-php5 \
                                             unzip \
                                             curl \
                                             libcurl3 \
                                             php5-curl \
                                             php5-mcrypt \
                                             php5-gd \
                                             wget

# Fetch Thinkup - release
RUN wget https://github.com/ThinkUpLLC/ThinkUp/releases/download/v2.0-beta.10/thinkup-2.0-beta.10.zip --no-check-certificate -O /tmp/thinkup.zip && cd /tmp && unzip thinkup.zip -d /var/www && rm -rf /var/www/html && mv /var/www/thinkup /var/www/html

#RUN cp /var/www/html/config.sample.inc.php /var/www/html/config.php

RUN chown -R www-data /var/www/html/data/

# Fix obnoxious output by apache2
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf && a2enconf fqdn

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND

