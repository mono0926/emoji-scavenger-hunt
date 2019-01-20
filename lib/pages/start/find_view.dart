import 'package:emoji_scavenger_hunt/model/game_bloc_provider.dart';
import 'package:flutter/material.dart';

class FindView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GameBlocProvider.of(context);
    return Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'FIND',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .title
                            .copyWith(fontSize: 80),
                      ),
                      const SizedBox(width: 24),
                      Center(
                        child: Center(
                          child: Text(
                            bloc.emoji.value.character,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .title
                                .copyWith(fontSize: 100),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'in under ${bloc.timelimit.value} seconds',
                    style: Theme.of(context).textTheme.subhead,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 72),
              child: Text(
                'Find the emoji and point your camera at it before time expires.',
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}
