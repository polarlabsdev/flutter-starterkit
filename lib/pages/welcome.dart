import 'package:dio/dio.dart';
import 'package:example_app/common/interfaces/api_client.dart';
import 'package:example_app/common/types/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:example_app/common/widgets/layout/static_page_template.dart';
import 'package:example_app/common/widgets/layout/margin_row.dart';
import 'package:example_app/common/widgets/layout/responsive_grid.dart';
import 'package:example_app/common/widgets/layout/app_bar.dart';
import 'package:fquery/fquery.dart';
import 'package:get_it/get_it.dart';
import 'package:remixicon/remixicon.dart';

Future<WeatherData> fetchWeather() async {
  final client = GetIt.instance<ApiClient>();

  final response = await client.get(
    'forecast',
    queryParameters: {
      'latitude': 43.65,
      'longitude': -79.38,
      'current': 'temperature_2m,wind_speed_10m',
      'hourly': 'temperature_2m,relative_humidity_2m,wind_speed_10m',
    },
  );

  final weatherData = WeatherData.fromJson(response.data);
  return weatherData;
}

class WelcomePage extends HookWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Since this library is generic for any Future we have to assume the
    // type for the error since it is typed simply as dynamic by default.
    // In this case as we know for sure we are using our API Client powered
    // by Dio, we can safely assume the error is a DioException.
    // We could probably find a way to return an ApiError type from the
    // API Client so the implementation is hidden, but I'm not smart enough
    // for that and not worth the effort right now.
    final weatherSnapshot =
        useQuery<WeatherData, DioException>(['weather'], () => fetchWeather());
    // final themeColors = Theme.of(context).colorScheme;
    final themeText = Theme.of(context).textTheme;

    return StaticPageTemplate(
      appBar: const CustomAppBar(),
      child: MarginConstrainedBox(
        child: ResponsiveRow(
          mainAxisAlignments: const {
            ScreenBreakpoint.xxs: WrapAlignment.center,
          },
          children: [
            ResponsiveColumn(
              cols: const {
                ScreenBreakpoint.xxs: 12,
                ScreenBreakpoint.md: 8,
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Flutter Starterkit',
                    style: themeText.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'A basis for starting new Flutter projects without having to lay all the groundwork. Simply fork, configure as needed, and start building!',
                    style: themeText.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'This page uses the GoRouter package to handle routing, and the fquery package to handle API calls. The API call is just to a public weather API here, but you can replace everything with your own implementation.',
                    style: themeText.bodyLarge?.copyWith(),
                  ),
                ],
              ),
            ),
            ResponsiveColumn(
              cols: const {
                ScreenBreakpoint.xxs: 12,
                ScreenBreakpoint.md: 4,
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: weatherSnapshot.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : weatherSnapshot.isError
                          ? Text(
                              'Error loading weather data: ${weatherSnapshot.error}',
                              style: themeText.bodyLarge,
                            )
                          : Column(
                              children: [
                                const Icon(Remix.sun_fill, size: 48),
                                const SizedBox(height: 16),
                                Text(
                                  'Current Weather in Toronto',
                                  style: themeText.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Remix.temp_hot_fill),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${weatherSnapshot.data!.temperature.toStringAsFixed(1)}°C',
                                      style: themeText.bodyLarge,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Remix.windy_fill),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${weatherSnapshot.data!.windSpeed.toStringAsFixed(1)} km/h',
                                      style: themeText.bodyLarge,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
