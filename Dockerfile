FROM caddy:latest

RUN apk add nss-tools curl

COPY caddy_conf/Caddyfile /etc/caddy/Caddyfile
