import 'package:emoji_scavenger_hunt/model/emojis.dart';
import 'package:meta/meta.dart';

class EmojiInfo {
  EmojiInfo({
    @required this.character,
    @required this.name,
  });
  final String character;
  final String name;
}

class GameService {
  // TODO: ランダムにする
  // TODO: 10個にする
  final _emojis = [
    Emoji.level1[0],
    Emoji.level2[0],
    Emoji.level3[0],
    Emoji.level4[0],
    Emoji.level5[0]
  ];

  var _currentEmojisIndex = 0;
  EmojiInfo get emoji => EmojiInfo(
        character: _emojis[_currentEmojisIndex]['emoji'],
        name: _emojis[_currentEmojisIndex]['name'],
      );
  int get timelimit => 20 + _currentEmojisIndex;

  void advance() {
    _currentEmojisIndex++;
  }
}
