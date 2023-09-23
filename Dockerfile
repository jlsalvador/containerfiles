FROM alpine
CMD curl
RUN apk add --no-cache curl jq
COPY Dockerfile /
USER nobody
