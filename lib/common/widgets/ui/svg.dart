import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImg extends StatelessWidget {
  final String imagePath;
  final EdgeInsetsGeometry padding;
  final String semanticsLabel;

  const SvgImg({
    super.key,
    required this.imagePath,
    this.padding = const EdgeInsets.all(0),
    required this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SvgPicture.network(
        imagePath,
        semanticsLabel: semanticsLabel,
      ),
    );
  }
}
