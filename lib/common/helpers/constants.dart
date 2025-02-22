import 'package:flutter_dotenv/flutter_dotenv.dart';

// Application constants
final String environment = dotenv.env['ENV_NAME'] ?? 'local';
final String websiteUrl = dotenv.env['WEBSITE_URL'] ??
    'https://github.com/polarlabsdev/flutter-starterkit';
final String apiUrl =
    dotenv.env['BASE_API_URL'] ?? 'https://api.open-meteo.com/v1/';
final bool logHttpRequests = dotenv.env['LOG_HTTP_REQUESTS'] == 'true';

// Third party tooling constants
final String sentryEnvironment =
    environment.startsWith('preview') ? 'preview' : environment;
final String sentryDsn = dotenv.env['SENTRY_DSN'] ?? '';
final String sentryRelease = dotenv.env['SENTRY_RELEASE_NAME'] ?? '';

final bool umamiEnabled = dotenv.env['UMAMI_ENABLED'] == 'false';
final bool logUmamiEvents = dotenv.env['LOG_UMAMI_EVENTS'] == 'true';
final String umamiEndpoint =
    '${dotenv.env['UMAMI_URL'] ?? 'https://umami.is/'}/api/send';
final String umamiWebsiteId = dotenv.env['UMAMI_WEB_ID'] ?? '';

// Layout constants
const double defaultMarginWidth = 1200.0;
const double defaultMarginWidthMobilePercent = 0.98;
const int breakpointXs = 420;
const int breakpointSm = 768;
const int breakpointMd = 1150;
const int breakpointLg = 1600;
const int breakpointXl = 1920;
const int breakpointXxl = 2500;
const int breakpoint4k = 3800;
const double defaultHorizontalGutter = 16.0;
const double defaultVerticalGutter = 16.0;
const int defaultLayoutColumns = 12;
