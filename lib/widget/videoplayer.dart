import 'dart:io';
import 'dart:typed_data';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  var videoid;
  Player({Key? key, this.videoid}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late File _videoFile;
  late VideoPlayerController _controller;
  bool isPlay = false;
  @override
  @override
  void initState() {
    print(widget.videoid);
    super.initState();
    _controller = VideoPlayerController.network(
        widget.videoid);
    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.isInitialized &&
          (_controller.value.duration == _controller.value.position)) {
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ExplorerScreen(),
        //     ));
        // _controller.dispose();
      }
    });
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    _controller.setVolume(0.0);
    _controller.setLooping(false);
  }

  Uint8List? _videoData;
  String? imageString;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _saveImage() async {
    final result = await ImageGallerySaver.saveFile(widget.videoid);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Video saved to gallery'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffb4776e6),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Video"),
              GestureDetector(
                  onTap: () async {
                    _saveImage();
                  },
                  child: const Icon(Icons.download))
            ],
          ),
          automaticallyImplyLeading: true,
        ),
        body: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: VideoPlayer(_controller)),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  if (isPlay) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }

                  setState(() {
                    isPlay = !isPlay;
                  });
                },
                icon: Icon(
                  isPlay ? Icons.pause_circle : Icons.play_circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
