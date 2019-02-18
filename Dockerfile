FROM ushahidi/php-fpm-nginx:php-7.0

WORKDIR /var/www

RUN apt-get update && apt upgrade -y && apt-get install -y \
      unzip \
      rsync \
      nano \
      netcat-openbsd \
      supervisor \
      cron \
      git

RUN apt dist-upgrade -y
RUN echo "deb http://deb.debian.org/debian stretch-backports main" > /etc/apt/sources.list && \
echo "deb http://deb.debian.org/debian stretch main" >> /etc/apt/sources.list && \
apt update && apt upgrade -y && \
apt-get install -y python-certbot-nginx -t stretch-backports

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY run.sh /run.sh
COPY build_env.sh /build_env.sh
COPY dist/ /dist

ENV SERVER_FLAVOR=nginx \
    PHP_FPM_CONFIG=/etc/php/7.0/fpm \
    PHP_FPM_PATH=/usr/sbin/php-fpm7.0

ENTRYPOINT [ "/bin/bash", "/run.sh" ]
