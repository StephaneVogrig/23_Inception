FROM alpine:3.21

RUN apk update \
	&& apk upgrade \
	&& apk add --no-cache \
		nginx \
		openssl \
    && rm -rf /var/cache/apk/*

COPY server.conf /etc/nginx/http.d

RUN mkdir -p /etc/nginx/ssl/ \
	&& apk add openssl \
	&& openssl req \
		-x509 \
		-nodes \
		-out /etc/nginx/ssl/inception.crt \
		-keyout /etc/nginx/ssl/inception.key \
		-subj "/C=FR/ST=NA/L=Angouleme/O=42/OU=42/CN=svogrig.42.fr/UID=svogrig"

EXPOSE 443

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
