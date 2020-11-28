import 'package:flutter/material.dart';
import 'package:ext_video_player/ext_video_player.dart';
import 'package:tneos_eduloution/screen/video.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/widgets/drawer.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';

class VideoInfo extends StatefulWidget {
  final String title;
  final int userId;
  final String videoClass;
  final String subject;
  final String board;
  final String embed;
  final String metaDesc;
  VideoInfo(this.userId, this.title, this.videoClass, this.subject, this.board,
      this.embed, this.metaDesc);
  @override
  VideoInfoState createState() => VideoInfoState(this.userId, this.title,
      this.videoClass, this.subject, this.board, this.embed, this.metaDesc);
}

class VideoInfoState extends State<VideoInfo> {
  int userId;
  String title;
  String videoClass;
  String subject;
  String board;
  String embed;
  String metaDesc;
  VideoInfoState(this.userId, this.title, this.videoClass, this.subject,
      this.board, this.embed, this.metaDesc);
  VideoPlayerController _controller;

  @override
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
    return Scaffold(
      appBar: Navbar(
        title: board + " " + videoClass + " " + subject,
      ),
      drawer: ArgonDrawer(
        currentPage: "Video Info",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(padding: const EdgeInsets.only(top: 1.0)),
              Container(
                padding: const EdgeInsets.all(2),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(_controller),
                      _PlayPauseOverlay(controller: _controller),
                      VideoProgressIndicator(_controller, allowScrubbing: true),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: ArgonColors.header,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  metaDesc,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton.icon(
                      padding: EdgeInsets.all(6.0),
                      label: Text(
                        'Go Back'.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: ArgonColors.white),
                      ),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: ArgonColors.white,
                      ),
                      splashColor: ArgonColors.warning,
                      color: ArgonColors.primary,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton.icon(
                      padding: EdgeInsets.all(6.0),
                      label: Text(
                        'Fullscreen'.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: ArgonColors.white),
                      ),
                      icon: Icon(
                        Icons.fullscreen,
                        color: ArgonColors.white,
                      ),
                      splashColor: ArgonColors.warning,
                      color: ArgonColors.primary,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Video(userId, title,
                                  videoClass, subject, board, embed, metaDesc),
                            ));
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "About the Video",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ArgonColors.label,
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'This video is about $title, It is for $board board, class ${videoClass}th students, the subject taught here is $subject . All right reserved to Tneos Limited.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff808080),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

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
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
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
