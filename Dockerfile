FROM php:8.1.1-fpm

ENV BRANCH main
ENV APP_ENV prod

#FROM devilbox/php-fpm-8.1:latest

RUN echo "**** Updating packages... ****" \
&& apt-get update -y && apt-get upgrade -y \
&& echo "**** Done! ****"

RUN echo "**** Installing symfony... ****" \
&& apt-get install curl wget unzip git libicu-dev -y \
&& docker-php-ext-configure intl \
&& docker-php-ext-install intl \
&& wget https://get.symfony.com/cli/installer -O - | bash \
&& mv /root/.symfony/bin/symfony /usr/local/bin/symfony \
&& curl -sS https://getcomposer.org/installer -o composer-setup.php \
&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
&& rm composer-setup.php \
&& echo "**** Done! ****"
#&& composer install

RUN echo "**** Installing streamrip... ****" \
&& apt-get install python3 python3-venv python3-pip -y \
&& python3 -m pip install streamrip simple-term-menu --upgrade \
&& echo "**** Done! ****"
COPY streamrip-config.toml /root/.config/streamrip/config.toml

RUN echo "**** Cleaning up... ****" \
&& apt-get clean -y \
&& echo "**** Done! ****"

VOLUME /config
VOLUME /download

EXPOSE 8000

#CMD ["symfony", "server:start"]

COPY ./init.sh ./
CMD ["sh", "./init.sh"]