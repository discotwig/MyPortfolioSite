FROM httpd:alpine

# Copy static files
COPY . /usr/local/apache2/htdocs/

# Declare the internal port
EXPOSE 80
