import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDialog extends StatefulWidget {
  const VideoDialog({super.key, required this.url});
  final String url;
  @override
  State<VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  // late VideoPlayerController controller;
  late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    log(widget.url);
    super.initState();
    _controller = VideoPlayerController.network(
      widget.url,
    )..initialize().then((_) {
        setState(() {});
      });

    // _initializeVideoPlayerFuture = _controller.initialize();

    // _controller.setLooping(true);
  }

  @override
  void dispose() {
    // controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // child: FutureBuilder(
      //   future: _initializeVideoPlayerFuture,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return AspectRatio(
      //         aspectRatio: _controller.value.aspectRatio,
      //         // Use the VideoPlayer widget to display the video.
      //         child: Stack(
      //           alignment: Alignment.bottomCenter,
      //           children: [
      //             VideoPlayer(_controller),
      //             Row(
      //               children: [
      //                 Text(_controller.value.duration
      //                     .toString()
      //                     .split(".")[0]
      //                     .toString()),
      //                 Expanded(
      //                   child: VideoProgressIndicator(_controller,
      //                       allowScrubbing: true,
      //                       colors: const VideoProgressColors(
      //                         backgroundColor: Colors.redAccent,
      //                         playedColor: Colors.green,
      //                         bufferedColor: Colors.purple,
      //                       )),
      //                 ),
      //                 IconButton(
      //                     onPressed: () {
      //                       setState(() {
      //                         // If the video is playing, pause it.
      //                         if (_controller.value.isPlaying) {
      //                           _controller.pause();
      //                         } else {
      //                           // If the video is paused, play it.
      //                           _controller.play();
      //                         }
      //                       });
      //                     },
      //                     icon: Icon(
      //                       _controller.value.isPlaying
      //                           ? Icons.pause
      //                           : Icons.play_arrow,
      //                     )),
      //               ],
      //             )
      //           ],
      //         ),
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }
}
