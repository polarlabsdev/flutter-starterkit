import 'package:example_app/common/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:fquery/fquery.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:example_app/common/helpers/umami_analytics.dart';
import 'package:example_app/common/themes/page_transitions.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:example_app/common/helpers/constants.dart';
import 'package:example_app/common/interfaces/api_client.dart';
import 'package:example_app/common/navigation/router.dart';
import 'package:example_app/common/themes/dark.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // using the traditional name .env causes errors in the web platform
  // because it ignores hidden files when generating assets
  await dotenv.load(fileName: 'dotenv');
  _getItSetup();

  // this gets rid of the # in the URL on web
  setPathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  await SentryFlutter.init(
    (options) {
      options.dsn = sentryDsn;
      options.environment = sentryEnvironment;
      if (sentryRelease.isNotEmpty) {
        options.release = sentryRelease;
      }
    },
  );

  runApp(const MyApp());
}

ThemeData _applyPageTransitions(ThemeData theme) {
  return theme.copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadePageTransition(),
        TargetPlatform.iOS: FadePageTransition(),
      },
    ),
  );
}

// This is the main widget of the whole app. We are using GoRouter which appears
// to add an extra .router class(?) where we include a router. We also include
// a builder which is a method we can override on widgets that allows us to
// return widgets that wrap the originally intended child from instantiation.
// In our builder we include a wrapper that puts the navigation UI on top of
// every page returned by the router.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This is a workaround for an issue with the GoRouter NavigatorObserver where
  // changing the path parameters (e.g. slug) doesn't trigger the observer. This
  // means that we miss if someone navigates to a different puzzle while on the
  // puzzle page currently. I commented in this issue which I believe is related
  // and hopefully there will be a fix soon: https://github.com/flutter/flutter/issues/112196
  void _handleRouteChange() {
    final RouteMatchList config = appRouter.routerDelegate.currentConfiguration;
    trackPageViewByURL(config.uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    appRouter.routerDelegate.addListener(_handleRouteChange);

    return QueryClientProvider(
      queryClient: QueryClient(),
      child: MaterialApp.router(
        title: 'Flutter Starterkit',
        // There are two ways to set page transitions: either here in the theme or
        // in the router for each route with the CustomPageTransition widget.
        // Setting transitions in the route requires repeating ourselves on each route
        // and using a NavigationObserver doesn't get any of the route data.
        // This issue is discussed in detail here: https://github.com/flutter/flutter/issues/112185
        // Setting transitions here in the theme allows us to use the regular builder
        // method on GoRoutes, but we can't set a transition for web because
        // Flutter doesn't provide that option. As a result, we get no transition at all on web.
        // We prefer the second option so we can get the data in the observer,
        // and no transition is standard for websites anyways.
        themeMode: ThemeMode.system,
        theme: _applyPageTransitions(lightTheme),
        darkTheme: _applyPageTransitions(darkTheme),
        routerConfig: appRouter,
      ),
    );
  }
}

void _getItSetup() {
  final getIt = GetIt.instance;

  if (!getIt.isRegistered<ApiClient>()) {
    getIt.registerSingleton<ApiClient>(ApiClient());
  }
}
