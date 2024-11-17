# Using nginx web server to serve the built out dart webapp files
# There is currently an issue building the webapp in the dockerfile, 
# so the webapp is built in the pipeline and then copied into the docker container
# https://github.com/flutter/flutter/issues/158088
FROM nginx:alpine

# Copy the build artifacts from the build step
COPY build/web /usr/share/nginx/html

# Copy the nginx configuration file into a usable directory for Nginx
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8000

# Run nginx in the foreground instead as a background process. This MAY make it easier to check whats going on with the nginx process.
# But also because when nginx is running in a docker container in the foreground, it seems to exit with a 0 code. 
CMD ["nginx", "-g", "daemon off;"]
