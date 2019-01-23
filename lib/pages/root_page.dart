import 'package:emoji_scavenger_hunt/model/game_bloc_provider.dart';
import 'package:emoji_scavenger_hunt/pages/capture/capture_page.dart';
import 'package:emoji_scavenger_hunt/pages/start/start_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage();

  static const routeName = '/root';

  @override
  RootPageState createState() {
    return new RootPageState();
  }
}

class RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _animationController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CapturePage(),
        SlideTransition(
          position: _positionAnimation,
          child: StartPage(
            completed: () async {
              // TODO: このあたり適当すぎるので直す
              await _animationController.forward();
              final bloc = GameBlocProvider.of(context);
              bloc.start.add(null);
            },
          ),
        ),
      ],
    );
  }
}
