import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../persist_theme.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({
    this.secondary,
    this.subtitle,
    this.title = const Text("Dark Mode"),
  });

  final Widget secondary, subtitle, title;

  @override
  Widget build(BuildContext context) {
    return new Consumer<ThemeModel>(
        builder: (context, model, child) => Container(
              child: SwitchListTile.adaptive(
                secondary: secondary,
                subtitle: subtitle,
                title: title,
                value: model.darkMode,
                onChanged: model.changeDarkMode,
              ),
            ));
  }
}
