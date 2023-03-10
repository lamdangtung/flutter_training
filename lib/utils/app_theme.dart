import 'package:flutter/material.dart';

abstract class AppTheme {
  abstract Color textColor;
  abstract Color iconColor;
  abstract Color backgroundColor;
}

class LightTheme extends AppTheme {
  @override
  Color iconColor = Colors.black;

  @override
  Color textColor = Colors.black;

  @override
  Color backgroundColor = Colors.white;
}

class DarkTheme extends AppTheme {
  @override
  Color iconColor = Colors.white;

  @override
  Color textColor = Colors.white;

  @override
  Color backgroundColor = Colors.black;
}
