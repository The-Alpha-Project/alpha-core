FROM pstauffer/inotify

WORKDIR /tmp

ADD ./init.sh /init.sh
RUN chmod 750 /init.sh

CMD ["/init.sh"]
