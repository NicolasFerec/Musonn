FROM debian:11

RUN echo "**** install packages ****" \
&& apt-get update -y && apt-get upgrade -y \
&& apt-get install python3 python3-venv python3-pip -y \
&& echo "**** cleanup ****" \
&& apt-get clean -y

RUN echo "**** install streamrip ****" \
&& python3 -m pip install streamrip simple-term-menu --upgrade 

COPY index.html ./
COPY streamrip-config.toml /root/.config/streamrip/config.toml

VOLUME /config
VOLUME /download

EXPOSE 6356

RUN rip url https://www.deezer.com/fr/track/10199750

CMD ["python3", "-m", "http.server", "6356"]