import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ext_video_player/ext_video_player.dart';
import 'package:tneos_eduloution/styles/style.dart';

class Video extends StatefulWidget {
  final String title;
  final int userId;
  final String videoClass;
  final String subject;
  final String board;
  final String embed;
  final String metaDesc;
  Video(this.userId, this.title, this.videoClass, this.subject, this.board,
      this.embed, this.metaDesc);
  @override
  _VideoState createState() => _VideoState(this.userId, this.title,
      this.videoClass, this.subject, this.board, this.embed, this.metaDesc);
}

class _VideoState extends State<Video> {
  int userId;
  String title;
  String videoClass;
  String subject;
  String board;
  String embed;
  String metaDesc;
  _VideoState(this.userId, this.title, this.videoClass, this.subject,
      this.board, this.embed, this.metaDesc);

  VideoPlayerController _controller;
  @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.network(embed)
  //     ..initialize().then((_) {
  //       setState(() {});
  //     });
  // }
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      embed,
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
          ),
          Container(
            child: RotatedBox(
              quarterTurns: 1,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(_controller),
                    _PlayPauseOverlay(
                      controller: _controller,
                      title: title,
                      subject: subject,
                      board: board,
                      videoClass: videoClass,
                    ),
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: ArgonColors.warning,
                        bufferedColor: ArgonColors.primary,
                        backgroundColor: ArgonColors.bgColorScreen,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: RotatedBox(
  //
  //         quarterTurns: 1,
  //         child: SizedBox.expand(
  //             child: _controller.value.initialized
  //                 ? FittedBox(
  //                     fit: BoxFit.contain,
  //                     //   ? AspectRatio(
  //                     // aspectRatio: _controller.value.aspectRatio,
  //                     child: SizedBox(
  //                       width: _controller.value.aspectRatio,
  //                       height: 1,
  //                       child: Stack(
  //                           alignment: Alignment.bottomCenter,
  //                           children: [
  //                             VideoPlayer(_controller),
  //                             VideoProgressIndicator(
  //                               _controller,
  //                               allowScrubbing: true,
  //                             ),
  //
  //                             GestureDetector(
  //                               onTap: () {
  //                                 setState(() {
  //                                   _controller.value.isPlaying
  //                                       ? _controller.pause()
  //                                       : _controller.play();
  //                                 });
  //                               }
  //                             ),
  //                           ]
  //                       ),
  //                     ),
  //                   )
  //
  //                 : Container(
  //                   color: Colors.black26,
  //                   child: Center(
  //                   child: Icon(
  //                   Icons.play_arrow,
  //                   color: Colors.white,
  //                   size: 100.0,
  //                 ),
  //               ),
  //             ))),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         setState(() {
  //           _controller.value.isPlaying
  //               ? _controller.pause()
  //               : _controller.play();
  //         });
  //       },
  //       child: Icon(
  //         _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
  //       ),
  //     ),
  //   );
  // }

}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay(
      {Key key,
      this.controller,
      this.title,
      this.videoClass,
      this.subject,
      this.board})
      : super(key: key);

  final VideoPlayerController controller;
  final String title;
  final String videoClass;
  final String subject;
  final String board;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black54,
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              title,
                              style: TextStyle(
                                color: ArgonColors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none,
                                fontFamily: 'Opensans',
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(6.0, 4.0),
                                    blurRadius: 16.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  Shadow(
                                    offset: Offset(4.0, 6.0),
                                    blurRadius: 18.0,
                                    color: Color.fromARGB(0, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 100.0,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                board,
                                style: TextStyle(
                                  color: ArgonColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Opensans',
                                  backgroundColor: ArgonColors.warning,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                subject,
                                style: TextStyle(
                                  color: ArgonColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Opensans',
                                  backgroundColor: ArgonColors.success,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                videoClass + "th class",
                                style: TextStyle(
                                  color: ArgonColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Opensans',
                                  backgroundColor: ArgonColors.primary,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}
