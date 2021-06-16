import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final String videoPath;
  VideoPlayerView({Key? key, required this.videoPath}) : super(key: key);

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    var file = File(widget.videoPath);
    _controller = VideoPlayerController.file(file);
    _controller.initialize();
    _controller.play();
    
  }
  
  void share(){
    Share.shareFiles([widget.videoPath], text: "SlideShow");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.share), onPressed: share,),
      body: Center(
        child: GestureDetector(
          onTap: () {
              setState(() {});
              _controller.initialize();
              _controller.play();
          },
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
