import 'package:emoji_scavenger_hunt/pages/root_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildTheme(),
      home: RootPage(),
//      home: CapturePage(),
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.light();
    final fontFamily = 'Changa One';
    return base.copyWith(
      platform: TargetPlatform.android,
      primaryColor: const Color(0xFFEC3F41),
//      textSelectionColor: Colors.white,
      buttonTheme: base.buttonTheme.copyWith(
//        minWidth: 44,
//        padding: EdgeInsets.all(8),
          ),
      primaryTextTheme: base.primaryTextTheme
          .copyWith(
            title: const TextStyle(fontSize: 32),
          )
          .apply(
            fontFamily: fontFamily,
          ),
      accentTextTheme: base.accentTextTheme
          .apply(
            bodyColor: Colors.white,
          )
          .copyWith(
            subhead: const TextStyle(
              fontWeight: FontWeight.w200,
            ),
          ),
    );
  }
}
