import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tneos_eduloution/network_utils/lives-api.dart';
import 'package:tneos_eduloution/network_utils/subscription.dart';
import 'package:tneos_eduloution/screen/packageview.dart';
import 'package:tneos_eduloution/screen/paidliveslist.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/widgets/drawer.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';

class PaidCourses extends StatefulWidget {
  @override
  _PaidCoursesState createState() => _PaidCoursesState();
}

class _PaidCoursesState extends State<PaidCourses> {
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
          currentPage: "Purchased Courses",
        ),
        appBar: Navbar(
          title: "My Courses",
        ),
        body: Container(
          child: FutureBuilder(
              future: fetchSubscription(userId),
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
                      title: Text(
                        'Buy a Course',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      description: Text(
                        // '${snapshot.error}',
                       'You have not purchased any course yet, Please buy a course first.',
                        textAlign: TextAlign.center,
                      ),
                      onOkButtonPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PackageView()));
                      },
                      buttonOkText: Text(
                        'Buy Now',
                        style: TextStyle(
                          color: ArgonColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                } else {
                  if (snapshot.hasData && snapshot.data.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        Subscriptions list = snapshot.data[index];
                        return Container(
                          padding: EdgeInsets.only(left: 12.0, right: 12.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: InkWell(
                                    onTap: () {
                                      // Call the paid live with category
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PaidLiveList(list.categoryId)));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(6.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          elevation: 4,
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 8.0, top:8.0, bottom: 8.0),
                                          child: Text(
                                            list.title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                            fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: ArgonColors.header,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
        ));
  }
}
