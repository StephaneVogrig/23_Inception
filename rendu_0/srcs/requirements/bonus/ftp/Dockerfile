FROM alpine:3.21

RUN apk update \
	&& apk upgrade \
	&& apk add --no-cache vsftpd \
    && rm -rf /var/cache/apk/*

COPY ./vsftpd.conf /etc/vsftpd.conf

COPY entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh

EXPOSE 21
EXPOSE 21100-21110

ENTRYPOINT ["/scripts/entrypoint.sh"]