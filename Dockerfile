FROM ubuntu:22.04

#RUN echo "deb http://deb.debian.org/debian/ unstable main" > /etc/apt/sources.list.d/unstable-wireguard.list && \
# printf 'Package: *\nPin: release a=unstable\nPin-Priority: 90\n' > /etc/apt/preferences.d/limit-unstable

RUN apt update -y && apt upgrade -y \
 apt install -y --no-install-recommends wireguard iptables nano net-tools && \
 apt clean

WORKDIR /scripts
ENV PATH="/scripts:${PATH}"
COPY install-module /scripts
COPY run /scripts
COPY genkeys /scripts
COPY net-up /scripts
COPY net-down /scripts
RUN chmod 755 /scripts/*

CMD ["run"]
