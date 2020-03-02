FROM python:3

RUN mkdir -p /usr/src/elastic

WORKDIR /usr/src/elastic

COPY requirements.txt .

RUN pip install -r requirements.txt

ADD . .

CMD [ "python", "main.py" ]