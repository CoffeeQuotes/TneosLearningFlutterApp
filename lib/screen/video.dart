
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
                    _controller.value.isPlaying? SizedBox.shrink() : VideoProgressIndicator(
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
  // static const _playbackRates = [
  //   0.25,
  //   0.5,
  //   1.0,
  //   2.0
  // ];
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
                            child: Text(
                              title,
                              style: TextStyle(
                                color: ArgonColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
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
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ArgonColors.black.withOpacity(0.5),
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 60.0,
                            ),
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: PopupMenuButton<double>(
                        //     initialValue: controller.value.playbackSpeed,
                        //     tooltip: 'Playback speed',
                        //     onSelected: (speed) {
                        //       controller.setPlaybackSpeed(speed);
                        //     },
                        //     itemBuilder: (context) {
                        //       return [
                        //         for (final speed in _playbackRates)
                        //           PopupMenuItem(
                        //             value: speed,
                        //             child: Text('${speed}x'),
                        //           )
                        //       ];
                        //     },
                        //   ),
                        // ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ArgonColors.warning,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  board,
                                  style: TextStyle(
                                    color: ArgonColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Opensans',
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ArgonColors.success,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  subject,
                                  style: TextStyle(
                                    color: ArgonColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Opensans',
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ArgonColors.primary,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  videoClass + "th class",
                                  style: TextStyle(
                                    color: ArgonColors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Opensans',
                                    letterSpacing: 1,
                                  ),
                                ),
                              )
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
