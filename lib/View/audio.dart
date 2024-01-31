import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../Controller/provider.dart';
import '../main.dart';
import '../util.dart';

class DetailPage extends StatefulWidget {
  int index;
  DetailPage({ super.key,required this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    assetsAudioPlayer.playlistPlayAtIndex(widget.index);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading:StreamBuilder<bool>(
          stream: assetsAudioPlayer.isPlaying,
          builder: (context, snapshot) {
            var playing = snapshot.data ?? true;
            return StreamBuilder<bool>(
              stream: assetsAudioPlayer.isBuffering,
              builder: (context, snapshot1) {
                if (snapshot1.data ?? false) {
                  return SizedBox(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.chevron_left_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                    // child: CircularProgressIndicator(),
                  );
                }
                return IconButton(
                  onPressed: () {
                    if (playing) {
                      assetsAudioPlayer.pause();
                    }
                        Navigator.pop(context);
                        Provider.of<MediaProvider>(context, listen: false).refresh();
                  },
                  icon: Icon(
                    Icons.chevron_left_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                );
              },
            );
          },
        ),
        title: Text(
          "Playing Music",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: MediaQuery.sizeOf(context).width * 1,
            // color: Colors.grey,
            child:
                Image(image: AssetImage("images/back2.jpg"), fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Column(

              children: [
                SizedBox(
                  height: 150,
                ),
                StreamBuilder<Playing?>(
                  stream: assetsAudioPlayer.current,
                  builder:
                      (BuildContext context, AsyncSnapshot<Playing?> snapshot) {
                    var currentSong = snapshot.data?.audio;
                    if (currentSong != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 280,
                            width: 280,
                            // height: MediaQuery.of(context).size.height * 0.3,
                            // width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(40),
                                  topRight: Radius.circular(40)),
                            ),
                            child: Image.network(
                              currentSong.audio.metas.image?.path ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Center(
                              child: Text(
                                currentSong.audio.metas.title ?? "",
                                style:
                                TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: RichText(
                              text: TextSpan(
                                  text:  currentSong.audio.metas.album ?? "",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      ),
                                  children: [
                                    TextSpan(
                                        text: " & ",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,)),
                                    TextSpan(
                                        text: currentSong.audio.metas.artist ?? "",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,))
                                  ]),
                            ),
                          ),

                        ],
                      );
                    } else {
                      return SizedBox(height: 450);
                    }
                  },
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(21),
                      child:      StreamBuilder<Playing?>(
                        stream: assetsAudioPlayer.current,
                        builder:
                            (BuildContext context, AsyncSnapshot<Playing?> snapshot) {
                          var song = snapshot.data?.playlist.current;
                          if (recentplaysongs.contains(song)) {
                            print("Already");
                          } else if (song != null) {
                            print("object ${song.metas.title}");
                            recentplaysongs.add(song);
                            SchedulerBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              setState(() {});
                            });
                          }
                          return SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 90,),
                StreamBuilder<Duration>(
                  stream: assetsAudioPlayer.currentPosition,
                  builder: (context, snapshot) {
                    var sec = snapshot.data?.inSeconds ?? 0;
                    var min = snapshot.data?.inMinutes ?? 0;
                    return StreamBuilder<Playing?>(
                      stream: assetsAudioPlayer.current,
                      builder: (context, snapshot) {
                        var duration = snapshot.data?.audio.duration;
                        if (duration != null) {
                          return Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  value: sec.toDouble(),
                                  max: (duration.inSeconds).toDouble(),
                                  onChanged: (value) {
                                    print("value $value");
                                    assetsAudioPlayer
                                        .seek(Duration(seconds: value.toInt()));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${min % 60}:${sec % 60}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            ],
                          );
                        } else {
                          return SizedBox.shrink();
                          ;
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    IconButton(
                      onPressed: () {
                        assetsAudioPlayer.previous();
                      },
                      icon: Icon(
                        Icons.skip_previous,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    StreamBuilder<bool>(
                      stream: assetsAudioPlayer.isPlaying,
                      builder: (context, snapshot) {
                        var playing = snapshot.data ?? false;
                        return StreamBuilder<bool>(
                          stream: assetsAudioPlayer.isBuffering,
                          builder: (context, snapshot1) {
                            if (snapshot1.data ?? false) {
                              return SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              );
                            }
                            return IconButton(
                              onPressed: () {
                                print(assetsAudioPlayer.isPlaying.value);
                                assetsAudioPlayer.playOrPause();
                              },
                              icon: Icon(
                                playing ? Icons.pause : Icons.play_arrow,
                                size: 55,
                                color: Colors.white,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        assetsAudioPlayer.next();
                        print("length of list :- ${recentplaysongs.length}");
                      },
                      icon: Icon(
                        Icons.skip_next,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
