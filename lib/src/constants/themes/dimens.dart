import 'package:flutter/material.dart';

double get defaultSize => 16;

EdgeInsets inset([double? size]) {
  return EdgeInsets.all(size ?? defaultSize);
}

EdgeInsets insetHorizontal([double? size]) {
  return EdgeInsets.symmetric(horizontal: size ?? defaultSize);
}

EdgeInsets insetSymmetric(double horizontal, double vertical) {
  return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
}

EdgeInsets insetVertical([double? size]) {
  return EdgeInsets.symmetric(vertical: size ?? defaultSize);
}

EdgeInsets insetLTRB(double? left, double? top, double? right, double? bottom) {
  return EdgeInsets.fromLTRB(left ?? 0, top ?? 0, right ?? 0, bottom ?? 0);
}

SizedBox height([double? size]) {
  return SizedBox(height: size ?? defaultSize);
}

SizedBox width([double? size]) {
  return SizedBox(width: size ?? defaultSize);
}

BorderRadius borderRadius([double? radius]) {
  return BorderRadius.circular(radius ?? defaultSize);
}

Radius radius([double? radius]) {
  return Radius.circular(radius ?? defaultSize);
}
