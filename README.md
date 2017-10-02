# Docker container for **nginx-rtmp** [![Build Status](https://travis-ci.org/BaloghTamas/Docker-nginx-rtmp.svg?branch=master)](https://travis-ci.org/BaloghTamas/Docker-nginx-rtmp)
Docker image for an **RTMP/HLS** server running on nginx, fork of **JasonRivers/Docker-nginx-rtmp**, using **sergey-dryabzhinsky/nginx-rtmp-module**.

NGINX Version **1.13.5**
nginx-rtmp-module Version **1.1.70**

Additions to **JasonRivers's** repo:
- Using **sergey-dryabzhinsky/nginx-rtmp-module** instead of **arut/nginx-rtmp-module**
- Using **curl** instead of **wget**
- More recent **NGINX* and **RTMP-Module**
- **HTTPS** Self signed cert support
- Updated READ.ME and docker commands

### Configurations
This image exposes port 1935 for RTMP Steams and has 2 channels open "live" and "testing".

Live is also accessable via HLS on port 8080

It also exposes 8080 so you can access http://<your server ip>:8080/stat to see the streaming statistics. - Currently not working

The configuration file is in /opt/nginx/conf/ on docker machine.

### Creating self signed Certificates

Create self signed certs using openssl
`sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ~/docker/nginx-rtmp/nginx.key -out ~/docker/nginx-rtmp/nginx.crt`

### Running

Change `--name stream-server` to any name you wish, and change `~/docker/nginx-rtmp/` any directory on your host machine. Do not map the entire `conf` folder, just the files.

To run the container as a daemon and bind the port 1935(RTMP) 8080(HTTP) 443(HTTPS) to the host machine, and set conf and key files- run the following:
```
docker pull bata/nginx-rtmp

docker run -d \
--name stream-server \
-v ~/docker/nginx-rtmp/nginx.conf:/opt/nginx/conf/nginx.conf \
-v ~/docker/nginx-rtmp/nginx.crt:/opt/nginx/conf/nginx.crt \
-v ~/docker/nginx-rtmp/nginx.key:/opt/nginx/conf/nginx.key \
-p 1935:1935 \
-p 8080:8080 \
-p 443:443 \
-t \
bata/nginx-rtmp
```

### OBS Configuration
Under broadcast settings, set the following parameters:
```
Streaming Service: Custom
Server: rtmp://your.server.ip:1935/live
Play Path/Stream Key: mystream
```

### Watching the steam

In your favorite RTMP video player connect to the stream using the URL:

`rtmp://your.server.ip:1935/live/mystream`

`http://your.server.ip:8080/hls/mystream.m3u8`

`https://your.server.ip/hls/mystream.m3u8`


### Tested players
 * VLC
 * Android - Exoplayer (without HTTPS cert validation - using OkHttp)
