FROM devilbox/php-fpm-8.1:latest

RUN echo "**** update packages ****" \
&& apt update -y && apt upgrade -y

COPY app/ ./
RUN echo "**** install symfony ****" \
&& apt install curl unzip git -y \
&& wget https://get.symfony.com/cli/installer -O - | bash \
&& curl -sS https://getcomposer.org/installer -o composer-setup.php \
&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
&& composer install

RUN echo "**** install streamrip ****" \
&& apt install python3 python3-venv python3-pip -y \
&& python3 -m pip install streamrip simple-term-menu --upgrade 
COPY streamrip-config.toml /root/.config/streamrip/config.toml

RUN echo "**** cleanup ****" \
&& apt-get clean -y

VOLUME /config
VOLUME /download

EXPOSE 6356

CMD ["symfony", "server:start"]