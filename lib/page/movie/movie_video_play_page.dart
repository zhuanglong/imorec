import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:video_player/video_player.dart';

class MovieVideoPlayPage extends StatefulWidget {
  final String url;

  MovieVideoPlayPage(this.url);
  
  @override
  _MovieVideoPlayPageState createState() => _MovieVideoPlayPageState();
}

class _MovieVideoPlayPageState extends State<MovieVideoPlayPage> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(this.widget.url);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}