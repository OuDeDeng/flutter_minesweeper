import 'package:flutter/material.dart';

class ColorManager {
  static const lightPrimary = Color(0xFF4285f4);
  static const darkPrimary = Color(0xFF8ab4f8);

  static const lightScaffoldBackground = Color(0xFFf3f6fc);
  static const darkScaffoldBackground = Color(0xFF121212);

  static Color border(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return lightScaffoldBackground;
    } else {
      return darkScaffoldBackground;
    }
  }

  static const lightSurfaceBackground = Colors.white;
  static const darkSurfaceBackground = Color(0xFF1e1e1e);

  static Color surface(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return lightSurfaceBackground;
    } else {
      return darkSurfaceBackground;
    }
  }

  static const _lightItemNotClicked = Color(0xFFe8eaf6);
  static const _darkItemNotClicked = Color(0xFF303134);

  static Color itemNotClicked(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return _lightItemNotClicked;
    } else {
      return _darkItemNotClicked;
    }
  }

  static const _lightItemClicked = Color(0xFFe0e0e0);
  static const _darkItemClicked = Color(0xFF202124);

  static Color itemClicked(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return _lightItemClicked;
    } else {
      return _darkItemClicked;
    }
  }

  static const mine = Color(0xFFd32f2f);
}
