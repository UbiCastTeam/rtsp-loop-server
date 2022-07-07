DOCKER_REGISTRY ?= registry.ubicast.net
DOCKER_IMG ?= ${DOCKER_REGISTRY}/mediacoder/simple-rtsp-looped-sample-server


rtsp-simple-server:
	wget -qO- https://github.com/aler9/rtsp-simple-server/releases/download/v0.19.2/rtsp-simple-server_v0.19.2_linux_amd64.tar.gz | tar xvz

ffmpeg-5.0.1-amd64-static/ffmpeg:
	wget -qO- https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz | tar xJvf -

clean:
	rm -rf ffmpeg-* rtsp-simple-server*

run: rtsp-simple-server ffmpeg-5.0.1-amd64-static/ffmpeg
	python3 serve.py


install: rtsp-simple-server ffmpeg-5.0.1-amd64-static/ffmpeg
	cp rtsp-loop-server.service /etc/systemd/system/
	echo ${CURDIR}
	sed -i -e "s#PATH#${CURDIR}#" /etc/systemd/system/rtsp-loop-server.service
	systemctl daemon-reload
	@echo "Run systemctl enable --now rtsp-loop-server.service"
