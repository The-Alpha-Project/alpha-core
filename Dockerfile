FROM debian:buster-slim

WORKDIR /var/wow/
CMD python3 main.py

RUN apt update && apt install -y python3-pip

COPY requirements.txt ./
RUN pip3 install -r requirements.txt
