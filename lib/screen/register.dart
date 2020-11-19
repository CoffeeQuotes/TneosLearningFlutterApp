import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tneos_eduloution/styles/style.dart';
import 'package:tneos_eduloution/network_utils/api.dart';
import 'package:tneos_eduloution/screen/home.dart';
import 'package:tneos_eduloution/screen/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var name;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/register-bg.png"),
              fit: BoxFit.cover
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 4.0,
                      color: Colors.transparent,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(

                        decoration: BoxDecoration(
   
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xFF00c2cb).withOpacity(0.5),
                                  Color(0xFF5e17eb).withOpacity(0.5)
                                ]
                            ),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Sign Up Now', style: TextStyle(color: ArgonColors.white, fontSize: 20,),),
                                ),
                                TextFormField(
                                  style: TextStyle(color: ArgonColors.white),
                                  cursorColor: Color(0xFF9b9b9b),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.mailBulk,
                                      color: ArgonColors.white,
                                    ),
                                    hintText: "Email",
                                    hintStyle:  TextStyle(
                                        color: ArgonColors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: ArgonColors.muted),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: ArgonColors.white),
                                      ),
                                    errorStyle: TextStyle(
                                      color: ArgonColors.inputError,
                                    ),
                                  ),
                                  validator: (emailValue) {
                                    if (emailValue.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    email = emailValue;
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  style: TextStyle(color: ArgonColors.white),
                                  cursorColor: Color(0xFF9b9b9b),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.user,
                                      color: ArgonColors.white,
                                    ),
                                    hintText: "Name",
                                    hintStyle: TextStyle(
                                        color: ArgonColors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ArgonColors.muted),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ArgonColors.white),
                                    ),

                                    errorStyle: TextStyle(
                                      color: ArgonColors.inputError,
                                    ),
                                  ),
                                  validator: (nameValue) {
                                    if (nameValue.isEmpty) {
                                      return 'Please enter your first name';
                                    }
                                    name = nameValue;
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  style: TextStyle(color: ArgonColors.white),
                                  cursorColor: Color(0xFF9b9b9b),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.key,
                                      color: ArgonColors.white,
                                    ),
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: ArgonColors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ArgonColors.muted),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: ArgonColors.white),
                                    ),

                                    errorStyle: TextStyle(
                                      color: ArgonColors.inputError,
                                    ),
                                  ),
                                  validator: (passwordValue) {
                                    if (passwordValue.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    password = passwordValue;
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FlatButton(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 8, bottom: 8, left: 10, right: 10),
                                      child: Text(
                                        _isLoading ? 'Processing...' : 'Register',
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    color: ArgonColors.label,
                                    disabledColor: Colors.grey,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(20.0)),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _register();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top:2.0, bottom: 2.0, left: 6, right: 6),
                          decoration: BoxDecoration(
                            color: ArgonColors.bgColorScreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Already Have an Account',
                            style: TextStyle(
                              color: ArgonColors.label,
                              fontSize: 15.0,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email': email,
      'password': password,
      'name': name,
    };

    var res = await Network().authData(data, '/register');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Home()
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}