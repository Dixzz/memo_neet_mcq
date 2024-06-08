import 'package:flutter/widgets.dart';

class SpaceVertical extends SizedBox {
  final double h;
  const SpaceVertical(this.h, {super.key}): super(height: h);
}

class SpaceHorizontal extends SizedBox {
  final double w;
  const SpaceHorizontal(this.w, {super.key}): super(width: w);
}