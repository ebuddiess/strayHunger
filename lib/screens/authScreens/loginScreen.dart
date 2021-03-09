import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minor/Models/UserModel.dart';
import 'package:minor/utility/color_manager.dart';
import 'package:minor/utility/my_navigator.dart';
import 'package:minor/widgets/customTextField.dart';

class Loginscreen extends StatefulWidget {
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailcontroller = new TextEditingController();

  TextEditingController passwordcontroller = new TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool showbar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'), fit: BoxFit.cover),
            gradient: LinearGradient(colors: [
              Colors.purple,
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.34,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Image.asset(
                    'assets/signin.png',
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.09,
                    ),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: ColorManager.kTitleStyle.fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                  ],
                ),
                SizedBox(),
                Row(
                  children: <Widget>[
                    SizedBox(width: MediaQuery.of(context).size.width * 0.09),
                    Text(
                      'Sign in with your account',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                CustomTextField(
                  controller: emailcontroller,
                  issecured: false,
                  hint: '    Email',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                CustomTextField(
                  controller: passwordcontroller,
                  hint: '   Password',
                  issecured: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: ButtonTheme(
                      buttonColor: Colors.white,
                      minWidth: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            showbar = true;
                          });
                          return validateuser()
                              ? buildSigninuser(context)
                              : scaffoldKey.currentState
                                  .showBottomSheet((context) {
                                  return buildDisplayModelSheet(context);
                                });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Log in',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: showbar
                                  ? CircularProgressIndicator()
                                  : Container(),
                            ),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'OR',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(image: AssetImage('assets/google.png'))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't Have an Account ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        MyNavigator.goToPage(context, '/signup');
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDisplayModelSheet(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.all(10),
      color: Colors.white, //could change this to Color(0xFF737373),
      //so you don't have to change MaterialApp canvasColor
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email Must be Valid',
                style: TextStyle(fontFamily: 'Overpass'),
              ),
              Text(
                'Password length must be greater than 5',
                style: TextStyle(fontFamily: 'Overpass'),
              ),
            ],
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                showbar = false;
              });
              Navigator.pop(context);
            },
            child: Text(
              'Close',
            ),
            color: Colors.black,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }

  bool validateuser() {
    String password = passwordcontroller.text;
    String email = emailcontroller.text;
    bool verified = false;
    if ((email != '') & (password != '')) {
      verified = true;
    }
    return verified;
  }

  buildSigninuser(context) {
    String password = passwordcontroller.text;
    String email = emailcontroller.text;
    bool registered = false;
    UserModel.firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((onError) {
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(onError.message),
            ),
          );
        })
        .then((authResult) => {
              if (authResult != null)
                {
                  registered = true,
                }
            })
        .whenComplete(() {
          if (registered) {
            MyNavigator.goToPage(context, '/homescreen');
          }
        });
  }
}
