# Simple rtsp looped sample server

This is just a deployment tool to serve all mp4/H.264 files in the videos/ folder over RTSP (on rtsp://IP/file.mp4).

It uses
* https://github.com/aler9/rtsp-simple-server
* ffmpeg (static build from https://johnvansickle.com/ffmpeg/)

Requirements:
* make

## Install as a service

```
sudo make install
sudo systemctl enable --now rtsp-loop-server.service
```

## Running

```
make run
```
