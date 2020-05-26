import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/models/theme_model.dart';
import 'data/models/theme_provider.dart';

export 'data/models/theme_model.dart';
export 'data/models/theme_provider.dart';
export 'ui/theme_widgets.dart';

class PersistTheme extends StatelessWidget {
  final ThemeModel model;
  final Widget child;
  final Widget Function(BuildContext, ThemeModel, Widget) builder;

  const PersistTheme({
    Key key,
    @required this.model,
    @required this.builder,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      model: model,
      child: Consumer<ThemeModel>(
        builder: (context, val, child) => builder(context, val, child),
        child: child,
      ),
    );
  }
}
