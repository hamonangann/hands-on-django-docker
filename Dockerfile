# base image  
FROM python:3.8-slim-bookworm

# buat user dan working directory
ENV APP_HOME=/home/app/web
RUN mkdir -p $APP_HOME
RUN addgroup --system app && adduser --system --group app
WORKDIR $APP_HOME

# upgrade package
RUN apt-get update && apt-get install -y --no-install-recommends netcat-traditional
RUN pip install --upgrade pip  

# copy dari work directory lokal ke work directory docker
COPY . $APP_HOME

# install dependensi proyek
RUN pip install -r requirements.txt 

# berikan akses ke non-root user
RUN chown -R app:app $APP_HOME
USER app

# ekspos port yang digunakan django 
EXPOSE 8000

# jalankan entrypoint.sh
RUN sed -i 's/\r$//g'  $APP_HOME/entrypoint.sh
RUN chmod +x  $APP_HOME/entrypoint.sh
ENTRYPOINT ["/home/app/web/entrypoint.sh"]

# start server  
CMD ["gunicorn", "--workers=2", "demo.wsgi", "--bind", "0.0.0.0:8000"]