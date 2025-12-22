FROM ubuntu:latest

RUN set -ex ;\
	apt update ;\
	apt install -y --no-install-recommends \
		ca-certificates ;\
	rm -rf /tmp/* /var/cache/apt/archives/*

COPY --chown=root:root copy_to_root /

RUN set -ex ;\
	apt update ;\
	apt dist-upgrade -y ;\
	apt install -y --no-install-recommends \
		dbus-x11 lxqt openbox \
		tigervnc-standalone-server tigervnc-tools \
		papirus-icon-theme \
		fonts-dejavu fonts-noto-color-emoji \
		libgtk-3-0t64 \
		libfuse2t64 \
		gvfs gvfs-fuse gvfs-backends \
		firefox \
		curl \
		flatpak kde-config-flatpak;\
	useradd -m -G users user -s /bin/bash ;\
	fc-cache ;\
	rm -rf /tmp/* /var/cache/apt/archives/*

RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

EXPOSE 5900

USER user

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

CMD [ "vncserver", "-fg", "--I-KNOW-THIS-IS-INSECURE", ":0" ]
