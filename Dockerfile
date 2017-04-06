FROM alpine
MAINTAINER Martin Baillie <martin.t.baillie@gmail.com>

ENV CONFD_VERSION               0.12.2-martinbaillie
ENV CONFD_LOG_LEVEL             debug
ENV CONFD_RANCHER_API_PREFIX    latest

RUN apk add --update --no-cache curl && \
    curl -fSL https://github.com/martinbaillie/confd/releases/download/v0.12.2-martinbaillie/confd-${CONFD_VERSION}-linux-amd64 \
        -o /bin/confd && \
    chmod +x /bin/confd

ADD run.sh /run.sh
ENTRYPOINT ["/run.sh"]

ONBUILD ADD ./conf.d /etc/confd/conf.d
ONBUILD ADD ./templates /etc/confd/templates
