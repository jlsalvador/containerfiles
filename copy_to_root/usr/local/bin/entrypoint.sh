#!/usr/bin/env bash
set -e

if [[ "${DEBUG}z" != "z" ]]; then
    set -x
fi

mkdir -p ~/.vnc

cat > ~/.vnc/config <<EOF
session=lxqt
geometry=${RESOLUTION:-1920x1080}
alwaysshared
localhost=0
EOF

if [[ "${PASSWORD}z" == "z" ]]; then
    echo "securitytypes=none" >> ~/.vnc/config
else
    echo "${PASSWORD}" | vncpasswd -f > ~/.vnc/passwd
fi

exec "$@"
