# XMage Server

## Usage
    docker run --rm -it \
        -p 17171:17171 \
        -p 17179:17179 \
        --add-host example.com:0.0.0.0 \
        -e "XMAGE_DOCKER_SERVER_ADDRESS=example.com" \
        goesta/xmage-server


XMage needs to know the domain name the server is running on. The `--add-host` option adds an entry to the containers `/etc/hosts` file for this domain. 
Using the `XMAGE_*` environment variables you can modify the `config.xml` file.
You should always set `XMAGE_DOCKER_SERVER_ADDRESS` to the same value as `--add-host`.

If you dont have a Domain you can use a service like http://nip.io.

If you like to preserve the database during updates and restarts you can mount a volume at /xmage/db


## Example Docker Compose file

    version: '2'
    services:
    mage:
        image: goesta/xmage-server
        ports:
         - "17171:17171"
         - "17179:17179"
        extra_hosts:
         - "example.com:0.0.0.0"
        environment:
         - XMAGE_DOCKER_SERVER_ADDRESS=example.com
         - XMAGE_DOCKER_SERVER_NAME=xmage-server
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
