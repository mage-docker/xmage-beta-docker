FROM alpine/git as git
WORKDIR /build
COPY ENV /build/
RUN ls
RUN . /build/ENV \
 && echo $RELEASE_TAG \
 && git clone --branch $RELEASE_TAG --depth 1 https://github.com/magefree/mage.git

FROM maven:3-jdk-8 as builder
WORKDIR /mage/src
COPY --from=git /build/mage .

RUN mvn clean install -DskipTests \
 && cd Mage.Server \
 && mvn assembly:assembly \
 && unzip target/mage-server.zip -d xmage-server

FROM openjdk:8-jre-alpine
ENV XMAGE_DOCKER_SERVER_ADDRESS="0.0.0.0" \
    XMAGE_DOCKER_PORT="17171" \
    XMAGE_DOCKER_SEONDARY_BIND_PORT="17179" \
    XMAGE_DOCKER_MAX_SECONDS_IDLE="600" \
    XMAGE_DOCKER_AUTHENTICATION_ACTIVATED="false" \
    XMAGE_DOCKER_SERVER_NAME="mage-server"

EXPOSE 17171 17179
WORKDIR /xmage
COPY --from=builder /mage/src/Mage.Server/xmage-server .
COPY dockerStartServer.sh /xmage/

RUN chmod +x \
    /xmage/startServer.sh \
    /xmage/dockerStartServer.sh

CMD [ "./dockerStartServer.sh" ]
