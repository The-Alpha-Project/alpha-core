FROM python:3.11-alpine

WORKDIR /var/wow
COPY requirements.txt .
RUN pip3 install -r requirements.txt

ENTRYPOINT ["python3", "main.py", "-l", "world"]
