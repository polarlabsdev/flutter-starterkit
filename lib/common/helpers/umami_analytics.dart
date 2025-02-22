import 'dart:ui';
import 'package:example_app/common/helpers/constants.dart';
import 'package:web/web.dart' as html;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:package_info_plus/package_info_plus.dart';

String _generateUrlPath(Route route) {
  final String basePath = route.settings.name ?? '/';
  final arguments = route.settings.arguments;

  if (arguments is Map<String, dynamic> && arguments.containsKey('slug')) {
    return '$basePath/${arguments['slug']}';
  }

  return basePath;
}

String _getReferrer() {
  if (kIsWeb) {
    // something about the way flutter handles dialogs and such uses
    // the navigation, and that causes the referrer to be the app itself
    // so we only want to track the referrer if it's not the same as itself.
    final referrer = html.document.referrer;
    final referrerHost = Uri.parse(referrer).host;
    final currentHost = Uri.parse(html.window.location.href).host;

    if (referrerHost != currentHost) {
      return referrer;
    }
  }
  // in the future we can try to get the referrer from the platform
  // if someone goes to the app from a deeplink
  return '';
}

// Private function to generate the base payload
Future<Map<String, dynamic>> _getBasePayload(String url) async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Size screenSize = PlatformDispatcher.instance.displays.first.size;

  return {
    'hostname': 'com.polarlabs.pinones',
    'language': PlatformDispatcher.instance.locale.languageCode,
    'referrer': _getReferrer(),
    'screen': '${screenSize.width}x${screenSize.height}',
    'url': url,
    'website': umamiWebsiteId,
    'tag': packageInfo.version,
  };
}

Future<void> _sendEvent(Map<String, dynamic> payload) async {
  if (logUmamiEvents) {
    debugPrint('Sending event: $payload');
  }

  // It appears dio or the browser is setting user-agent automatically
  // but we might need to handle this ourselves in app builds if we
  // continue to use Umami there.
  // Everything in Umami is an event, but if it has no name
  // it will be considered a page view
  if (umamiEnabled) {
    await Dio().post(
      umamiEndpoint,
      data: {
        'type': 'event',
        'payload': payload,
      },
    );
  }
}

Future<void> trackPageView(Route route) async {
  try {
    // If the route is not named, then we assumed it's a flutter lifecycle thing
    // like opening a dialog or a snackbar, so we don't track it.
    if (route.settings.name != null) {
      final payload = await _getBasePayload(_generateUrlPath(route));
      await _sendEvent(payload);
    }
  } catch (e) {
    debugPrint('Failed to track page view: $e');
  }
}

// This is an alternative to trackPageView that allows us to track the
// page view by URL instead of by route.
Future<void> trackPageViewByURL(String url) async {
  try {
    final payload = await _getBasePayload(url);
    await _sendEvent(payload);
  } catch (e) {
    debugPrint('Failed to track page view: $e');
  }
}

Future<void> trackEvent(
  String eventName,
  Route route,
  Map<String, dynamic>? eventData,
) async {
  try {
    final payload = await _getBasePayload(_generateUrlPath(route));
    payload['name'] = eventName;

    if (eventData != null) {
      payload['data'] = eventData;
    }

    await _sendEvent(payload);
  } catch (e) {
    debugPrint('Failed to track event: $e');
  }
}
