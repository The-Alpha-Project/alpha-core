FROM python:3.9-slim-buster

RUN apt update && apt install -y gcc

WORKDIR /var/wow/
COPY requirements.txt ./
RUN pip3 install -r requirements.txt

CMD python3 main.py