import 'package:flutter/material.dart';
import 'package:example_app/common/helpers/constants.dart' as constants;

/*
 * This file contains a set of widgets designed to facilitate the creation of fully responsive layouts using a grid system.
 * The three main widgets provided are MarginConstrainedBox, ResponsiveRow, and ResponsiveColumn. These widgets work together
 * to create a flexible and adaptive layout that adjusts to different screen sizes and orientations.
 *
 * 1. MarginConstrainedBox (defined in lib/common/widgets/layout/margin_row.dart):
 *    - This widget is used to center content on the page with a maximum width constraint.
 *    - It uses a constant value to determine the maximum width of the content.
 *    - If the screen width is below the maximum width, the content will track the screen size, ensuring it remains centered.
 *    - This is particularly useful for maintaining a consistent layout on larger screens while still being responsive on smaller screens.
 *
 * 2. ResponsiveRow:
 *    - This widget acts as a container for columns, similar to a row in a flexbox layout.
 *    - It allows setting properties at the group level, such as alignment and reverse order.
 *    - The alignment property can be used to control the positioning of the columns within the row.
 *    - The reverse property can be used to reverse the order of the columns, which can be useful for creating responsive designs that adapt to different screen sizes.
 *
 * 3. ResponsiveColumn:
 *    - This widget acts as a container for other widgets, similar to a column in a grid layout.
 *    - It allows setting the number of "columns" it occupies out of a total of 12 columns by default (this can be adjusted in the constants).
 *    - The number of columns can be specified for each screen size, allowing for fine-grained control over the layout at different breakpoints.
 *    - Additionally, alignment properties can be set for each screen size, providing further customization options.
 *
 * Together, these widgets enable the creation of complex, responsive layouts that adapt to different screen sizes and orientations.
 * By using MarginConstrainedBox to center content, ResponsiveRow to group columns, and ResponsiveColumn to define the layout of individual widgets,
 * developers can create flexible and adaptive designs that provide a consistent user experience across a wide range of devices.
 */

enum ScreenBreakpoint {
  xxs,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
  xl4k,
}

ScreenBreakpoint getScreenBreakpoint(double width) {
  if (width >= constants.breakpoint4k) {
    return ScreenBreakpoint.xl4k;
  } else if (width >= constants.breakpointXxl) {
    return ScreenBreakpoint.xxl;
  } else if (width >= constants.breakpointXl) {
    return ScreenBreakpoint.xl;
  } else if (width >= constants.breakpointLg) {
    return ScreenBreakpoint.lg;
  } else if (width >= constants.breakpointMd) {
    return ScreenBreakpoint.md;
  } else if (width >= constants.breakpointSm) {
    return ScreenBreakpoint.sm;
  } else if (width >= constants.breakpointXs) {
    return ScreenBreakpoint.xs;
  } else {
    return ScreenBreakpoint.xxs;
  }
}

T getValueForScreenWidth<T>(
    double screenWidth, Map<ScreenBreakpoint, T> values, T defaultValue) {
  final breakpoints = {
    constants.breakpoint4k: ScreenBreakpoint.xl4k,
    constants.breakpointXxl: ScreenBreakpoint.xxl,
    constants.breakpointXl: ScreenBreakpoint.xl,
    constants.breakpointLg: ScreenBreakpoint.lg,
    constants.breakpointMd: ScreenBreakpoint.md,
    constants.breakpointSm: ScreenBreakpoint.sm,
    constants.breakpointXs: ScreenBreakpoint.xs,
  };

  for (var breakpoint in breakpoints.entries) {
    if (screenWidth >= breakpoint.key && values.containsKey(breakpoint.value)) {
      return values[breakpoint.value] as T;
    }
  }

  return values[ScreenBreakpoint.xxs] ?? defaultValue;
}

class ResponsiveColumn extends StatelessWidget {
  final Widget child;
  final Map<ScreenBreakpoint, int> cols;
  final Map<ScreenBreakpoint, Alignment>? alignments;
  final Map<ScreenBreakpoint, bool>? visibility;
  final double horizontalGutter;
  final double verticalGutter;
  final bool debug;

