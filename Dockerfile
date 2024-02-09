# base image  
FROM python:3.8

# working at default directory 
WORKDIR .

# install dependencies  
RUN pip install --upgrade pip  

# copy whole project to your docker home directory. 
COPY . .

# run this command to install all dependencies  
RUN pip install -r requirements.txt 

# port where the Django app runs  
EXPOSE 8000

# start server  
CMD ["gunicorn", "--workers=2", "demo.wsgi", "--bind", "0.0.0.0:8000"]