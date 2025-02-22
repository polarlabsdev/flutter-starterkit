import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.padding,
    this.margin,
    this.iconSize,
  });

  final IconData icon;
  final Function() onPressed;
  final double? padding;
  final EdgeInsetsGeometry? margin;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;

    return Container(
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          shadowColor: themeColors.shadow,
          shape: const CircleBorder(),
          padding: EdgeInsets.all(padding ?? 12),
          backgroundColor: themeColors.primaryContainer, // <-- Button color
          foregroundColor: themeColors.inversePrimary, // <-- Splash color
        ),
        onPressed: onPressed,
        child: Icon(
          color: themeColors.onPrimaryContainer,
          size: iconSize ?? 34,
          icon,
        ),
      ),
    );
  }
}
