import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tneos_eduloution/styles/style.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/onboarding.png"),
                      fit: BoxFit.cover))),
          Padding(
            padding:
                const EdgeInsets.only(top: 73, left: 32, right: 32, bottom: 16),
            child: Container(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/img/onbaordlogo.png', scale: 1),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 48.0),
                          child: Text.rich(TextSpan(
                            text: "Online Education",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24.0),
                          child: Text(
                              'Online Courses, Amazing Teachers, Great Support',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200)),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          textColor: ArgonColors.text,
                          color: ArgonColors.text,
                          onPressed: () {
                            Navigator.pushReplacementNamed(context,  '/checkauth');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                              child: Text('GET STARTED',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: ArgonColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
