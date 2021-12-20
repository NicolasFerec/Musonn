FROM debian:9

RUN echo "**** install packages ****" \
&& apt-get update -yq \
&& apt-get install python3-venv python3-pip ffmpeg -yq \
&& echo "**** install streamrip ****" \
&& pip3 install streamrip simple-term-menu --upgrade \
&& echo "**** cleanup ****" \
&& apt-get clean -y

EXPOSE 6356
VOLUME /config
VOLUME /download

CMD echo "test" > /config/test.txt