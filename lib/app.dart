import 'package:emoji_scavenger_hunt/pages/capture_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildTheme(),
      home: CapturePage(),
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.light();
    final fontFamily = 'Changa One';
    return base.copyWith(
      platform: TargetPlatform.android,
      primaryColor: Color(0xFFEC3F41),
      buttonTheme: base.buttonTheme.copyWith(
        minWidth: 44,
        padding: EdgeInsets.all(8),
      ),
      primaryTextTheme: base.primaryTextTheme
          .copyWith(
            title: TextStyle(fontSize: 32),
          )
          .apply(
            fontFamily: fontFamily,
          ),
      textTheme: base.textTheme.apply(fontFamily: fontFamily),
    );
  }
}
