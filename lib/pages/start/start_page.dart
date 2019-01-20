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

  void _advanceStep() async {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Scaffold(
        body: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
//    return FindView();
    switch (_step) {
      case StartPageStep.three:
        return const CountDownView(
          text: '3',
          color: Color(0xFFDE34D3),
        );
      case StartPageStep.two:
        return const CountDownView(
          text: '2',
          color: Color(0xFFECBA2E),
        );
      case StartPageStep.one:
        return const CountDownView(
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
