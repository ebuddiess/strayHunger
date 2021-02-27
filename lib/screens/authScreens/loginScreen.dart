import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minor/Models/UserModel.dart';
import 'package:minor/utility/color_manager.dart';
import 'package:minor/utility/my_navigator.dart';
import 'package:minor/widgets/customTextField.dart';

class Loginscreen extends StatelessWidget {
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: MediaQuery.of(context).size.height * 0.210,
                  child: Image.asset(
                    'assets/signin.png',
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 40,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Sign in with your account',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.065,
                ),
                CustomTextField(
                  controller: emailcontroller,
                  issecured: false,
                  hint: '    Email',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  controller: passwordcontroller,
                  hint: '   Password',
                  issecured: true,
                ),
                SizedBox(
                  height: 20,
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
                      height: 55,
                      child: RaisedButton(
                        onPressed: () {
                          return validateuser()
                              ? buildSigninuser(context)
                              : scaffoldKey.currentState
                                  .showBottomSheet((context) {
                                  return buildDisplayModelSheet(context);
                                });
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
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
                  height: MediaQuery.of(context).size.height * 0.025,
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
      padding: EdgeInsets.all(10),
      height: 80,
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
    User.firebaseAuth
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
