import 'package:flutter/material.dart';
import 'package:tneos_eduloution/screen/livelist.dart';
import 'package:tneos_eduloution/screen/login.dart';
import 'package:tneos_eduloution/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tneos_eduloution/screen/onboarding.dart';
import 'package:tneos_eduloution/screen/packageslist.dart';
import 'package:tneos_eduloution/screen/profilepage.dart';
import 'package:tneos_eduloution/screen/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tneos Eduloution',
      theme: ThemeData(fontFamily: 'OpenSans'),
      initialRoute: "/onboarding",
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => CheckAuth(),
        "/onboarding": (BuildContext context) => new Onboarding(),
        "/checkauth": (BuildContext context) => CheckAuth(),
        "/packages": (BuildContext context) => PackagesList(),
        "/profile": (BuildContext context) => ProfilePage(),
        "/liveslist": (BuildContext context) => LiveList(),
        "/login": (BuildContext context) => Login(),
        "/home": (BuildContext context) => Home(),
        // "/paidLive" : (BuildContext context) => PaidLiveList()
      },
      // home: CheckAuth(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = LiveList();
    } else {
      child = Register();
    }
    return Scaffold(
      body: child,
    );
  }
}
