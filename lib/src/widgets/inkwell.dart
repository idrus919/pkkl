import 'package:flutter/material.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';

class InkWellWidget extends StatelessWidget {
  final BorderRadius? radius;
  final VoidCallback? onTap, onLongPress;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const InkWellWidget({
    Key? key,
    this.radius,
    this.onTap,
    this.onLongPress,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? borderRadius(0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(padding: padding ?? inset(0), child: child),
        ),
      ),
    );
  }
}
