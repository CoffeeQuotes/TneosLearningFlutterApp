import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tneos_eduloution/network_utils/package.dart';
import 'package:tneos_eduloution/network_utils/packages-api.dart';
import 'package:tneos_eduloution/screen/payment.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/widgets/drawer.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';

class PackagesList extends StatefulWidget {
  @override
  _PackagesListState createState() => _PackagesListState();
}

class _PackagesListState extends State<PackagesList> {
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
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: 'Courses',),
      appBar: Navbar(
        title: "Our Courses",
        transparent: false,
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchPackages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    Packages list = snapshot.data[index];
                    // ignore: missing_return
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: ArgonColors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                              imageUrl: 'http://10.0.2.2:8000/storage/' + '${list.image}',
                              placeholder: (context, url) => Center(child: SpinKitCubeGrid(color: ArgonColors.inputError,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Text(
                                  '${list.name}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: ArgonColors.header,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex:1,
                                    child: Container(
                                      alignment: Alignment.center,
                                       decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff24C6DC),//brandColorPrimary,
                                  Color(0xff514A9D),//brandColorPrimary2
                                ]
                              )
                            ),
                            padding: const EdgeInsets.only(left:8.0,right: 8.0),
                                      child: Text(
                                        '${list.packageClass}th Class',
                                        style: TextStyle(
                                          color: ArgonColors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.center,
                                       decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff24C6DC),//brandColorPrimary,
                                  Color(0xff514A9D),//brandColorPrimary2
                                ]
                              )
                            ),
                            padding: const EdgeInsets.only(left:8.0,right: 8.0),
                                      child: Text(
                                        '${list.board.toString()}',
                                        style: TextStyle(
                                          color: ArgonColors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.center,
                                       decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff24C6DC),//brandColorPrimary,
                                  Color(0xff514A9D),//brandColorPrimary2
                                ]
                              )
                            ),
                            padding: const EdgeInsets.only(left:8.0,right: 8.0),
                                      child: Text(
                                        '${list.subject}',
                                        style: TextStyle(
                                          color: ArgonColors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text('₹ ${list.amount} /- Only', style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ArgonColors.label,
                              ),),
                              RaisedButton(
                                  child: Text('Buy Course',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      letterSpacing: 1,
                                      color: ArgonColors.white,
                                    ),
                                  ),
                                  color: ArgonColors.info,
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Payment(list.amount, list.id, userId, list.name, list.image, list.packageClass, list.subject, list.board)));
                              })
                            ],
                          ),
                        ),
                      ),
                    );

                  }
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
