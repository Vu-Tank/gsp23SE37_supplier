import 'dart:developer';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

class VideoDialog extends StatefulWidget {
  const VideoDialog({super.key, required this.url});
  final String url;
  @override
  State<VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(
    //   widget.url,
    // );
    log(widget.url);
    videoPlayerController = VideoPlayerController.network(widget.url);
    // ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );

    // _initializeVideoPlayerFuture = _controller.initialize();

    // _controller.setLooping(true);
  }

  @override
  void dispose() {
    // _controller.dispose();
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Dialog(
    //   child: CustomVideoPlayer(
    //       customVideoPlayerController: _customVideoPlayerController),
    // );
    return Dialog(
      child: FutureBuilder(
        future: videoPlayerController.initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (!snapshot.hasError) {
                videoPlayerController.play();
                return Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    CustomVideoPlayer(
                        customVideoPlayerController:
                            _customVideoPlayerController),
                    IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ))
                  ],
                );
              } else {
                return Center(
                  child: Column(children: [
                    Text(
                      snapshot.error.toString(),
                      style: AppStyle.errorStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      height: 54,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        style: AppStyle.myButtonStyle,
                        child: Text(
                          'Thoát',
                          style: AppStyle.buttom,
                        ),
                      ),
                    )
                  ]),
                );
              }
          }
        },
      ),
    );
  }
}
