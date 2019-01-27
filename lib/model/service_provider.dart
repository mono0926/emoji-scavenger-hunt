import 'package:emoji_scavenger_hunt/model/game_service.dart';
import 'package:emoji_scavenger_hunt/model/label_detector.dart';
import 'package:emoji_scavenger_hunt/model/sound_service.dart';
import 'package:flutter/widgets.dart';

class ServiceProvider extends InheritedWidget {
  ServiceProvider({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final gameService = GameService();
  final labelDetector = LabelDetector();
  final soundService = SoundService();

  static ServiceProvider of(BuildContext context) {
    return context
        .ancestorInheritedElementForWidgetOfExactType(ServiceProvider)
        .widget as ServiceProvider;
  }

  @override
  bool updateShouldNotify(ServiceProvider oldWidget) => false;
}
