import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeLight {
  late ThemeData theme;
  ThemeLight() {
    theme = ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.black87,
        centerTitle: true,
      ),
    );
  }
}

Color primary = Colors.blueGrey;
Color white = Colors.white;

class ColorLight {
  final Color _textColor = Colors.white70;
  final Color _primary = Colors.blueGrey;
}
