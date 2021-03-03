import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../persist_theme.dart';

class AutoSwitch extends StatelessWidget {
  const AutoSwitch({
    this.leading,
    this.subtitle,
    this.title = const Text("Auto theme"),
  });

  final Widget leading, subtitle, title;

  @override
  Widget build(BuildContext context) {
    return new Consumer<ThemeModel>(
        builder: (context, model, child) => Container(
              child: ListTile(
                      leading: leading,
                      subtitle: subtitle,
                      title: title,
                      trailing: Switch.adaptive(
                        value: model.autoMode,
                        onChanged: model.changeAuto,
                      ),
                    ),
            ));
  }
}
