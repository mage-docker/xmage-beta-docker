# Beta XMage Server Docker Images

This Project automates the creation of Docker Images for beta versions of [XMage](https://github.com/magefree/mage) Server.

You can find the Images at Docker Hub: https://hub.docker.com/r/goesta/xmage-beta

All Images are taged with the version number. So you can run older beta versions by including the tag when creating the container. You can see all available tags on the dockerhub page or on our github page under tags.

Currently the Images are based on alpine and openjdk8. If you would like to see other java or os versions, please [create an issue](https://github.com/mage-docker/xmage-beta-docker/issues).

## Usage
    docker run --rm -it \
        -p 17171:17171 \
        -p 17179:17179 \
        --add-host example.com:0.0.0.0 \
        -e "XMAGE_DOCKER_SERVER_ADDRESS=example.com" \
        goesta/xmage-beta


XMage needs to know the domain name of the server it is running on. The `--add-host` option adds an entry to the containers `/etc/hosts` file for this domain. 
Using the `XMAGE_*` environment variables you can modify the `config.xml` file.
You should always set `XMAGE_DOCKER_SERVER_ADDRESS` to the same value as `--add-host`.

If you dont have a Domain you can use a service like http://nip.io.

If you like to preserve the database during updates and restarts you can mount a volume at /xmage/db


## Example Docker Compose file

    version: '2'
    services:
    mage:
        image: goesta/xmage-beta
        ports:
         - "17171:17171"
         - "17179:17179"
        extra_hosts:
         - "example.com:0.0.0.0"
        environment:
         - XMAGE_DOCKER_SERVER_ADDRESS=example.com
         - XMAGE_DOCKER_SERVER_NAME=xmage-beta
         - XMAGE_DOCKER_MAX_SECONDS_IDLE=6000
         - XMAGE_DOCKER_AUTHENTICATION_ACTIVATED=false
        volumes:
         - xmage-db:/xmage/db
         - xmage-saved:/xmage/saved
    volumes:
        xmage-db:
            driver: local
        xmage-saved:
            driver: local

## Links

[Tutorial - Running XMage on DigitalOcean](https://github.com/goesta/docker-xmage-alpine/wiki/DigitalOcean-Tutorial)

## Client

You can download the latest beta version of xmage at http://xmage.today
