FROM ubuntu:latest

RUN set -ex ;\
	apt update ;\
	apt dist-upgrade -y ;\
	apt install -y --no-install-recommends \
		lxqt openbox \
		tigervnc-standalone-server tigervnc-tools \
		breeze-icon-theme \
		fonts-dejavu fonts-noto-color-emoji \
		firefox ;\
	useradd -m -G users user ;\
	fc-cache ;\
	rm -rf /tmp/* /var/cache/apt/archives/*

COPY --chown=root:root copy_to_root /

EXPOSE 5900

USER user

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

CMD [ "vncserver", "-fg", ":0" ]
