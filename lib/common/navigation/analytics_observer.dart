import 'package:flutter/material.dart';

// NOTE: There is an issue with the GoRouter NavigatorObserver where
// changing the path parameters (e.g. slug) doesn't trigger the observer. This
// means that we miss if someone navigates to a different puzzle while on the
// puzzle page currently. I commented in this issue which I believe is related
// and hopefully there will be a fix soon: https://github.com/flutter/flutter/issues/112196
// Until then, we can't use this to track views even though it should be the
// better way on paper. There is instead a workaround in the main.dart file.

typedef RouteChangeCallback = void Function(Route? newRoute, Route? oldRoute);

// A NavigatorObserver that can optionally invoke callbacks for push, pop, remove, and replace.
// Each method also prints the route's name for debugging.
class AnalyticsObserver extends NavigatorObserver {
  // Called when a route has been pushed onto the navigator.
  final RouteChangeCallback? onPush;

  // Called when a route has been popped from the navigator.
  final RouteChangeCallback? onPop;

  // Called when a route has been removed from the navigator.
  final RouteChangeCallback? onRemove;

  // Called when a route has been replaced in the navigator.
  final RouteChangeCallback? onReplace;

  // Whether to enable logging.
  final bool enableLogging;

  AnalyticsObserver({
    this.onPush,
    this.onPop,
    this.onRemove,
    this.onReplace,
    this.enableLogging = false,
  });

  void _log(String message) {
    if (enableLogging) {
      debugPrint(message);
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _log('didPush: $route');
    onPush?.call(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _log('didPop: $route');
    onPop?.call(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _log('didRemove: $route');
    onRemove?.call(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _log('didReplace: $newRoute');
    onReplace?.call(newRoute, oldRoute);
  }
}
