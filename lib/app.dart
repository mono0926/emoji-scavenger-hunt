import 'package:emoji_scavenger_hunt/pages/root_page.dart';
import 'package:emoji_scavenger_hunt/pages/top_page.dart';
import 'package:emoji_scavenger_hunt/util/logger.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildTheme(),
      home: const TopPage(),
      onGenerateRoute: _handleRoutes,
//      home: RootPage(),
//      home: CapturePage(),
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.light();
    final fontFamily = 'Changa One';
    return base.copyWith(
      platform: TargetPlatform.android,
      primaryColor: const Color(0xFFEC3F41),
      iconTheme: base.iconTheme.copyWith(
        color: Colors.white,
      ),
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: const Color(0xFFDE34D3),
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
            body1: const TextStyle(
              height: 1.2,
            ),
            caption: const TextStyle(
              color: Colors.white,
            ),
          ),
    );
  }

  Route _handleRoutes(RouteSettings settings) {
    logger.warning('name: ${settings.name}');
    switch (settings.name) {
      case RootPage.routeName:
        return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              logger.warning('InputTaskPage returned');
              return const RootPage();
            });
    }
    assert(false);
    return null;
  }
}
