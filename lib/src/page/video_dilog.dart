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
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    log(widget.url);
    super.initState();
    _controller = VideoPlayerController.network(
      widget.url,
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
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
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_controller),
                  Row(
                    children: [
                      Text(_controller.value.duration
                          .toString()
                          .split(".")[0]
                          .toString()),
                      Expanded(
                        child: VideoProgressIndicator(_controller,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                              backgroundColor: Colors.redAccent,
                              playedColor: Colors.green,
                              bufferedColor: Colors.purple,
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              // If the video is playing, pause it.
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                // If the video is paused, play it.
                                _controller.play();
                              }
                            });
                          },
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          )),
                    ],
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // child: Column(mainAxisSize: MainAxisSize.min, children: [
      //   SizedBox(
      //     height: 200,
      //     width: 200,
      //     child: VideoPlayer(controller),
      //   ),
      //   Text("Total Duration: ${controller.value.duration}"),
      //   SizedBox(
      //       height: 20,
      //       width: 100,
      //       child: VideoProgressIndicator(controller,
      //           allowScrubbing: true,
      //           colors: const VideoProgressColors(
      //             backgroundColor: Colors.redAccent,
      //             playedColor: Colors.green,
      //             bufferedColor: Colors.purple,
      //           ))),
      //   Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       IconButton(
      //           onPressed: () {
      //             if (controller.value.isPlaying) {
      //               controller.pause();
      //             } else {
      //               controller.play();
      //             }
      //             setState(() {});
      //           },
      //           icon: Icon(controller.value.isPlaying
      //               ? Icons.pause
      //               : Icons.play_arrow)),
      //       IconButton(
      //           onPressed: () {
      //             controller.seekTo(const Duration(seconds: 0));
      //             setState(() {});
      //           },
      //           icon: const Icon(Icons.stop))
      //     ],
      //   )
      // ]),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //       } else {
      //         _controller.play();
      //       }
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}
