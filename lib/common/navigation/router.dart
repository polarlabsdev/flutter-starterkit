import 'package:example_app/pages/welcome.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// GoRouter configuration
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  observers: [
    SentryNavigatorObserver(),
  ],
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) {
        return const WelcomePage();
      },
    ),
  ],
);
