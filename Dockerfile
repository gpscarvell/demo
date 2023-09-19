FROM python:3.9-slim-buster

WORKDIR /app

COPY microservice-app/requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY microservice-app/app.py .

EXPOSE 8080

CMD [ "python", "./app.py" ]