import 'dart:ui';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tneos_eduloution/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tneos_eduloution/screen/livelist.dart';
import 'package:tneos_eduloution/screen/register.dart';
import 'package:tneos_eduloution/styles/style.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        // color: Colors.teal,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/bg.png"),
              fit: BoxFit.cover,

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
                                  child: Text('Sign In Now', style: TextStyle(color: ArgonColors.white, fontSize: 20,),),
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
                                        _isLoading ? 'Proccessing...' : 'Login',
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
                                        _login();
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
                                  builder: (context) => Register()));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top:2.0, bottom: 2.0, left: 6, right: 6),
                          decoration: BoxDecoration(
                            color: ArgonColors.bgColorScreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Create new Account',
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

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': email, 'password': password};

    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => LiveList()),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
