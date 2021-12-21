FROM debian:11

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install python3 python3-venv python3-pip -y

EXPOSE 6356

CMD ["python3", "-m", "SimpleHTTPServer", "6356"]






#&& echo "**** install streamrip ****" \
#&& python3 -m pip install streamrip simple-term-menu --upgrade \
#&& echo "**** cleanup ****" \
#&& apt-get clean -y

#VOLUME /config
#VOLUME /download