 FROM  nginx:alpine  
 
 COPY index.html /usr/share/nginx/html
 

# Start from the Nginx Alpine image
# FROM nginx:alpine3.18
# ADD ./html/index.html /usr/share/nginx/html/index.html

# FROM ubuntu

# RUN apt-get update
# RUN apt-get install nginx -y

# ADD nginx.conf /etc/nginx/nginx.conf
# ADD ./html/index.html /www/html/index.html

# EXPOSE 80
# CMD ["nginx"]

