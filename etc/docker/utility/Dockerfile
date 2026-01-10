ARG BASE_IMAGE=python:3.13.9-slim-trixie
FROM ${BASE_IMAGE}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y tzdata  mariadb-client \
&& rm -rf /var/lib/apt/lists/*

COPY etc/docker/utility/utility /bin/utility
RUN chmod +x /bin/utility

COPY etc/docker/utility/commands/ /bin/commands/
RUN chmod +x /bin/commands/*.sh

ENTRYPOINT ["/bin/utility"]
