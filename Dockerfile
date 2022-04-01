FROM archlinux:latest

ENV RESOLUTION=1920x1080

EXPOSE 5900

RUN set -ex ;\
	pacman -Syu --noconfirm \
		lxqt openbox ttf-dejavu \
		firefox firefox-i18n-es-es \
		tigervnc ;\
	mkdir -p /root/.vnc ;\
	echo -e "session=lxqt\ngeometry=${RESOLUTION}\nalwaysshared\nsecuritytypes=none" > /root/.vnc/config ;\
	rm -rf /tmp/* /var/lib/

CMD [ "vncserver", ":0" ]
