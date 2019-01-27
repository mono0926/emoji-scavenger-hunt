import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:camera/camera.dart';
import 'package:emoji_scavenger_hunt/model/game_service.dart';
import 'package:emoji_scavenger_hunt/model/label_detector.dart';
import 'package:emoji_scavenger_hunt/util/util.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class GameBloc implements Bloc {
  GameBloc({@required this.gameService, @required this.labelDetector})
      : _emojiNameController =
            BehaviorSubject<EmojiInfo>(seedValue: gameService.emoji),
        _timelimitController =
            BehaviorSubject<int>(seedValue: gameService.timelimit) {
    _advanceController.listen((_) {
      _timer.cancel();
      gameService.advance();
      _emojiNameController.add(gameService.emoji);
      _timelimitController.add(gameService.timelimit);
    });

    _startController.listen((_) {
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        _timelimitController.add(timelimit.value - 1);
      });
    });

    _detectionController.listen((image) async {
      if (_isDetecting) {
        return;
      }
      _isDetecting = true;
      final labels = await labelDetector.detectImage(image);
      logger
          .fine(labels.map((r) => '${r.label} (confidence: ${r.confidence})'));
      _isDetecting = false;
      if (labels
          .sublist(0, labels.length)
          .map((s) => s.label.toLowerCase())
          .contains(emoji.value.name)) {
        _correctController.add(null);
      }
    });
  }

  final GameService gameService;
  final LabelDetector labelDetector;

  final BehaviorSubject<EmojiInfo> _emojiNameController;
  final BehaviorSubject<int> _timelimitController;
  final _detectionController = PublishSubject<CameraImage>();
  final _advanceController = PublishSubject<void>();
  final _startController = PublishSubject<void>();
  final _correctController = PublishSubject<void>();
  Timer _timer;
  var _isDetecting = false;

  ValueObservable<EmojiInfo> get emoji => _emojiNameController;
  ValueObservable<int> get timelimit => _timelimitController;
  Observable<void> get correct => _correctController;
  Sink<void> get advance => _advanceController.sink;
  Sink<void> get start => _startController.sink;
  Sink<CameraImage> get detected => _detectionController.sink;

  @override
  void dispose() {}
}
