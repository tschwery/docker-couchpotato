FROM alpine
MAINTAINER Thomas Schwery <thomas@inf3.ch>

## Update base image and install prerequisites
RUN apk add --no-cache --virtual .fetch-deps \
        python2 py2-lxml py2-openssl py2-pip curl

ENV PYTHONIOENCODING="UTF-8"

## Used to initialize the settings
RUN pip install crudini

RUN mkdir /couchpotato
WORKDIR /couchpotato

RUN curl -SL https://github.com/CouchPotato/CouchPotatoServer/archive/master.zip -o cps.zip \
    && unzip cps.zip \
    && rm cps.zip \
    && mv CouchPotatoServer-master/* . \
    && rm -rf CouchPotatoServer-master

EXPOSE 5050

ENV GROUPID 1000
ENV USERID 1000
ENV GROUPNAME couchpotato
ENV USERNAME couchpotato
ENV USER_HOME /home/couchpotato

RUN addgroup -g ${GROUPID} -S ${USERNAME}
RUN adduser -S -G ${USERNAME} -u ${USERID} -s /bin/bash -h ${USER_HOME} ${USERNAME}

RUN mkdir /home/couchpotato/.couchpotato
ADD conf/settings-defaults.conf /home/couchpotato/.couchpotato/settings.conf

RUN chown couchpotato:couchpotato -R /home/couchpotato
ADD start.sh /start.sh

USER couchpotato

ENTRYPOINT ["/start.sh"]
CMD ["python2", "/couchpotato/CouchPotato.py"]
