FROM python:3.4

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi
RUN pip install --upgrade pip && pip install Flask==0.10.1 uWSGI==2.0.19 requests==2.5.1 redis==2.10.3
WORKDIR /app
EXPOSE 9090 9191 
COPY app /app
COPY cmd.sh /
USER uwsgi

CMD ["/cmd.sh"] 