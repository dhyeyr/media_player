import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controller/provider.dart';
import '../Model/arrijitsih.dart';
import '../Model/darshan.dart';
import '../main.dart';
import '../util.dart';
import 'audio.dart';
import 'exx.dart';
import 'new.dart';

class Audio_home extends StatefulWidget {

  Audio_home({super.key});

  @override
  State<Audio_home> createState() => _Audio_homeState();
}

class _Audio_homeState extends State<Audio_home> {
  // var assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  List<Audio> playedSongs = [];
  bool isPlaying = false; // Add this variable
  bool clicked = false;
  int index = 0;

  @override
  void initState() {
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
   ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Media Player",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print("sdfsdfsdfsdf");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Videoplay(),
                    ));
              },
              icon: Icon(Icons.video_collection_outlined))
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: RichText(
                    text: TextSpan(
                        text: "Play Best Music \n",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: "all time!",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold))
                        ]),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                    items: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("images/tm1.jpg",
                            fit: BoxFit.fill, width: 1000),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("images/tm3.png",
                            fit: BoxFit.fill, width: 1000),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("images/tm4.png",
                            fit: BoxFit.fill, width: 1000),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      aspectRatio: 1,
                      // autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayInterval: Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        print("index $index");
                      },
                    )),
             SizedBox(height: 10,),
                StreamBuilder<Playing?>(
                    stream: assetsAudioPlayer.current,
                    builder: (context, snapshot) {
                      var checkdata = snapshot.data?.playlist.current;
                      return checkdata != null ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Recently Played",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 25),
                            ),
                          ),
                          SizedBox(
                            height: 165,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: recentplaysongs.length,
                              itemBuilder: (BuildContext context, int index) {
                                var audio = recentplaysongs[index];
                                return InkWell(
                                  onTap: () {
                                    assetsAudioPlayer.open(
                                        Playlist(audios: recentplaysongs),
                                        autoStart: false);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return DetailPage(index: index,);
                                        },
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          height:
                                          MediaQuery
                                              .sizeOf(context)
                                              .height *
                                              0.15,
                                          width:
                                          MediaQuery
                                              .sizeOf(context)
                                              .width *
                                              0.35,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                            BorderRadius.circular(20),
                                          ),
                                          child: Image.network(
                                            audio.metas.image?.path ?? "",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        audio.metas.title ?? "",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ) : SizedBox();
                    }
                ),

                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 5),
                  child: Text(
                    "Top Music Album",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),


                SizedBox(
                  height: 165,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: files.length,
                    itemBuilder: (BuildContext context, int index) {
                      var audio = files[index];
                      return InkWell(
                        onTap: () {
                          assetsAudioPlayer.open(
                            Playlist(audios: files),
                            autoStart: false,
                            showNotification: true,
                            notificationSettings: NotificationSettings(
                              customPlayPauseAction: (player) async {

                                if (player.isPlaying.value) {
                                  player.pause();
                                } else {
                                  player.play();
                                }
                              },
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailPage(
                                  index: index,
                                );
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                height:
                                MediaQuery.sizeOf(context).height *
                                    0.15,
                                width: MediaQuery.sizeOf(context).width *
                                    0.35,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(
                                  audio.metas.image?.path ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              audio.metas.title ?? "",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 5),
                  child: Text(
                    "Arijit Singh",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: arrSongList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var audio = arrSongList[index];
                      return InkWell(
                        onTap: () {
                          assetsAudioPlayer.open(
                              Playlist(audios: arrSongList),
                              autoStart: false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailPage(index: index,);
                              },
                            ),
                          );
                          // assetsAudioPlayer.playlistPlayAtIndex(index);
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                height:
                                MediaQuery
                                    .sizeOf(context)
                                    .height *
                                    0.15,
                                width: MediaQuery
                                    .sizeOf(context)
                                    .width *
                                    0.35,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(
                                  audio.metas.image?.path ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              audio.metas.title ?? "",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 5),
                  child: Text(
                    "Darshan Raval",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: darshanSongList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var audio = darshanSongList[index];
                      return InkWell(
                        onTap: () {
                          assetsAudioPlayer.open(
                              Playlist(audios: darshanSongList),
                              autoStart: false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailPage(index: index,);
                              },
                            ),
                          );
                          // assetsAudioPlayer.playlistPlayAtIndex(index);
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                height:
                                MediaQuery
                                    .sizeOf(context)
                                    .height *
                                    0.15,
                                width: MediaQuery
                                    .sizeOf(context)
                                    .width *
                                    0.35,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(
                                  audio.metas.image?.path ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              audio.metas.title ?? "",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),


                SizedBox(height: 80,)
              ],
            ),
          ),

          StreamBuilder<Playing?>(
              stream: assetsAudioPlayer.current,
              builder: (context, snapshot) {
                var playcurrent = snapshot.data?.playlist.current;
                return playcurrent != null ?
                Positioned(
                  bottom: 0,
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DetailPage(index: index);
                            },));
                        },
                        child: Container(
                          height: MediaQuery
                              .sizeOf(context)
                              .height * 0.11,
                          width: MediaQuery
                              .sizeOf(context)
                              .width * 1,
                          color: Colors.red[200],
                          child: StreamBuilder<Playing?>(
                            stream: assetsAudioPlayer.current,
                            builder: (context, snapshot) {
                              var title =
                                  snapshot.data?.playlist.current.metas.title ??
                                      "";
                              var album =
                                  snapshot.data?.playlist.current.metas.album ??
                                      "";
                              var path =
                                  snapshot.data?.playlist.current.metas.image
                                      ?.path ??
                                      "";
                              return Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 70,
                                    width: 70,
                                    color: Colors.grey,
                                    child: Image.network(path),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          album,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 50,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                assetsAudioPlayer.previous();
                              },
                              icon: Icon(
                                Icons.skip_previous,
                                size: 20,
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
                                        if (playing) {
                                          assetsAudioPlayer.pause();
                                        } else {
                                          assetsAudioPlayer.play();
                                        }
                                      },
                                      icon: Icon(
                                        playing ? Icons.pause : Icons
                                            .play_arrow,
                                        size: 25,
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
                                print("length of list :- ${recentplaysongs
                                    .length}");
                              },
                              icon: Icon(
                                Icons.skip_next,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ) : SizedBox();
              }
          )


        ],
      ),
    );
  }
}
