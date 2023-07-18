import 'package:flutter/material.dart';

class VisibilityWidget extends StatelessWidget {
  final bool visible;
  final Widget? child;
  final Widget? replacement;

  const VisibilityWidget({
    Key? key,
    this.visible = false,
    required this.child,
    this.replacement = const SizedBox(),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: visible ? child : replacement,
      layoutBuilder: (current, previous) => current ?? const SizedBox(),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
