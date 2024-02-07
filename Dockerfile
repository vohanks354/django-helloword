# pull the official base image
FROM quay.io/vohanks3540/python:3.10

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip3 install --upgrade pip setuptools wheel configparser
COPY . /usr/src/app
RUN pip3 install -r requirements.txt && \
    chmod 777 /usr/src/app && \
    chmod 777 /usr/src/app/django-entrypoint.sh

EXPOSE 8090
CMD ["python", "manage.py", "runserver", "0.0.0.0:8090"]

ENTRYPOINT [ "/usr/src/app/django-entrypoint.sh" ]