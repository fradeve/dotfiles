FROM armv7/armhf-ubuntu_core:latest

MAINTAINER Francesco de Virgilio <francesco.devirgilio@inventati.org>

RUN ln -s /lib/arm-linux-gnueabihf/ld-linux.so.3 /lib/ld-linux.so.3

ADD https://download-cdn.getsync.com/stable/linux-arm/BitTorrent-Sync_arm.tar.gz /usr/bin/btsync.tar.gz
RUN cd /usr/bin && tar -xzvf btsync.tar.gz

RUN useradd -ms /bin/bash fradeve

WORKDIR /home/fradeve

ADD btsync.conf btsync.conf
RUN chown fradeve:fradeve btsync.conf

EXPOSE 8888
EXPOSE 55555

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
