import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:tneos_eduloution/network_utils/live.dart';
import 'package:tneos_eduloution/network_utils/lives-api.dart';
import 'package:tneos_eduloution/screen/paidcourses.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/widgets/card-small.dart';
import 'package:tneos_eduloution/widgets/drawer.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';
import 'package:url_launcher/url_launcher.dart';

class BoardLive extends StatefulWidget {
  final String board;
  BoardLive(this.board);

  @override
  _BoardLiveState createState() => _BoardLiveState(this.board);
}

class _BoardLiveState extends State<BoardLive> {
  String board;
  _BoardLiveState(this.board);

  _launchURL() async {
    const url = 'tel:+918800978784';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ArgonDrawer(
        currentPage: "Board Live List",
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: Navbar(
        title: "$board Classes",
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchBoardLives(board),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: SpinKitHourGlass(
                    color: ArgonColors.info,
                    size: 72,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("ERROR: ${snapshot.error}"),
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    Lives list = snapshot.data[index];
                    return Container(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CardSmall(
                                    tap: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> Video(,list,),));
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaidCourses()));
                                    },
                                    cta: "Watch Now",
                                    title: '${list.title}',
                                    liveclass:
                                        '${list.lifeClass.toString()}th class',
                                    board: '${list.board}',
                                    subject: '${list.subject}',
                                    img:
                                        'https://tneos.in/storage/${list.image}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              else {
                return Center(
                  child: Container(
                      padding: const EdgeInsets.all(16.0),
                      color: ArgonColors.header,
                      child: AssetGiffyDialog(
                        image: Image.asset('assets/img/live.gif'),
                        title: Text('No Content Found', style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                        description: Text('This course videos are not available yet, Kindly contact us if you have any question.', textAlign: TextAlign.center, style: TextStyle(
                          color: Color(0xff808080),
                        ),),
                        buttonOkText: Text('Call Now', style: TextStyle(
                          color: ArgonColors.white,
                          fontWeight: FontWeight.w600,
                        ),),
                        onOkButtonPressed: () {
                          _launchURL();
                        },
                        buttonOkColor: ArgonColors.success,
                        buttonCancelText: Text('Go Back', style: TextStyle(
                          color:  ArgonColors.white,
                        ),),
                      )
                  ));

              }
            }
          },
        ),
      ),
    );
  }
}
