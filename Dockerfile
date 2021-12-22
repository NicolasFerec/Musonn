FROM php:8.1.1-fpm

ENV BRANCH main
ENV APP_ENV prod

# Updating packages
RUN apt-get update -y && apt-get upgrade -y

# Installing streamrip
RUN apt-get install python3 python3-venv python3-pip -y \
&& python3 -m pip install streamrip simple-term-menu --upgrade
COPY streamrip-config.toml /root/.config/streamrip/config.toml

# Installing symfony
RUN apt-get install curl wget unzip git libicu-dev -y \
&& docker-php-ext-configure intl \
&& docker-php-ext-install intl \
&& wget https://get.symfony.com/cli/installer -O - | bash \
&& mv /root/.symfony/bin/symfony /usr/local/bin/symfony \
&& curl -sS https://getcomposer.org/installer -o composer-setup.php \
&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
&& rm composer-setup.php 

# Cleaning up
RUN apt-get clean -y 

VOLUME /config
VOLUME /download

EXPOSE 8000

COPY ./init.sh ./
CMD ["sh", "./init.sh"]