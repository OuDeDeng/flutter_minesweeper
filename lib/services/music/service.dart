import 'package:just_audio/just_audio.dart';
import 'package:minesweeper/gen/assets.gen.dart';

class MusicService {
  static final MusicService _singleton = MusicService._internal();

  factory MusicService() => _singleton;

  MusicService._internal();

  final _player = AudioPlayer();

  Future<void> asyncInit() async {
    await _player.setAsset(Assets.music.background);
    await _player.setLoopMode(LoopMode.one);
    _player.play();
  }
}
