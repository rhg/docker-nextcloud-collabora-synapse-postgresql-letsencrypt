FROM alpine

RUN apk add --no-cache postfix cyrus-sasl-plain

COPY mail.sh /opt/mail.sh

VOLUME [ "/var/spool/postfix" ]
EXPOSE 25

ENTRYPOINT [ "sh", "/opt/mail.sh" ]
