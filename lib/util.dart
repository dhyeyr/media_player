
import 'package:assets_audio_player/assets_audio_player.dart';

List<Audio> files = [
  Audio.network(
    "https://pagalfree.com/musics/128-Lutt%20Putt%20Gaya%20-%20Dunki%20128%20Kbps.mp3",
    metas: Metas(
      title: "Lutt Putt Gaya",
      album: "Dhunki",
      artist: "Pritam, Arijit Singh, Swanand Kirkire, IP Singh",
      image: MetasImage.network("https://pagalfree.com/images/128Lutt%20Putt%20Gaya%20-%20Dunki%20128%20Kbps.jpg",),

    ),
  ),

  Audio.network(
    "https://pagalfree.com/musics/128-Satranga%20-%20Animal%20128%20Kbps.mp3",
    metas: Metas(
      title: "Satranga",
      album: "Animal",
      artist: "Arijit Singh, Shreyas Puranik, Siddharth-Garima",
      image: MetasImage.network("https://pagalfree.com/images/128Satranga%20-%20Animal%20128%20Kbps.jpg",),

    ),
  ),

  Audio.network(
    "https://pagalfree.com/musics/128-O%20Maahi%20-%20Dunki%20128%20Kbps.mp3",
    metas: Metas(
      title: "O Maahi",
      album: "Dhunki",
      artist: "Pritam, Arijit Singh, Irshad Kamil",
      image: MetasImage.network("https://pagalfree.com/images/128O%20Maahi%20-%20Dunki%20128%20Kbps.jpg",),

    ),
  ),

  Audio.network(
    "https://pagalfree.com/musics/128-Sooraj%20Hi%20Chhaon%20Banke%20-%20Salaar%20128%20Kbps.mp3",
    metas: Metas(
      title: "Sooraj Hi Chhaon Banke",
      album: "Salaar",
      artist: "Riya Mukherjee, Ravi Basrur, Menuka Poudel",
      image: MetasImage.network("https://pagalfree.com/images/128Sooraj%20Hi%20Chhaon%20Banke%20-%20Salaar%20128%20Kbps.jpg",),

    ),
  ),

  Audio.network(
    "https://pagalfree.com/musics/128-Arjan%20Vailly%20-%20Animal%20128%20Kbps.mp3",
    metas: Metas(
      title: "Arjan Vailly",
      album: "Animal",
      artist: "Manan Bhardwaj, Bhupinder Babbal",
      image: MetasImage.network("https://pagalfree.com/images/128Arjan%20Vailly%20-%20Animal%20128%20Kbps.jpg",),

    ),
  ),

  Audio.network(
    "https://pagalfree.com/musics/128-Papa%20Meri%20Jaan%20-%20Animal%20128%20Kbps.mp3",
    metas: Metas(
      title: "Papa Meri Jaan",
      album: "Animal",
      artist: "Sonu Nigam, Harshavardhan Rameshwar, Raj Shekhar",
      image: MetasImage.network("https://pagalfree.com/images/128Papa%20Meri%20Jaan%20-%20Animal%20128%20Kbps.jpg",),

    ),
  ),
];

List<Audio>  recentplaysongs = [];