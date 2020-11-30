import 'dart:convert';
import 'package:email_validator/email_validator.dart';
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
    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:30.0),
                    child: Text('Tneos Eduloutions',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff042fbb),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Image.asset('assets/img/register.png'),
                  ),
                  Stack(
                    children: <Widget>[
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(

                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Sign Up Now', style: TextStyle(color: Color(0xff042fbb), fontSize: 20, fontWeight: FontWeight.w600),),
                                        ),
                                        TextFormField(
                                          style: TextStyle(color: Color(0xff042fbb)),
                                          cursorColor: Color(0xFF9b9b9b),
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              FontAwesomeIcons.mailBulk,
                                              color: Color(0xff042fbb),
                                            ),
                                            hintText: "Email",
                                            hintStyle:  TextStyle(
                                                color: Color(0xff042fbb),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: ArgonColors.muted),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xff042fbb)),
                                              ),
                                            errorStyle: TextStyle(
                                              color: ArgonColors.inputError,
                                            ),
                                          ),
                                          validator: (emailValue) {
                                            if (emailValue.isEmpty) {
                                              return 'Please enter email';
                                            }
                                            if(!EmailValidator.validate(emailValue)) {
                                              return 'Email is not valid';
                                            }
                                            email = emailValue;
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          style: TextStyle(color: Color(0xff042fbb)),
                                          cursorColor: Color(0xFF9b9b9b),
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              FontAwesomeIcons.user,
                                              color: Color(0xff042fbb),
                                            ),
                                            hintText: "Name",
                                            hintStyle: TextStyle(
                                                color: Color(0xff042fbb),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: ArgonColors.muted),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xff042fbb)),
                                            ),

                                            errorStyle: TextStyle(
                                              color: ArgonColors.inputError,
                                            ),
                                          ),
                                          validator: (nameValue) {
                                            if (nameValue.isEmpty) {
                                              return 'Please enter your first name';
                                            }
                                            if (nameValue.length < 2) {
                                              return  'Name not long enough';
                                            }
                                            name = nameValue;
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          style: TextStyle(color: Color(0xff042fbb)),
                                          cursorColor: Color(0xFF9b9b9b),
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              FontAwesomeIcons.key,
                                              color: Color(0xff042fbb),
                                            ),
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: Color(0xff042fbb),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: ArgonColors.muted),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xff042fbb)),
                                            ),

                                            errorStyle: TextStyle(
                                              color: ArgonColors.inputError,
                                            ),
                                          ),
                                          validator: (passwordValue) {
                                            if (passwordValue.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            if (passwordValue.length < 8) {
                                              return 'Your Password is too short';
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
                                            color: Color(0xff042fbb),
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
                                        color: Color(0xff042fbb),
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
                ],
              ),
            ),
          ),
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
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (context) => Home()
        ),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}