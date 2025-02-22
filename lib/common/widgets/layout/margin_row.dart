import 'package:flutter/material.dart';
import 'package:example_app/common/helpers/constants.dart';

/*
 * A widget that ensures a consistent margin for top-level widgets.
 *
 * This widget pulls the margin value from a constant, allowing the margin
 * to be changed across the app in one place. However, the margin can be
 * overridden by passing a `marginWidth` prop.
 *
 * When the screen width is smaller than the specified margin, the widget
 * adjusts the margin to be 98% of the screen width to ensure proper
 * responsiveness.
 *
 * This helps maintain a uniform layout and spacing throughout the app,
 * making it easier to manage and update the margin values globally.
 */

class MarginConstrainedBox extends StatelessWidget {
  final double marginWidth;
  final Widget child;

  const MarginConstrainedBox({
    Key? key,
    this.marginWidth = defaultMarginWidth,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.sizeOf(context);

    final finalMarginWidth = marginWidth >= windowSize.width
        ? (windowSize.width * defaultMarginWidthMobilePercent).roundToDouble()
        : marginWidth;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: finalMarginWidth,
          minWidth: finalMarginWidth,
        ),
        child: child,
      ),
    );
  }
}
