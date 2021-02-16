FROM alpine:3.13.0

RUN apk add --no-cache unbound

COPY unbound.conf /etc/unbound/unbound.conf
EXPOSE 5335

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
	CMD ["netstat -an | grep 5335 > /dev/null; if [ 0 != $? ]; then exit 1; fi;"]

ENTRYPOINT ["unbound", "-d", "-v"]