FROM amazoncorretto:8-alpine

# Set XMage config defaults
ENV LANG=C.UTF-8 \
    XMAGE_DOCKER_SERVER_ADDRESS="0.0.0.0" \
    XMAGE_DOCKER_PORT="17171" \
    XMAGE_DOCKER_SEONDARY_BIND_PORT="17179" \
    XMAGE_DOCKER_MAX_SECONDS_IDLE="600" \
    XMAGE_DOCKER_AUTHENTICATION_ACTIVATED="false" \
    XMAGE_DOCKER_SERVER_NAME="mage-server"

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
