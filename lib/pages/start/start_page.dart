import 'package:emoji_scavenger_hunt/model/service_provider.dart';
import 'package:emoji_scavenger_hunt/model/sound_service.dart';
import 'package:emoji_scavenger_hunt/pages/start/count_down_view.dart';
import 'package:emoji_scavenger_hunt/pages/start/find_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum StartPageStep { three, two, one, find }

class StartPage extends StatefulWidget {
  final VoidCallback completed;

  const StartPage({
    Key key,
    @required this.completed,
  }) : super(key: key);

  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  var _step = StartPageStep.three;

  @override
  void initState() {
    super.initState();

    _advanceStep();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedSwitcher(
        child: _buildContent(),
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) =>
            FadeTransition(child: child, opacity: animation),
      ),
    );
  }

  void _advanceStep() async {
    ServiceProvider.of(context).soundService.play(SoundType.countdown);
    const duration = Duration(milliseconds: 1000);
    await Future.delayed(duration);
    setState(() {
      _step = StartPageStep.two;
    });
    await Future.delayed(duration);
    setState(() {
      _step = StartPageStep.one;
    });
    await Future.delayed(duration);
    setState(() {
      _step = StartPageStep.find;
    });
    await Future.delayed(duration);
    widget.completed();
  }

  Widget _buildContent() {
//    return FindView();
    switch (_step) {
      case StartPageStep.three:
        return const CountDownView(
          key: ValueKey('3'),
          text: '3',
          color: Color(0xFFDE34D3),
        );
      case StartPageStep.two:
        return const CountDownView(
          key: ValueKey('2'),
          text: '2',
          color: Color(0xFFECBA2E),
        );
      case StartPageStep.one:
        return const CountDownView(
          key: ValueKey('1'),
          text: '1',
          color: Color(0xFF5BCF3B),
        );
      case StartPageStep.find:
        return FindView();
    }
    assert(false, 'invalid step: $_step');
    return null;
  }
}
