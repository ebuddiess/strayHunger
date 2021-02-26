import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minor/utility/my_navigator.dart';

import '../configuration.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
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
              CircleAvatar(
                child: Icon(FontAwesomeIcons.userCheck),
                radius: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Puneet Pandey',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Overpass'),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      ),
                      SizedBox(width: 5),
                      Text('Online',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
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
                  print('logout');
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
}
