FROM node:20.11.1
RUN apt-get update && apt-get install -y gosu

RUN mkdir /frontend
WORKDIR /frontend

COPY . /frontend

ADD entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]