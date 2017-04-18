FROM openjdk:alpine
MAINTAINER Jin Van <usconan@gmail.com>

ENV SERVER_PORT 25565

WORKDIR /minecraft

USER root

COPY ./settings-local.sh /minecraft/settings-local.sh
COPY ./ServerStart.sh /minecraft/ServerStart.sh

RUN adduser -D minecraft && \
    apk --no-cache add curl wget && \
    mkdir -p /minecraft/world && \
    mkdir -p /minecraft/cfg && \
    mkdir -p /minecraft/backups &&\
    wget -c "https://addons-origin.cursecdn.com/files/2402/868/Invasion 1.0.4 Server.zip" -O server.zip && \
    unzip server.zip && \
    chmod u+x *.sh && \
    echo "eula=true" > /minecraft/eula.txt && \
    echo "[]" > /minecraft/cfg/ops.json && \
    echo "[]" > /minecraft/cfg/whitelist.json && \
    echo "[]" > /minecraft/cfg/banned-ips.json && \
    echo "[]" > /minecraft/cfg/banned-players.json && \
    ln -s /minecraft/cfg/ops.json /minecraft/ops.json && \
    ln -s /minecraft/cfg/whitelist.json /minecraft/whitelist.json && \
    ln -s /minecraft/cfg/banned-ips.json /minecraft/banned-ips.json && \
    ln -s /minecraft/cfg/banned-players.json /minecraft/banned-players.json && \

    chown -R minecraft:minecraft /minecraft

USER minecraft

VOLUME ["/minecraft/world"]
VOLUME ["/minecraft/cfg"]
VOLUME ["/minecraft/backups"]

EXPOSE ${SERVER_PORT}

CMD ["/bin/sh", "/minecraft/ServerStart.sh"]