# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

* Quick summary
* Version
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* Summary of set up
* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions


### nginx config breakdown

#### TLDR;
In summary, this configuration sets up a basic web server that listens on port 80, serves content from the /usr/share/nginx/html directory, and uses index.html as the default file for directories. It also includes a fallback mechanism to handle requests for non-existent files.


`location / {`

This location block defines how Nginx handles requests for specific URLs. The / here refers to the root path of your website (e.g., accessing http://yourdomain.com/).


`root /usr/share/nginx/html;`

This specifies the directory on your server where Nginx will look for static files to serve. In this case, it's set to /usr/share/nginx/html, which is a common default location for Nginx installations.

`index index.html;`

This tells Nginx that if a directory is requested (without a specific filename), it should look for a file named index.html within that directory and serve it if found. This is typically used to serve the main page of your website.

`try_files $uri $uri/ =404;`

This directive defines a fallback mechanism for handling requests.

$uri is a variable that represents the requested URL path. The first part (try_files $uri) tells Nginx to try to serve the exact file requested by the URL. The second part ($uri/) attempts to append a trailing slash to the requested URL and try again. This can be useful for handling requests for directories that might have an index.html file. The =404 at the end specifies that if none of the previous attempts locate a valid file, Nginx should return a 404 Not Found error.


### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines