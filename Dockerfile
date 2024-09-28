ARG VERSION=12

FROM postgres:${VERSION}-alpine

RUN set -ex ;\
	apk add --no-cache musl-locales musl-locales-lang ;\
	sed -e 's/#\(huge_pages = \)try/\1off/g' -i /usr/local/share/postgresql/postgresql.conf.sample
