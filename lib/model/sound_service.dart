import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:meta/meta.dart';

enum SoundType { countdown, gameLoop }

@immutable
class SoundServiceResult {
  const SoundServiceResult(AudioPlayer player) : _player = player;

  final AudioPlayer _player;

  void stop() {
    _player.stop();
  }
}

@immutable
class SoundService {
  final _player = AudioCache(prefix: 'sounds/');

  Future<SoundServiceResult> play(SoundType type) async {
    final player = await _player.play(_getFileName(type));
    return SoundServiceResult(player);
  }

  Future<SoundServiceResult> loop(SoundType type) async {
    final player = await _player.loop(_getFileName(type));
    return SoundServiceResult(player);
  }

  String _getFileName(SoundType type) {
    switch (type) {
      case SoundType.countdown:
        return 'countdown.mp4';
      case SoundType.gameLoop:
        return 'game-loop.mp4';
    }
    assert(false);
    return null;
  }
}
