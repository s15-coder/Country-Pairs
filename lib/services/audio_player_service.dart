import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioPlayerService {
  AudioPlayer? audioPlayer;
  void initialize() {
    audioPlayer = AudioPlayer();
  }

  void playSound(String sound) {
    audioPlayer?.play(AssetSource(sound));
  }

  void stopSound() {
    audioPlayer?.stop();
  }

  void dispose() {
    audioPlayer?.dispose();
    audioPlayer = null;
  }
}

final audioPlayerService = Provider<AudioPlayerService>((ref) {
  return AudioPlayerService();
});
