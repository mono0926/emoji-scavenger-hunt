import 'package:flutter/material.dart';

class CountDownView extends StatelessWidget {
  const CountDownView({
    @required Key key,
    @required this.text,
    @required this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style:
              Theme.of(context).primaryTextTheme.title.copyWith(fontSize: 300),
        ),
      ),
    );
  }
}
