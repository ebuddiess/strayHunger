import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minor/Models/UserModel.dart';
import 'package:minor/utility/my_navigator.dart';

import '../configuration.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isSwitched = true;
  var textValue = 'Online';

  @override
  Widget build(BuildContext context) {
    double medheight = MediaQuery.of(context).size.height;
    return Container(
      height: medheight,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.purpleAccent[700],
          Theme.of(context).primaryColor,
          Theme.of(context).accentColor,
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      padding: EdgeInsets.only(
          top: medheight * 0.07,
          bottom: medheight * 0.05,
          left: medheight * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: UserModel.firestore
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data()['profileimage'] != null) {
                        return CircleAvatar(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: Image.network(
                              snapshot.data.data()['profileimage'],
                              fit: BoxFit.cover,
                            ).image,
                          ),
                          radius: 40,
                        );
                      } else {
                        return CircleAvatar(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: Image.asset(
                              'assets/cat.png',
                              fit: BoxFit.cover,
                            ).image,
                          ),
                          radius: 40,
                        );
                      }
                    } else {
                      return Container();
                    }
                  }),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    UserModel.firebaseAuth.currentUser.displayName == null
                        ? 'Hi User'
                        : UserModel.firebaseAuth.currentUser.displayName
                            .toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Overpass'),
                  ),
                  Row(
                    children: [
                      Switch(
                        onChanged: toggleSwitch,
                        value: isSwitched,
                        activeColor: Colors.greenAccent,
                        activeTrackColor: Colors.lightGreen,
                        inactiveThumbColor: Colors.redAccent,
                        inactiveTrackColor: Colors.purple,
                      ),
                      Text(textValue, style: TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              )
            ],
          ),
          Column(
            children: drawerItems
                .map((element) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              OutlineButton(
                                borderSide: BorderSide.none,
                                onPressed: () {
                                  MyNavigator.goToPage(context, element['url']);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      element['icon'],
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: medheight * 0.02,
                                    ),
                                    Text(element['title'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Overpass',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
          Row(
            children: [
              OutlineButton(
                borderSide: BorderSide.none,
                onPressed: () {
                  print('settings');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: medheight * 0.010,
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              OutlineButton(
                borderSide: BorderSide.none,
                onPressed: () {
                  UserModel.firebaseAuth
                      .signOut()
                      .whenComplete(() => print("logout"));
                  MyNavigator.goToPage(context, '/login');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Log out',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Online';
        UserModel.firestore
            .collection('UserModels')
            .doc(UserModel.firebaseAuth.currentUser.uid)
            .update({'status': textValue});
      });
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Offline';
        UserModel.firestore
            .collection('UserModels')
            .doc(UserModel.firebaseAuth.currentUser.uid)
            .update({'status': textValue});
      });
    }
  }
}
