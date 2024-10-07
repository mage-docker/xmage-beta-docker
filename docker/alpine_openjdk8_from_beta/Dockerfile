FROM amazoncorretto:8-alpine

# Set XMage config defaults
ENV LANG=C.UTF-8 \
    XMAGE_DOCKER_SERVER_ADDRESS="0.0.0.0" \
    XMAGE_DOCKER_PORT="17171" \
    XMAGE_DOCKER_SEONDARY_BIND_PORT="17179" \
    XMAGE_DOCKER_MAX_SECONDS_IDLE="600" \
    XMAGE_DOCKER_AUTHENTICATION_ACTIVATED="false" \
    XMAGE_DOCKER_SERVER_NAME="mage-server" \
    XMAGE_DOCKER_MAILGUN_API_KEY="" \
    XMAGE_DOCKER_MAILGUN_DOMAIN="" \
    XMAGE_DOCKER_MAIL_SMTP_HOST="" \
    XMAGE_DOCKER_MAIL_SMTP_PORT="" \
    XMAGE_DOCKER_MAIL_USER="" \
    XMAGE_DOCKER_MAIL_PASSWORD="" \
    XMAGE_DOCKER_MAIL_FROM_ADDRESS="" \
    XMAGE_DOCKER_MAX_GAME_THREADS="10" \
    XMAGE_DOCKER_MAX_AI_OPPONENTS="15" \
    XMAGE_DOCKER_JAVA_OPTS="-Xmx1024m -XX:MaxPermSize=384m -Dlog4j.configuration=file:./config/log4j.properties"

# Install dependencies
RUN set -ex && \
    apk upgrade --update && \
    apk add --update curl ca-certificates bash jq

# Download latest xmage
WORKDIR /xmage

RUN curl --silent --show-error http://xmage.today/config.json | jq '.XMage.location' | xargs curl -# -L > xmage.zip \
 && unzip xmage.zip -x "mage-client*" \
 && rm xmage.zip \
 && apk del curl jq

COPY dockerStartServer.sh /xmage/mage-server/

RUN chmod +x \
    /xmage/mage-server/startServer.sh \
    /xmage/mage-server/dockerStartServer.sh

EXPOSE 17171 17179

WORKDIR /xmage/mage-server

CMD [ "./dockerStartServer.sh" ]
