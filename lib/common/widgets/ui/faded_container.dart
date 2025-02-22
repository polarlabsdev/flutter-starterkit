import 'package:flutter/material.dart';

class FadedContainer extends StatelessWidget {
  final double opacity;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final Widget child;
  final bool fullWidth;

  const FadedContainer({
    Key? key,
    this.opacity = 0.08,
    this.borderRadius = const BorderRadius.all(Radius.circular(100)),
    this.padding = const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    required this.child,
    this.fullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity),
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
