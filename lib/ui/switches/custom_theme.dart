import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../persist_theme.dart';

class CustomThemeSwitch extends StatelessWidget {
  const CustomThemeSwitch({
    this.secondary,
    this.subtitle,
    this.title = const Text("Custom Theme"),
    this.showOnlyLightMode = true,
  });

  final Widget secondary, subtitle, title;
  final bool showOnlyLightMode;

  @override
  Widget build(BuildContext context) {
    return new Consumer<ThemeModel>(
        builder: (context, model, child) => Container(
              child: !showOnlyLightMode || !model.darkMode && showOnlyLightMode
                  ? SwitchListTile.adaptive(
                      secondary: secondary,
                      subtitle: subtitle,
                      title: title,
                      value: model.customTheme,
                      onChanged: model.changeCustomTheme,
                    )
                  : null,
            ));
  }
}
