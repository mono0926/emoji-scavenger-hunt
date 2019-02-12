import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:camera/camera.dart';
import 'package:emoji_scavenger_hunt/model/game_service.dart';
import 'package:emoji_scavenger_hunt/model/label_detector.dart';
import 'package:emoji_scavenger_hunt/model/sound_service.dart';
import 'package:emoji_scavenger_hunt/util/util.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class GameBloc implements Bloc {
  GameBloc({
    @required this.gameService,
    @required this.labelDetector,
    @required this.soundService,
  })  : _emojiNameController =
            BehaviorSubject<EmojiInfo>(seedValue: gameService.emoji),
        _timeLimitController =
            BehaviorSubject<int>(seedValue: gameService.timelimit) {
    _countdownController.listen((_) {
      soundService.play(SoundType.countdown);
    });

    _startController.listen((_) async {
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        _timeLimitController.add(timeLimit.value - 1);
      });
      _soundLoop = await soundService.loop(SoundType.gameLoop);
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
        _correctController.add(image);
      }
    });

    _advanceController.listen((_) {
      _timer.cancel();
      gameService.advance();
      _emojiNameController.add(gameService.emoji);
      _timeLimitController.add(gameService.timelimit);
    });

    _exitController.listen((_) {
      _soundLoop?.stop();
    });
  }

  final GameService gameService;
  final LabelDetector labelDetector;
  final SoundService soundService;
  // TODO: Call when game ended
  SoundServiceResult _soundLoop;

  final BehaviorSubject<EmojiInfo> _emojiNameController;
  final BehaviorSubject<int> _timeLimitController;
  final _detectionController = PublishSubject<CameraImage>();
  final _advanceController = PublishSubject<void>();
  final _startController = PublishSubject<void>();
  final _exitController = PublishSubject<void>();
  final _countdownController = PublishSubject<void>();
  final _correctController = PublishSubject<CameraImage>();
  Timer _timer;
  var _isDetecting = false;

  ValueObservable<EmojiInfo> get emoji => _emojiNameController;
  ValueObservable<int> get timeLimit => _timeLimitController;
  Observable<CameraImage> get correct => _correctController;
  Sink<void> get countdown => _countdownController.sink;
  Sink<void> get advance => _advanceController.sink;
  Sink<void> get start => _startController.sink;
  Sink<void> get exit => _exitController.sink;
  Sink<CameraImage> get detected => _detectionController.sink;

  // TODO: Add
  @override
  void dispose() {}
}
