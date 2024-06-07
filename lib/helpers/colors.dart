import 'dart:math';

import 'package:flutter/material.dart';

int _tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color _tintColor(Color color, double factor) => Color.fromRGBO(
    _tintValue(color.red, factor),
    _tintValue(color.green, factor),
    _tintValue(color.blue, factor),
    1);

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: _tintColor(color, 0.5),
    100: _tintColor(color, 0.4),
    200: _tintColor(color, 0.3),
    300: _tintColor(color, 0.2),
    400: _tintColor(color, 0.1),
    500: _tintColor(color, 0),
    600: _tintColor(color, -0.1),
    700: _tintColor(color, -0.2),
    800: _tintColor(color, -0.3),
    900: _tintColor(color, -0.4),
  });
}