import 'package:flutter/material.dart';

class CapturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'FIND 🐶',
          style: Theme.of(context).primaryTextTheme.title,
        ),
        actions: [
          MaterialButton(
//            padding: EdgeInsets.zero,
//            minWidth: 0,
            child: Text(
              '🏆 0',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          MaterialButton(
//            padding: EdgeInsets.zero,
//            minWidth: 0,
            child: Text(
              '⏱ 0',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          )
        ],
      ),
      body: Center(child: Text('(　´･‿･｀)')),
    );
  }
}
