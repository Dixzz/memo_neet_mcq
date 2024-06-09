import 'package:flutter/material.dart';

class OutlinedRoundedCard extends RoundedCard {
  final Color? borderColor;
  @override
  final Color? color;

  final double? width;
  @override
  final double margin;
  @override
  final double radius;

  OutlinedRoundedCard({
    super.key,
    this.borderColor,
    this.color,
    this.width,
    this.margin = 0,
    this.radius = 8,
    required super.child,
  }) : super(
            margin: margin,
            radius: radius,
            borderSide: BorderSide(
                color: borderColor ?? Colors.grey.shade300, width: width ?? 1));
}

class RoundedCard extends StatelessWidget {
  final double radius;
  final double elevation;
  final double margin;
  final Color? color;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final Widget child;

  const RoundedCard(
      {this.radius = 8.0,
      this.elevation = 2,
      this.margin = 0,
      this.color,
      required this.child,
      super.key,
      this.borderSide,
      this.borderRadius});

  @override
  Widget build(BuildContext context) => Card(
        elevation: elevation,
        margin: EdgeInsets.all(margin),
        color: color,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            side: borderSide ?? BorderSide.none,
            borderRadius:
                borderRadius ?? BorderRadius.all(Radius.circular(radius))),
        child: child,
      );
}
