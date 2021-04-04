FROM postgres:13-alpine

RUN sed -e 's/#\(huge_pages = \)try/\1off/g' -i /usr/local/share/postgresql/postgresql.conf.sample

