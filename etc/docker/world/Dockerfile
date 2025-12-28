ARG BASE_IMAGE=python:3.14.2-slim-trixie
FROM ${BASE_IMAGE}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /var/wow
COPY requirements.txt .
RUN pip3 install -r requirements.txt

ENTRYPOINT ["python3", "main.py", "-l", "world"]
