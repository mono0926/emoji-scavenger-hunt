import 'package:audioplayers/audio_cache.dart';
import 'package:meta/meta.dart';

enum SoundType { countdown }

@immutable
class SoundService {
  final _player = AudioCache(prefix: 'sounds/');
  void play(SoundType type) {
    switch (type) {
      case SoundType.countdown:
        _player.play('countdown.mp4');
    }
  }
}
