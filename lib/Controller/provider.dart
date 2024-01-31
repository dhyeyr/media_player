import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

import '../main.dart';

class MediaProvider extends ChangeNotifier{

  bool isPlaying = false; // Add this variable
  bool clicked = false;
  List<Audio> playedSongs = [];
  List<Audio> favorite = [];
  int index=0;

  void addRecent(Audio audio) {
    playedSongs.add(audio);
    print("Audui ${audio.metas.title}");
    print("Audui ${playedSongs.length}");
    notifyListeners();
  }


  void refresh(){
    notifyListeners();
  }


  void restartCurrentSong() {
    assetsAudioPlayer.seek(Duration.zero, force: true);
    assetsAudioPlayer.play();
    notifyListeners();
  }



}
