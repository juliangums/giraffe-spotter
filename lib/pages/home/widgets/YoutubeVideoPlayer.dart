import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class YoutubeVideoPlayer extends StatelessWidget {
  String? videoId;
  String vimeoId;
  bool? youtube;

  YoutubeVideoPlayer({this.videoId, this.vimeoId = '', this.youtube = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Palette.dividerColor,
      appBar: AppBar(
          key: Key('backButton'),
          iconTheme: IconThemeData(
            color: Palette.primaryColor, //change your color here
          ),
          elevation: 0.0,
          brightness: Brightness.dark,
          backwardsCompatibility: false,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark)),
      body: youtube == true
          ? Container(
              child: YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: '$videoId',
                      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
                    ),
                  ),
                  builder: (context, player) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // some widgets
                        player,
                        //some other widgets
                      ],
                    );
                  }))
          : Container(
              color: Palette.dividerColor,
              child: VimeoPlayer(videoId: vimeoId)),
    );
  }
}
