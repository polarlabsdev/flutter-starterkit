import 'package:flutter/material.dart';
import 'package:example_app/common/widgets/layout/app_bar.dart';

/// A stateless widget that provides a consistent template for static pages.
///
/// This widget includes a top bar with the Piñones logo and a title, and
/// ensures that the content is displayed within a [SafeArea]. The top bar
/// has a fixed height and includes a logo image and the title "Piñones"
/// in uppercase. The main content of the page is provided by the [child]
/// widget passed to this template.
class StaticPageTemplate extends StatelessWidget {
  final Widget child;
  final CustomAppBar appBar;

  const StaticPageTemplate({
    super.key,
    required this.child,
    required this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
