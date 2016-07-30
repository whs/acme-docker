FROM alpine
ENV ACME_VERSION=0.0.54

COPY acme.sh /etc/periodic/daily/acme.sh
COPY start.sh /start.sh

RUN chmod +x /etc/periodic/daily/acme.sh \
	&& apk add --no-cache openssl ca-certificates \
	&& wget -O -  https://github.com/hlandau/acme/releases/download/v$ACME_VERSION/acmetool-v$ACME_VERSION-linux_amd64.tar.gz | tar xzf - \
	&& echo "/acmetool-v$ACME_VERSION-linux_amd64/bin/acmetool --state=/certs/ \$*" > /usr/bin/acmetool \
	&& mkdir -p /certs/root/ /certs/certs/

CMD ["/start.sh"]
