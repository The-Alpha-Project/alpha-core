ARG BASE_IMAGE=python:3.14.2-slim-trixie
FROM ${BASE_IMAGE}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /var/wow
COPY requirements.txt .
RUN pip3 install -r requirements.txt
COPY etc/docker/wait_for_db.py /usr/local/bin/wait_for_db.py

ENTRYPOINT ["python3", "/usr/local/bin/wait_for_db.py", "python3", "main.py", "-l", "world"]
