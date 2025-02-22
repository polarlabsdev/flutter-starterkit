import 'package:flutter/material.dart';

enum ButtonSize { sm, md, lg }

class CustomButton extends StatefulWidget {
  final String text;
  final IconData? iconName;
  final double borderRadius;
  final ButtonSize size;
  final Color? backgroundColor;
  final VoidCallback onClick;
  final bool fullWidth;
  final bool noBackground;

  const CustomButton({
    Key? key,
    required this.text,
    this.iconName,
    this.borderRadius = 100.0,
    this.size = ButtonSize.md,
    this.backgroundColor,
    required this.onClick,
    this.fullWidth = false,
    this.noBackground = false,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  EdgeInsets _getPadding() {
    if (widget.noBackground) {
      return const EdgeInsets.all(0.0);
    }

    switch (widget.size) {
      case ButtonSize.sm:
        return const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
      case ButtonSize.md:
        return const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0);
      case ButtonSize.lg:
        return const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0);
    }
  }

  TextStyle _getTextStyle(TextTheme textTheme) {
    switch (widget.size) {
      case ButtonSize.sm:
        return textTheme.labelSmall!;
      case ButtonSize.md:
        return textTheme.labelMedium!;
      case ButtonSize.lg:
        return textTheme.labelLarge!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final double buttonOpacity = _isHovering ? 1.0 : 0.88;
    final double scale = _isPressed ? 0.95 : 1.0;

    final buttonWidgets = <Widget>[
      Text(
        widget.text,
        style: _getTextStyle(textTheme).copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
      ),
    ];

    if (widget.iconName != null) {
      buttonWidgets.insert(
        0,
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Icon(
            size: widget.size == ButtonSize.sm
                ? 16.0
                : widget.size == ButtonSize.md
                    ? 24.0
                    : 32.0,
            widget.iconName,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
      );
    }

    final Color buttonBackgroundColor = widget.noBackground
        ? Colors.transparent
        : (widget.backgroundColor ?? colorScheme.primary)
            .withOpacity(buttonOpacity);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onClick,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          transform: Matrix4.identity()..scale(scale, scale, 1.0),
          transformAlignment: Alignment.center,
          padding: _getPadding(),
          decoration: BoxDecoration(
            color: buttonBackgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Row(
            mainAxisSize:
                widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttonWidgets,
          ),
        ),
      ),
    );
  }
}