  const ResponsiveColumn({
    super.key,
    required this.child,
    required this.cols,
    this.alignments,
    this.visibility,
    this.horizontalGutter = constants.defaultHorizontalGutter,
    this.verticalGutter = constants.defaultVerticalGutter,
    this.debug = false,
  });

  int _getColumnsForWidth(double width) {
    return getValueForScreenWidth<int>(
        width, cols, constants.defaultLayoutColumns);
  }

  Alignment _getAlignmentForWidth(double width) {
    return getValueForScreenWidth<Alignment>(
        width, alignments ?? {}, Alignment.topLeft);
  }

  bool _getVisibilityForWidth(double width) {
    return getValueForScreenWidth<bool>(width, visibility ?? {}, true);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    int columns = _getColumnsForWidth(screenWidth);
    Alignment alignment = _getAlignmentForWidth(screenWidth);

    return Visibility(
      visible: _getVisibilityForWidth(screenWidth),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double parentWidth = constraints.maxWidth;
          double columnWidth =
              ((parentWidth / constants.defaultLayoutColumns) * columns) -
                  horizontalGutter;

          if (debug) {
            // ignore: avoid_print
            print('\nscreenWidth: $screenWidth');
            // ignore: avoid_print
            print('parentWidth: $parentWidth');
            // ignore: avoid_print
            print(
                'baseColWidth: ${parentWidth / constants.defaultLayoutColumns}');
            // ignore: avoid_print
            print(
                'calcColWidth: ${parentWidth / constants.defaultLayoutColumns * columns}');
            // ignore: avoid_print
            print('colWidth: $columnWidth');
            // ignore: avoid_print
            print('column width in cols: $columns');
            // ignore: avoid_print
            print('columns total: ${constants.defaultLayoutColumns / columns}');
            // ignore: avoid_print
            print(
                'colWidth times col count: ${(columnWidth + horizontalGutter) * (constants.defaultLayoutColumns / columns)}');
          }

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalGutter / 2,
              vertical: verticalGutter / 2,
            ),
            child: SizedBox(
              width: columnWidth,
              child: Align(
                alignment: alignment,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ResponsiveRow extends StatelessWidget {
  final List<ResponsiveColumn> children;
  final Map<ScreenBreakpoint, WrapAlignment>? mainAxisAlignments;
  final Map<ScreenBreakpoint, WrapAlignment>? runAlignments;
  final Map<ScreenBreakpoint, WrapCrossAlignment>? crossAxisAlignments;
  final Map<ScreenBreakpoint, bool>? visibility;
  final bool reverse;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignments,
    this.runAlignments,
    this.crossAxisAlignments,
    this.visibility,
    this.reverse = false,
  });

  WrapAlignment _getMainAxisAlignmentForWidth(double width) {
    return getValueForScreenWidth<WrapAlignment>(
        width, mainAxisAlignments ?? {}, WrapAlignment.start);
  }

  WrapAlignment _getRunAlignmentForWidth(double width) {
    return getValueForScreenWidth<WrapAlignment>(
        width, runAlignments ?? {}, WrapAlignment.start);
  }

  WrapCrossAlignment _getCrossAxisAlignmentForWidth(double width) {
    return getValueForScreenWidth<WrapCrossAlignment>(
        width, crossAxisAlignments ?? {}, WrapCrossAlignment.start);
  }

  bool _getVisibilityForWidth(double width) {
    return getValueForScreenWidth<bool>(width, visibility ?? {}, true);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Visibility(
      visible: _getVisibilityForWidth(screenWidth),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: _getMainAxisAlignmentForWidth(screenWidth),
        runAlignment: _getRunAlignmentForWidth(screenWidth),
        crossAxisAlignment: _getCrossAxisAlignmentForWidth(screenWidth),
        textDirection: reverse ? TextDirection.rtl : TextDirection.ltr,
        children: children,
      ),
    );
  }
}
