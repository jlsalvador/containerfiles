FROM menci/archlinuxarm

RUN set -ex ;\
	pacman -Syu --noconfirm \
		lxqt openbox \
		tigervnc \
		breeze-icons \
		ttf-dejavu noto-fonts-emoji \
		firefox ;\
	useradd -m -G users user ;\
	fc-cache ;\
	rm -rf /tmp/* /var/cache/pacman/pkg/*

COPY --chown=root:root copy_to_root /

EXPOSE 5900

USER user

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

CMD [ "vncserver", ":0" ]
