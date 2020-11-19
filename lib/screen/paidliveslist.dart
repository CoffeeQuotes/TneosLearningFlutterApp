import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tneos_eduloution/network_utils/live.dart';
import 'package:tneos_eduloution/network_utils/paidlive-api.dart';
import 'package:tneos_eduloution/screen/packageview.dart';
import 'package:tneos_eduloution/screen/videoinfo.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/widgets/card-small.dart';
import 'package:tneos_eduloution/widgets/drawer.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';

class PaidLiveList extends StatefulWidget {
  @override
  _PaidLiveListState createState() => _PaidLiveListState();
}

class _PaidLiveListState extends State<PaidLiveList> {
  int userId;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    if (user != null) {
      setState(() {
        userId = user['id'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ArgonDrawer(
        currentPage: "Paid Lives",
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: Navbar(
        title: "Your Live Classes",
      ),
      body: Container(
        child: FutureBuilder(
            future: fetchPaidLive(userId),
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
                  child: AssetGiffyDialog(
                    image: Image.asset('assets/img/buy.gif'),
                    title: Text('Buy a Course', style:
                      TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),),
                    description: Text('You have not purchased any course yet, Please buy a course first.',
                        textAlign: TextAlign.center,
                    ),
                    onOkButtonPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PackageView()));
                    },
                    buttonOkText: Text('Buy Now', style: TextStyle(
                      color: ArgonColors.white,
                      fontWeight: FontWeight.w600,
                    ),),
                  ),
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
                                        var str = list.embedCode;
                                        const start = 'src="';
                                        const end = '" frameborder';

                                        final startIndex = str.indexOf(start);
                                        final endIndex = str.indexOf(
                                            end, startIndex + start.length);

                                        String embed = str.substring(
                                            startIndex + start.length,
                                            endIndex);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => VideoInfo(
                                                  userId,
                                                  list.title,
                                                  list.lifeClass.toString(),
                                                  list.subject,
                                                  list.board,
                                                  embed,
                                                  list.metaDescription),
                                            ));
                                      },
                                      cta: "Watch Now",
                                      title: '${list.title}',
                                      liveclass:
                                          '${list.lifeClass.toString()}th class',
                                      board: '${list.board}',
                                      subject: '${list.subject}',
                                      img:
                                          'http://10.0.2.2:8000/storage/${list.image}',
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
                } else {
                  //Todo:: Add Sweet Alert Here With Option such as buy now
                  return Container(
                    child: Center(
                      child: Text("You've Not Purchased any Course yet!"),
                    ),
                  );
                }
              }
            }),
      ),
    );
  }
}
