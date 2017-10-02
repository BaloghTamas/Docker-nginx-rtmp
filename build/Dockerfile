FROM alpine:latest
MAINTAINER Balogh Tamás <balogh.tamas@autsoft.hu>

ENV NGINX_VERSION 1.13.5

RUN	apk update		&&	\
	  apk add				\
		git			\
		gcc			\
		binutils-libs		\
		binutils		\
		gmp			\
		isl			\
		libgomp			\
		libatomic		\
		libgcc			\
		openssl			\
		pkgconf			\
		pkgconfig		\
		mpfr3			\
		mpc1			\
		curl      \
		libstdc++		\
		ca-certificates		\
		libssh2			\
		curl			\
		expat			\
		pcre			\
		musl-dev		\
		libc-dev		\
		pcre-dev		\
		zlib-dev		\
		openssl-dev		\
		make


RUN	cd /tmp/									&&	\
	curl -L -O http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz			&&	\
	git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git

RUN	cd /tmp &&	\
	tar xzf nginx-${NGINX_VERSION}.tar.gz &&	\
	cd nginx-${NGINX_VERSION} &&	\
	./configure \
		--prefix=/opt/nginx \
		--with-http_ssl_module \
		--add-module=../nginx-rtmp-module &&	\
	make &&	\
	make install


RUN	cd /opt/ 	&&	\
	tar cvzf /tmp/nginx.tar.gz nginx

EXPOSE 1935

CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]
