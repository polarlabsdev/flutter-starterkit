#######################
##  Build Container  ##
#######################
FROM fischerscode/flutter AS build

# Set the working directory
WORKDIR /$app_directory

RUN chown flutter:flutter /$app_directory

USER flutter

# Copy the code into the container
COPY --chown=flutter:flutter . /$app_directory

# Fetch the dependencies
RUN flutter pub get

# Build the release version of the app
RUN flutter build web



########################
##  Deploy Container  ##
########################
# Using nginx web server to serve the built out dart webapp files
FROM nginx:alpine

# Copy the build artifacts from the build step
COPY --from=build /$app_directory/build/web /usr/share/nginx/html

# Copy the nginx configuration file into a usable directory for Nginx
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8000

# Run nginx in the foreground instead as a background process. This MAY make it easier to check whats going on with the nginx process.
# But also because when nginx is running in a docker container in the foreground, it seems to exit with a 0 code. 
CMD ["nginx", "-g", "daemon off;"]





