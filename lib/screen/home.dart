import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tneos_eduloution/network_utils/api.dart';
import 'package:tneos_eduloution/screen/boardlist.dart';
import 'package:tneos_eduloution/screen/paidliveslist.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/screen/login.dart';
import 'package:tneos_eduloution/widgets/card-small.dart';
import 'package:tneos_eduloution/widgets/drawer.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';
import 'package:tneos_eduloution/network_utils/lives-api.dart';
import 'package:tneos_eduloution/network_utils/live.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name;
  final List<String> imgList = [
    'assets/img/1.jpg',
    'assets/img/2.jpg',
    'assets/img/3.jpg',
  ];
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
        name = user['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ArgonDrawer(
        currentPage: "Home",
      ),
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "Home",
        transparent: false,
        categoryOne: "/packages",
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(height: 220.0, autoPlay: true,),
                    items: imgList.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                  color: ArgonColors.border,
                                image: DecorationImage(
                                  image: AssetImage(i)
                                )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('BUY BEST COURSES NOW!', style: TextStyle(fontSize: 16.0, letterSpacing: 2, fontWeight: FontWeight.w600),),
                                  Text('New Courses with Expert Faculties', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                                ],
                              )
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 20, 0, 20),
                    child: Text(
                      'Hi, $name!',
                      style: TextStyle(
                          color: ArgonColors.primary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Welcome to Tneos, Enjoy Learning, and Never Stop Learning!',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                      ),),
                  ),
                  Row(
                    children: [

                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardLive("CBSE"),
                          ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/img/CBSE.jpg'),
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CBSE', style: TextStyle(
                                color: ArgonColors.header,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text('Browse our CBSE Classes', style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardLive("Bihar"),
                          ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/img/biharboardlogo.jpg'),
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('BIHAR BOARD', style: TextStyle(
                                color: ArgonColors.header,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text('Browse our BIHAR BOARD Classes', style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardLive("Odisha"),
                          ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/img/Bse.odisha.logo.jpg'),
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ODISHA', style: TextStyle(
                                color: ArgonColors.header,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text('Browse our ODISHA Board Classes', style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardLive("MP"),
                          ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/img/mpboard.jpg'),
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Madhya Pradesh', style: TextStyle(
                                color: ArgonColors.header,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text('Browse our Madhya Pradesh Classes', style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardLive("Rajsthan"),
                          ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/img/rajboard.jpg'),
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rajsthan Board', style: TextStyle(
                                color: ArgonColors.header,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text('Browse our Rajsthan Board Classes', style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardLive("UP"),
                          ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/img/up board.jpg'),
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Uttar Pradesh', style: TextStyle(
                                color: ArgonColors.header,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text('Browse our UP Board Classes', style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardLive("Jharkhand"),
                          ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/img/jharkhand board.jpg'),
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Jharkhand Board', style: TextStyle(
                                color: ArgonColors.header,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text('Browse our Jharkhand Board Classes', style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoardLive("Haryana"),
                          ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/img/Haryana-Board.jpg'),
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Haryana Board', style: TextStyle(
                                color: ArgonColors.header,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),),
                              Text('Browse our Haryana Classes', style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // Center(
                  //   child: RaisedButton(
                  //     elevation: 10,
                  //     onPressed: () {
                  //       logout();
                  //     },
                  //     color: Colors.teal,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.all(Radius.circular(10))),
                  //     child: Text('Logout'),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}
