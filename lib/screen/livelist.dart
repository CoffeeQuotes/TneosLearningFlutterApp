import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tneos_eduloution/network_utils/live.dart';
import 'package:tneos_eduloution/network_utils/lives-api.dart';
import 'package:tneos_eduloution/screen/paidcourses.dart';
import 'package:tneos_eduloution/screen/paidliveslist.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/widgets/card-small.dart';
import 'package:tneos_eduloution/widgets/drawer.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';

class LiveList extends StatefulWidget {
  @override
  _LiveListState createState() => _LiveListState();
}

class _LiveListState extends State<LiveList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: ArgonDrawer(currentPage: "liveslist",),
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: Navbar(
        title: "Live Classes",
        ),
      body: Container(
        child: FutureBuilder(
          future: fetchLives(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CardSmall(
                                    tap: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> Video(,list,),));
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PaidCourses()));
                                    },
                                    cta: "Watch Now",
                                    title: '${list.title}',
                                    liveclass: '${list.lifeClass.toString()}th class',
                                    board: '${list.board}',
                                    subject: '${list.subject}',
                                    img: 'https://tneos.in/storage/${list.image}',
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
            return Container(
                child: Center(
                    child: SpinKitHourGlass(
                      color: ArgonColors.info,
                      size: 72,
                    ),
                ),
            );
          },
        ),
      ),
    );
  }
}
