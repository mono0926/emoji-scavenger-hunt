import 'package:emoji_scavenger_hunt/model/game_bloc_provider.dart';
import 'package:emoji_scavenger_hunt/pages/capture/capture_page.dart';
import 'package:emoji_scavenger_hunt/pages/start/start_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  @override
  RootPageState createState() {
    return new RootPageState();
  }
}

class RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final height = query.size.height;
    return Stack(
      children: [
        CapturePage(),
        PositionedTransition(
          rect: RelativeRectTween(
            begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
            end: RelativeRect.fromLTRB(0, -height, 0, height),
          ).animate(_controller),
          child: StartPage(
            completed: () async {
              // TODO: このあたり適当すぎるので直す
              await _controller.forward();
              final bloc = GameBlocProvider.of(context);
              bloc.start.add(null);
            },
          ),
        ),
      ],
    );
  }
}
