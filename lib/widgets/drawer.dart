import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tneos_eduloution/network_utils/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/widgets/drawer-tile.dart';
class ArgonDrawer extends StatelessWidget {
  final String currentPage;

  ArgonDrawer({this.currentPage});

  _launchURL() async {
    const url = 'https://tneos.in';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          color: Colors.black87,
          child: Column(children: [
            Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.85,
                child: SafeArea(
                  bottom: false,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Image.asset("assets/img/sidebar-logo.png"),
                    ),
                  ),
                )),
            Expanded(
              flex: 2,
              child: ListView(
                padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                children: [
                  DrawerTile(
                      icon: FontAwesomeIcons.home, //Icons.home,
                      onTap: () {
                        if (currentPage != "Home")
                          Navigator.pushReplacementNamed(context, '/home');
                      },
                      iconColor: ArgonColors.primary,
                      title: "Home",
                      isSelected: currentPage == "Home" ? true : false),
                  SizedBox(height: 10,),
                  DrawerTile(
                      icon: FontAwesomeIcons.userCircle, //Icons.pie_chart,
                      onTap: () {
                        if (currentPage != "Profile")
                          Navigator.pushReplacementNamed(context, '/profile');
                      },
                      iconColor: ArgonColors.warning,
                      title: "Profile",
                      isSelected: currentPage == "Profile" ? true : false),
                  SizedBox(height: 10,),
                  DrawerTile(
                      icon: FontAwesomeIcons.boxes, //Icons.video_collection,
                      onTap: () {
                        if (currentPage != "Courses")
                          Navigator.pushReplacementNamed(context, '/packages');
                      },
                      iconColor: ArgonColors.info,
                      title: "Courses",
                      isSelected: currentPage == "Courses" ? true : false),
                  SizedBox(height: 10,),
                  DrawerTile(
                      icon: FontAwesomeIcons.video, //Icons.ondemand_video_rounded,
                      onTap: () {
                        if (currentPage != "liveslist")
                          Navigator.pushReplacementNamed(context, '/liveslist');
                      },
                      iconColor: ArgonColors.error,
                      title: "Live Classes",
                      isSelected: currentPage == "liveslist" ? true : false),
                  SizedBox(height: 10,),
                  DrawerTile(
                      icon: FontAwesomeIcons.signOutAlt,//Icons.logout,
                      onTap: () {
                          logout();
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      iconColor: ArgonColors.primary,
                      title: "Logout",
                      isSelected: false),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(left: 8, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                          height: 4, thickness: 0, color: ArgonColors.muted),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                        child: Text("Tneos Eduloution",
                            style: TextStyle(
                              color: ArgonColors.white,//Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 15,
                            )),
                      ),
                      SizedBox(height: 10,),
                      DrawerTile(
                          icon: FontAwesomeIcons.connectdevelop, //Icons.web,
                          onTap: _launchURL,
                          iconColor: ArgonColors.muted,
                          title: "Visit Our Site",
                          isSelected:
                          currentPage == "Getting started" ? true : false),
                    ],
                  )),
            ),
          ]),
        ));
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
    }
  }
}