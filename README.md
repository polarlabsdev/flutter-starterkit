# Flutter Starterkit

A basis for starting new Flutter projects without having to lay all the groundwork. Simply fork, configure as needed, and start building!

## Current Status

- Web platform support only (iOS and Android support planned for future releases)
- Early development phase
- Production and preview environments available through Bitbucket Pipelines

## Development Setup

### Prerequisites

- Flutter SDK (v3.29.0)
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
   You can also run the app from vscode in the "Run and Debug" panel, which we would recommend.

## Building for Production

Currently, the project only supports web builds. To create a production build locally:

```bash
flutter build web
```

## Building Pages with Built-in Tools

This starterkit provides a comprehensive set of tools and patterns to help you quickly build and manage pages in your Flutter application.

### Page Structure

Each page in the application is typically a `StaticPageTemplate` or `HookWidget`. For example, the `WelcomePage` (lib/pages/welcome.dart) is a `HookWidget` from fquery that allows use to use React style `useQuery` to get results from an API before returning our `StaticPageTemplate`. The goal is to mix and match reusable structural widgets to compose apps quickly.

### Layout Widgets

We use custom layout widgets like `StaticPageTemplate`, `MarginConstrainedBox`, `ResponsiveRow`, and `ResponsiveColumn` to create responsive and consistent layouts. The `ResponsiveGrid` utility mimics the functionality of CSS grid systems, allowing for easy responsive design in widgets. These widgets help manage spacing, alignment, and responsiveness across different screen sizes. You can set your breakpoints in `lib/common/helpers/constants.dart` or use our defaults.

### API Integration and State Management

For API calls, we use the `ApiClient` class, registered as a singleton using `GetIt`. This allows you to easily fetch data from APIs and handle responses. We try to use `GetIt` for reusable code utilities like the `ApiClient` singleton, and the `Provider` class for shared state based on data used for business logic.

### Routing

Routing is managed using the `GoRouter` package. Routes are defined in `router.dart`, and each route is associated with a specific page. For example, the `WelcomePage` is mapped to the root path (`/`).

### Theming

The application supports both light and dark themes, defined in `light.dart` and `dark.dart`. The theme is applied globally in `main.dart` and can be customized as needed.

### Example: Creating a New Page

Here is an example of creating a new page using the provided tools:

```dart
import 'package:flutter/material.dart';
import 'package:example_app/common/widgets/layout/static_page_template.dart';
import 'package:example_app/common/widgets/layout/margin_row.dart';
import 'package:example_app/common/widgets/layout/responsive_grid.dart';

class NewPage extends StatelessWidget {
   const NewPage({super.key});

   @override
   Widget build(BuildContext context) {
      final themeText = Theme.of(context).textTheme;

      return StaticPageTemplate(
         appBar: const CustomAppBar(),
         child: MarginConstrainedBox(
            child: ResponsiveRow(
               children: [
                  ResponsiveColumn(
                     cols: const {
                        ScreenBreakpoint.xxs: 12,
                        ScreenBreakpoint.sm: 8,
                        ScreenBreakpoint.md: 6,
                        ScreenBreakpoint.lg: 4,
                     },
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('New Page', style: themeText.headlineMedium),
                           const SizedBox(height: 16),
                           Text('This is a new page.', style: themeText.bodyLarge),
                        ],
                     ),
                  ),
               ],
            ),
         ),
      );
   }
}
```

For a more fleshed-out example, refer to the `WelcomePage`.

By leveraging these tools, you can efficiently build and manage pages in your Flutter application.

## Deployment

### Infrastructure

- Deployments are managed through Bitbucket Pipelines
- Uses Helm for Kubernetes deployments
- NGINX serves the web application
- Deployment configurations are located in `flutter-web-charts/`
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

In order to save time in builds and have full control over the flutter SDK being used, we maintain a docker container called `flutter-runner` which can be found here: https://github.com/polarlabsdev/flutter-runner

Before building this project in CI/CD it is necessary to deploy one of these images with the matching SDK version using the pipelines pre-installed in that repo. You can then edit the `image` prop in `bitbucket-pipelines.yml`.

You can also use existing flutter docker images such as https://hub.docker.com/r/instrumentisto/flutter

## Configuration Files

- `nginx.conf`: Contains NGINX server configuration
- `flutter-web-charts/`: Contains Helm deployment charts and configurations

### nginx config breakdown

The `nginx.conf` file is crucial for deploying the web application. Here's a breakdown of its contents:

- **Events Block**: 
   - This block is currently commented out but can be used to configure worker processes and file limits.

- **HTTP Block**:
   - **MIME Types**: Includes MIME types definitions from `/etc/nginx/mime.types`.
   - **Default Type**: Sets the default MIME type to `application/octet-stream`.
   - **Gzip Compression**: Enables gzip compression for specific content types to improve performance.

- **Server Block**:
   - **Listening Port**: Configures the server to listen on port `8000`.
   - **Cache Control Headers**: Adds headers to control caching behavior for all response codes. This is a temporary setup to handle static file caching in Flutter web.
   - **Location Block**:
      - **Root Directory**: Sets the root directory to `/usr/share/nginx/html`.
      - **Index File**: Specifies `index.html` as the index file.
      - **Try Files**: Configures NGINX to try the requested URI, then the URI with a trailing slash, and finally `/index.html` if the previous attempts fail. This is done in conjunction with the url_strategy lib that gets rid of the # in the url.

This configuration ensures that the web application is served correctly, with appropriate caching and compression settings to optimize performance. Make sure to adjust the paths and settings as needed for your specific deployment environment.

## Known Issues

- Web builds must be performed in pipeline due to [Flutter issue #158088](https://github.com/flutter/flutter/issues/158088)
