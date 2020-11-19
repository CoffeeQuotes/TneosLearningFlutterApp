import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tneos_eduloution/network_utils/profile-api.dart';
import 'package:tneos_eduloution/screen/home.dart';
import 'package:tneos_eduloution/screen/paidliveslist.dart';
import 'package:tneos_eduloution/screen/viewer.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/widgets/drawer.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';
import 'package:tneos_eduloution/network_utils/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State < ProfilePage > {
  String name;
  int userId;
  String email;
  String avatar;

  @override
  void initState() {
    _loadUserData();
    super.initState();
    fetchProfile(userId);
  }
  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    if (user != null) {
      setState(() {
        name = user['name'];
        userId = user['id'];
        avatar = user['avatar'];
      });
    }
  }
  _launchURL() async {
    const url = 'https://tneos.in/login';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "Profile",
        transparent: true,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Profile"),
      body: Container(
        child: FutureBuilder(
          future: fetchProfile(userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Profile userProfile = snapshot.data;
              return Stack(
                children: [
                  Container(
              decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage("assets/img/stencil.jpg"),
                  fit: BoxFit.fitWidth))),

                  SafeArea(
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 74.0, ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ]
                                    ),
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 85.0, bottom: 20.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: ArgonColors.info,
                                                            borderRadius:
                                                            BorderRadius.circular(3.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey
                                                                    .withOpacity(0.3),
                                                                spreadRadius: 1,
                                                                blurRadius: 7,
                                                                offset: Offset(0,
                                                                    3), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          child: Text(
                                                            "Home",
                                                            style: TextStyle(
                                                                color: ArgonColors.white,
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: 8.0,
                                                              vertical: 8.0),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: ArgonColors.initial,
                                                          borderRadius:
                                                          BorderRadius.circular(3.0),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 7,
                                                              offset: Offset(0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PaidLiveList()));
                                                          },
                                                          child: Text(
                                                            "Your Lives",
                                                            style: TextStyle(
                                                                color: ArgonColors.white,
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                        ),
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                            vertical: 8.0),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 40.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(userProfile.profileClass +'th',
                                                              style: TextStyle(
                                                                  color: Color.fromRGBO(
                                                                      82, 95, 127, 1),
                                                                  fontSize: 20.0,
                                                                  fontWeight:
                                                                  FontWeight.bold)),
                                                          Text("Class",
                                                              style: TextStyle(
                                                                  color: Color.fromRGBO(
                                                                      50, 50, 93, 1),
                                                                  fontSize: 12.0))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 40.0),
                                                  Align(
                                                    child: Text(userProfile.firstname + " " + userProfile.lastname,
                                                        style: TextStyle(
                                                            color: Color.fromRGBO(
                                                                50, 50, 93, 1),
                                                            fontSize: 28.0)),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Align(
                                                    child: Text(userProfile.schoolName,
                                                        style: TextStyle(
                                                            color: Color.fromRGBO(
                                                                50, 50, 93, 1),
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.w600)),
                                                  ),
                                                  Divider(
                                                    height: 40.0,
                                                    thickness: 1.5,
                                                    indent: 32.0,
                                                    endIndent: 32.0,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Text(
                                                          'Student at Tneos Eduloutions, Since ' + userProfile.createdAt.day.toString() + ", " + userProfile.createdAt.month.toString() + ", " + userProfile.createdAt.year.toString()+".",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Color.fromRGBO(
                                                                  82, 95, 127, 1),
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                              FontWeight.w600)),
                                                    ),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                  SizedBox(height: 25.0),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  FractionalTranslation(
                                      translation: Offset(0.0, -0.5),
                                      child: Align(
                                        child: GestureDetector(
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage('http://10.0.2.2:8000/'+ userProfile.image),
                                            radius: 65.0,
                                            // maxRadius: 200.0,
                                          ),
                                        onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Viewer(userProfile.image),));
                                        },
                                        ),
                                        alignment: FractionalOffset(0.5, 0.0),
                                      ))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
              //Text(userProfile.firstname, style: TextStyle(fontSize: 24),)

                  ;
            }
            else if(snapshot.hasError) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                color: ArgonColors.header,
                child: AssetGiffyDialog(
                  image: Image.asset('assets/img/profile.gif'),
                  title: Text('Profile Not Completed', style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    ),
                  ),
                  description: Text('Your profile is not complete, Kindly visit our website and Complete your profile.', textAlign: TextAlign.center,),
                  buttonOkText: Text('Visit Now', style: TextStyle(
                    color: ArgonColors.white,
                    fontWeight: FontWeight.w600,
                  ),),
                  onOkButtonPressed: () {
                    _launchURL();
                  },
                  buttonOkColor: ArgonColors.success,
                  buttonCancelText: Text('Go Back'),
                )
              );
            }
            return Container(
              color: ArgonColors.header,
              child: Center(
                  child: SpinKitHourGlass(color: ArgonColors.info, size: 72,)
              ),
            );
          },
        ),
      ),
    );

  }
}
