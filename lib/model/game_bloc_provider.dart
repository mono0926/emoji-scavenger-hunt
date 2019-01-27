import 'package:bloc_provider/bloc_provider.dart';
import 'package:emoji_scavenger_hunt/model/game_bloc.dart';
import 'package:emoji_scavenger_hunt/model/service_provider.dart';
import 'package:flutter/widgets.dart';

class GameBlocProvider extends BlocProvider<GameBloc> {
  GameBlocProvider({@required Widget child})
      : super(
            child: child,
            creator: (context, _bag) {
              final serviceProvider = ServiceProvider.of(context);
              return GameBloc(
                  gameService: serviceProvider.gameService,
                  labelDetector: serviceProvider.labelDetector);
            });

  static GameBloc of(BuildContext context) => BlocProvider.of(context);
}
