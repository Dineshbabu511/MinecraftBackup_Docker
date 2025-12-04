FROM itzg/minecraft-server:java21

COPY utils /usr/local/bin/

COPY scripts/ /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
