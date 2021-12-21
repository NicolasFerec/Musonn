FROM debian:11

RUN echo "**** install packages ****" \
&& apt-get update -y && apt-get upgrade -y \
&& apt-get install python3 python3-venv python3-pip -y \
&& echo "**** cleanup ****" \
&& apt-get clean -y

RUN echo "**** install streamrip ****" \
&& python3 -m pip install streamrip --upgrade 

#simple-term-menu

COPY index.html ./

VOLUME /config
VOLUME /download

EXPOSE 6356

CMD ["python3", "-m", "http.server", "6356"]