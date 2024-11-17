# Flutter Starterkit

A basis for starting new Flutter projects without having to lay all the groundwork. Simply fork, configure as needed, and start building!

## Current Status

- Web platform support only (iOS and Android support planned for future releases)
- Early development phase
- Production and preview environments available through Bitbucket Pipelines

## Development Setup

### Prerequisites

- Flutter SDK (v3.24.4)
- Git
- A code editor (VS Code recommended with Flutter extension)

### Getting Started

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd pinones
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the project locally:
   ```bash
   flutter run -d chrome
   ```

## Building for Production

Currently, the project only supports web builds. To create a production build locally:

```bash
flutter build web
```

## Deployment

### Infrastructure

- Deployments are managed through Bitbucket Pipelines
- Uses Helm for Kubernetes deployments
- NGINX serves the web application
- Deployment configurations are located in `pinones-charts/`
- Note: Due to [this issue](https://github.com/flutter/flutter/issues/158088), builds for deployment are performed within the pipeline rather than in Dockerfile.

### Pipeline Structure

The project uses three main pipeline configurations:

1. **Pull Request (PR) Pipeline**
   - Triggers on PR creation
   - Runs tests
   - Includes manual trigger for preview environment deployment

2. **Production Pipeline**
   - Triggers on PR merge
   - Runs tests
   - Deploys to production (manual confirmation required)

3. **Cleanup Pipeline**
   - Manual trigger only
   - Removes preview environments given a matching PR number

### Deployment Process

1. Web build is created within the pipeline
2. Build artifacts are saved
3. Artifacts are injected into an NGINX-based Dockerfile
4. NGINX configuration is injected from local `nginx.conf`
5. Deployment proceeds using Polar Labs standard Helm chart

### Using Our flutter-runner Docker Container

In order to save time in builds and have full control over the flutter SDK being used, we maintain a docker container called `flutter-runner` which can be found here: https://bitbucket.org/polarlabsca/flutter-runner/src/main/

Before building this project in CI/CD it is necessary to deploy one of these images with the matching SDK version using the pipelines pre-installed in that repo. You can then edit the `image` prop in `bitbucket-pipelines.yml`.

## Configuration Files

- `nginx.conf`: Contains NGINX server configuration
- `pinones-charts/`: Contains Helm deployment charts and configurations

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

## Known Issues

- Web builds must be performed in pipeline due to [Flutter issue #158088](https://github.com/flutter/flutter/issues/158088)
