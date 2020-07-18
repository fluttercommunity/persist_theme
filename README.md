[![Flutter Community: persist_theme](https://fluttercommunity.dev/_github/header/persist_theme)](https://github.com/fluttercommunity/community)

[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/rodydavis)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WSH3GVC49GNNJ)
![github pages](https://github.com/fluttercommunity/persist_theme/workflows/github%20pages/badge.svg)

# persist_theme

A Flutter plugin for persisting and dynamically changing the theme.

Online Demo: https://fluttercommunity.github.io/persist_theme/

``` dart 
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


```

## Customization

* There are widgets provided but can be fully customized.
* By default hide elements based on the theme.
* This package relies on [provider](https://pub.dev/packages/provider) internally, which you can ignore if you're only using this as shown above.
  For advanced use, it is possible to obtain the [ThemeModel](https://pub.dev/documentation/persist_theme/latest/data_models_theme_model/ThemeModel-class.html), for example by using `context.read<ThemeModel>()` (You will have to import the provider library first. See https://pub.dev/packages/provider for additional information).

## Screenshots

<img src="https://raw.githubusercontent.com/fluttercommunity/persist_theme/master/screenshots/1.png" width="19%"> <img src="https://raw.githubusercontent.com/fluttercommunity/persist_theme/master/screenshots/2.png" width="19%"> <img src="https://raw.githubusercontent.com/fluttercommunity/persist_theme/master/screenshots/3.png" width="19%"> <img src="https://raw.githubusercontent.com/fluttercommunity/persist_theme/master/screenshots/4.png" width="19%"> <img src="https://raw.githubusercontent.com/fluttercommunity/persist_theme/master/screenshots/5.png" width="19%">
