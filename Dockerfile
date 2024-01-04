FROM ubuntu:20.04

RUN apt-get update && apt-get install -y systemd

RUN apt-get install -y wget && \
    wget -qO- https://github.com/yudai/gotty/releases/download/v2.0.0/gotty_linux_amd64.tar.gz | tar xvz && \
    mv gotty /usr/local/bin/gotty && \
    chmod +x /usr/local/bin/gotty

RUN echo '[Unit]\nDescription=gotty\nAfter=network.target\n\n[Service]\nExecStart=/usr/local/bin/gotty -w bash\nRestart=on-failure\nUser=root\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/gotty.service

STOPSIGNAL SIGRTMIN+3

CMD ["/sbin/init"]
