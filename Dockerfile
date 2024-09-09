FROM alpine:latest

ENV UID=1000 \
	GID=1000

RUN <<EOF
set -ex
apk add --no-cache \
	ca-certificates \
	musl-locales musl-locales-lang \
	offlineimap \
	mutt
addgroup -g ${GID} user
adduser -u ${UID} -G user -D user
install -o ${UID} -g ${GID} -d /home/user/Mail
install -o ${UID} -g ${GID} -d /var/mail/user
EOF

USER user
WORKDIR /home/user

CMD [ "offlineimap" ]
