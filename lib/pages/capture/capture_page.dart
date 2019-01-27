import 'package:emoji_scavenger_hunt/model/game_bloc_provider.dart';
import 'package:emoji_scavenger_hunt/pages/capture/camera_view.dart';
import 'package:flutter/material.dart';

class CapturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GameBlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'FIND ${bloc.emoji.value.character}',
          style: Theme.of(context).primaryTextTheme.title,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              '🏆 0',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: StreamBuilder<int>(
              initialData: bloc.timelimit.value,
              stream: bloc.timelimit,
              builder: (context, snap) {
                return Text(
                  '⏱ ${snap.data}',
                  style: Theme.of(context).primaryTextTheme.title,
                );
              },
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          CameraView(),
          Positioned(
            right: 0,
            top: 0,
            child: FlatButton(
              onPressed: () {},
              child: Text(
                'QUIT',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
            ),
          )
        ],
      ),
    );
  }
}
