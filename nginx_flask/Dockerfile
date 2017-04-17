FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y python3-pip python3-dev nginx supervisor

RUN pip3 install uwsgi flask

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY app /app/

RUN cp /app/app /etc/nginx/sites-available && \
    ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled/ &&\
    rm /etc/nginx/sites-enabled/default
    
WORKDIR /app
CMD ["/usr/bin/supervisord"]
