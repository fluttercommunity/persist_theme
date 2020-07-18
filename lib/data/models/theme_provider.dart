import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme_model.dart';

class ThemeProvider extends StatelessWidget {
  final ThemeModel model;
  final Widget child;
  final bool init;
  const ThemeProvider({
    Key key,
    @required this.model,
    @required this.child,
    this.init = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: child,
    );
  }
}
