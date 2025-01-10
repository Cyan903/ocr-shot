FROM python:3.10

WORKDIR /app

COPY ./requirements.txt /app/requirements.txt
RUN python -m pip install -r /app/requirements.txt

COPY . .
EXPOSE 5000

CMD ["python", "./src/server.py"]
