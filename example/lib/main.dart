import 'package:flutter/material.dart';

import 'package:persist_theme/persist_theme.dart';
import 'package:provider/provider.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

/// main is entry point of Flutter application
void main() {
  // Desktop platforms aren't a valid platform.
  if (!kIsWeb) _setTargetPlatformForDesktop();
  return runApp(MyApp());
}

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PersistTheme(
      model: ThemeModel(),
      builder: (context, model, child) {
        return MaterialApp(
          theme: model.theme,
          home: child,
        );
      },
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(title: const Text('Persist Theme')),
      body: ListView(
        children: MediaQuery.of(context).size.width >= 480
            ? <Widget>[
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Flexible(child: DarkModeSwitch()),
                    Flexible(child: TrueBlackSwitch()),
                  ],
                ),
                CustomThemeSwitch(),
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Flexible(child: PrimaryColorPicker()),
                    Flexible(child: AccentColorPicker()),
                  ],
                ),
                DarkAccentColorPicker(),
              ]
            : <Widget>[
                DarkModeSwitch(),
                TrueBlackSwitch(),
                CustomThemeSwitch(),
                PrimaryColorPicker(),
                AccentColorPicker(),
                DarkAccentColorPicker(),
              ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _theme.theme.accentColor,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
