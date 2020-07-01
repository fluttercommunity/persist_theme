import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../persist_theme.dart';

class TrueBlackSwitch extends StatelessWidget {
  const TrueBlackSwitch({
    this.secondary,
    this.subtitle,
    this.title = const Text("True Black"),
    this.showOnlyDarkMode = true,
  });

  final Widget secondary, subtitle, title;
  final bool showOnlyDarkMode;

  @override
  Widget build(BuildContext context) {
    return new Consumer<ThemeModel>(
        builder: (context, model, child) => Container(
              child: !showOnlyDarkMode || model.darkMode && showOnlyDarkMode
                  ? SwitchListTile.adaptive(
                      secondary: secondary,
                      subtitle: subtitle,
                      title: title,
                      value: model.trueBlack,
                      onChanged: model.changeTrueBlack,
                    )
                  : null,
            ));
  }
}
