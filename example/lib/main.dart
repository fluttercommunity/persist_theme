import 'package:flutter/material.dart';

import 'package:persist_theme/persist_theme.dart';

/// main is entry point of Flutter application
void main() {
  return runApp(MyApp());
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
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
