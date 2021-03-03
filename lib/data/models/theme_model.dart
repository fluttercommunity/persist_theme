import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType { auto, light, dark, custom, black }

class ThemeModel extends ChangeNotifier {
  ThemeModel({
    this.customBlackTheme,
    this.customLightTheme,
    this.customDarkTheme,
    this.customCustomTheme,
    String key,
  }) {
    init();
  }

  final ThemeData customLightTheme, customDarkTheme, customBlackTheme, customCustomTheme;

  bool _autoMode = false;
  bool _platformDark = false;
  int _accentColor = Colors.redAccent.value;
  bool _customTheme = false;
  int _darkAccentColor = Colors.greenAccent.value;
  bool _darkMode = false;
  int _primaryColor = Colors.blue.value;
  SharedPreferences _prefs;
  bool _trueBlack = false;

  ThemeType get type {
    if (_autoMode ?? true) {
      _darkMode = _platformDark;
      if (_darkMode ?? false) {
        if (_trueBlack ?? false) return ThemeType.black;
        return ThemeType.dark;
      }
      return ThemeType.light;
    }
    if (_darkMode ?? false) {
      if (_trueBlack ?? false) return ThemeType.black;
      return ThemeType.dark;
    }
    if (_customTheme ?? false) return ThemeType.custom;
    return ThemeType.light;
  }

  void changeAuto(bool value) {
    _autoMode = value;
    _prefs.setBool("auto_mode", _autoMode);
    notifyListeners();
  }

  void changeDarkMode(bool value) {
    _darkMode = value;
    _prefs.setBool("dark_mode", _darkMode);
    notifyListeners();
  }

  void changeTrueBlack(bool value) {
    _trueBlack = value;
    _prefs.setBool("true_black", _trueBlack);
    notifyListeners();
  }

  void changeCustomTheme(bool value) {
    _customTheme = value;
    _prefs.setBool("custom_theme", _customTheme);
    notifyListeners();
  }

  void changePrimaryColor(Color value) {
    _primaryColor = value.value;
    _prefs.setInt("primary_color", _primaryColor);
    notifyListeners();
  }

  void changeAccentColor(Color value) {
    _accentColor = value.value;
    _prefs.setInt("accent_color", _accentColor);
    notifyListeners();
  }

  void changeDarkAccentColor(Color value) {
    _darkAccentColor = value.value;
    _prefs.setInt("dark_accent_color", _darkAccentColor);
    notifyListeners();
  }

  ThemeData get theme {
    if (_prefs == null) {
      init();
    }
    switch (type) {
      case ThemeType.light:
        return customLightTheme ?? ThemeData.light().copyWith();
      case ThemeType.dark:
        return customDarkTheme ??
            ThemeData.dark().copyWith(
              accentColor: darkAccentColor ?? null,
            );
      case ThemeType.black:
        return customBlackTheme ??
            ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
              backgroundColor: Colors.black,
              bottomAppBarColor: Colors.black,
              primaryColorDark: Colors.black,
              accentColor: darkAccentColor ?? null,
            );
      case ThemeType.custom:
        return customCustomTheme != null
            ? customCustomTheme.copyWith(
                primaryColor: primaryColor ?? Colors.blue,
                accentColor: accentColor ?? Colors.redAccent,
              )
            : ThemeData.light().copyWith(
                primaryColor: primaryColor ?? Colors.blue,
                accentColor: accentColor ?? Colors.redAccent,
              );
      default:
        return customLightTheme ?? ThemeData.light().copyWith();
    }
  }

  void checkPlatformBrightness(BuildContext context) {
    _platformDark = (MediaQuery.of(context).platformBrightness == Brightness.dark);
  }

  ThemeData get darkTheme {
    if (_prefs == null) {
      init();
    }

    if (_trueBlack ?? false) {
      return customBlackTheme ??
          ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black,
            backgroundColor: Colors.black,
            bottomAppBarColor: Colors.black,
            primaryColorDark: Colors.black,
            accentColor: darkAccentColor ?? null,
          );
    }
    return customDarkTheme ??
        ThemeData.dark().copyWith(
          accentColor: darkAccentColor ?? null,
        );
  }

  Color get backgroundColor {
    if (darkMode ?? false) {
      if (trueBlack ?? false) return Colors.black;
      return ThemeData.dark().scaffoldBackgroundColor;
    }
    if (customTheme ?? false) return primaryColor;
    return null;
  }

  Color get textColor {
    if (customTheme ?? false) return Colors.white;
    if (darkMode ?? false) return Colors.white;
    return Colors.black;
  }

  Color get textColorInvert {
    if (customTheme ?? false) return Colors.black;
    if (darkMode ?? false) return Colors.black;
    return Colors.white;
  }

  Future init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    if (_prefs != null) {
      _autoMode = _prefs.getBool("auto_mode");
      _darkMode = _prefs.getBool("dark_mode");
      _trueBlack = _prefs.getBool("true_black");
      _customTheme = _prefs.getBool("custom_theme");
      _primaryColor = _prefs.getInt("primary_color");
      _accentColor = _prefs.getInt("accent_color");
      _darkAccentColor = _prefs.getInt("dark_accent_color");
      notifyListeners();
    } else {
      print("Error Loading Theme...");
    }
  }

  bool get autoMode => _autoMode ?? true;

  bool get darkMode => _darkMode ?? (type == ThemeType.dark || type == ThemeType.black);

  bool get trueBlack => _trueBlack ?? type == ThemeType.black;

  bool get customTheme => _customTheme ?? type == ThemeType.custom;

  Color get primaryColor {
    if (_primaryColor == null) {
      return type == ThemeType.dark ? ThemeData.dark().primaryColor : ThemeData.light().primaryColor;
    }
    return Color(_primaryColor);
  }

  Color get accentColor {
    if (type == ThemeType.dark || type == ThemeType.black) {
      if (_darkAccentColor == null) {
        return ThemeData.dark().accentColor;
      }
      return Color(_darkAccentColor);
    }

    if (_accentColor == null) {
      return ThemeData.light().accentColor;
    }

    if (_customTheme) {
      return Color(_accentColor);
    }

    return Colors.redAccent;
  }

  Color get darkAccentColor {
    if (_darkAccentColor == null) return ThemeData.dark().accentColor;
    return Color(_darkAccentColor);
  }

  void reset() {
    _prefs.clear();
    _autoMode = true;
    _darkMode = false;
    _trueBlack = false;
    _customTheme = false;
    _primaryColor = Colors.blue.value;
    _accentColor = Colors.redAccent.value;
    _darkAccentColor = Colors.greenAccent.value;
  }
}
