FROM alpine:latest

RUN \
    apk add --no-cache tor; \
    echo "SOCKSPort 0.0.0.0:9050" > /etc/tor/torrc

USER tor
ENTRYPOINT ["tor"]
CMD ["-f", "/etc/tor/torrc"]

COPY Dockerfile /
