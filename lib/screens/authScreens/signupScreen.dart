import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minor/utility/my_navigator.dart';
import 'package:minor/widgets/customTextField.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final user = FirebaseFirestore.instance.collection('users');

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
              Theme.of(context).primaryColor,
              Colors.purple,
              Theme.of(context).accentColor,
              Colors.blue,
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
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
                    'assets/signup.png',
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Create Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CustomTextField(
                  controller: emailcontroller,
                  errortext: 'Enter a proper email',
                  hint: '    enter email',
                  issecured: false,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  errortext: 'Enter name',
                  controller: namecontroller,
                  hint: '    enter name',
                  issecured: false,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CustomTextField(
                  controller: passwordcontroller,
                  errortext: 'choose a strong password',
                  hint: '    choose a strong Password',
                  issecured: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
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
                              ? registeruser(context)
                              : scaffoldKey.currentState
                                  .showBottomSheet((context) {
                                  return buildDisplayModelSheet(context);
                                });
                        },
                        child: Text(
                          'Create',
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      )),
                ),
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
        crossAxisAlignment: CrossAxisAlignment.end,
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
              Text(
                'Name length should be greater than 3',
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
    String name = namecontroller.text;
    String password = passwordcontroller.text;
    String email = emailcontroller.text;
    bool verified = false;
    if ((name != '') & (email != '') & (password != '')) {
      if ((password.length > 5) & (email.contains("@")) & (name.length > 3)) {
        verified = true;
      }
    }
    return verified;
  }

  registeruser(context) {
    String name = namecontroller.text;
    String password = passwordcontroller.text;
    String email = emailcontroller.text;
    bool registered = false;
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
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
                  user.doc(authResult.user.uid).set({
                    'userid': authResult.user.uid,
                    'username': name,
                    'email': email,
                    'roletype': 'Ground Buddy',
                    'status': 'Online',
                    'address': '',
                    'city': '',
                    'phone': '',
                    'pin': '',
                    'acceptCount': 0,
                    'rejectCount': 0,
                    'completedtask': 0,
                    'totalrequest': 0,
                    'totaltask': 0
                  }),
                  //user.add(data),
                  registered = true,
                  scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text('Registered Successfully'),
                    ),
                  )
                }
            })
        .whenComplete(() {
          if (registered) {
            MyNavigator.goToPage(context, '/homescreen');
          }
        });
  }
}
