import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minor/Models/UserModel.dart';
import 'package:minor/screens/responsescreen/Response.dart';
import 'package:minor/utility/my_navigator.dart';

import 'Drawer/drawerScreen.dart';
import 'Profile.dart';
import 'configuration.dart';

class HomeScreenStack extends StatefulWidget {
  @override
  _HomeScreenStackState createState() => _HomeScreenStackState();
}

class _HomeScreenStackState extends State<HomeScreenStack> {
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    navbarmethod(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
            ),
            backgroundColor: Colors.grey[900],
            elevation: 10,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
              )
            ],
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(1)),
        child: Row(
          children: [
            buildNavBarItem(Icons.home, 0),
            buildNavBarItem(Icons.search, 1),
            buildNavBarItem(null, -1),
            StreamBuilder<QuerySnapshot>(
                stream: UserModel.firestore
                    .collection('users')
                    .doc(UserModel.firebaseAuth.currentUser.uid)
                    .collection('response')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int length = snapshot.data.docs.length;
                    return Stack(
                      children: <Widget>[
                        new IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {
                              Navigator.of(context).push(
                                  new MaterialPageRoute(builder: (contex) {
                                return new BadgeResponse();
                              }));
                            }),
                        Positioned(
                          right: 11,
                          top: 11,
                          child: new Container(
                            padding: EdgeInsets.all(2),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            ),
                            child: Text(
                              '$length',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (!snapshot.hasData || snapshot.hasError) {
                    return Container();
                  }
                }),
            buildNavBarItem(Icons.person, 3),
          ],
        ),
      ),
      body: Stack(
        // Here we have two screen Drawer and HomeScreen
        children: [DrawerScreen(), HomeScreen()],
      ),
    );
  }

  void navbarmethod(BuildContext context) {
    switch (_selectedItemIndex) {
      case 0:
        print('hello');
        break;
      case 1:
        Future.delayed(Duration.zero, () {
          MyNavigator.goToPageViaReplace(context, '/lookup');
        });
        break;
    }
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.height * 0.050,
        child: icon != null
            ? Icon(
                icon,
                size: 25,
                color: index == _selectedItemIndex
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
              )
            : Container(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  String city = 'New Delhi';
  @override
  Widget build(BuildContext context) {
    double medHeight = MediaQuery.of(context).size.height;
    return AnimatedContainer(
      curve: Curves.bounceOut,
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateZ(isDrawerOpen ? -0.1 : 0),
      duration: Duration(milliseconds: 100),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      padding: EdgeInsets.only(left: 10, right: 10, top: 0),
      //
      child: Container(
          height: medHeight,
          child: Column(
            children: [
              SizedBox(
                height: medHeight * 0.055,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isDrawerOpen
                        ? IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                scaleFactor = 1;
                                isDrawerOpen = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              setState(() {
                                xOffset = 230;
                                yOffset = 150;
                                scaleFactor = 0.8;
                                isDrawerOpen = true;
                              });
                            }),
                    Row(
                      children: [
                        Text('Location'),
                        SizedBox(width: 5),
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(city),
                      ],
                    ),
                    buildBuildBadgewidget(),
                  ],
                ),
              ),
              // from here
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 12),
                      height: medHeight * 0.07,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640"),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  child: Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                          buildStoryAvatar(
                              "https://images.pexels.com/photos/2169434/pexels-photo-2169434.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640"),
                          buildStoryAvatar(
                              "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640"),
                          buildStoryAvatar(
                              "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640"),
                          buildStoryAvatar(
                              "https://images.pexels.com/photos/2092474/pexels-photo-2092474.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640"),
                          buildStoryAvatar(
                              "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: medHeight * 0.71,
                      child: Column(
                        children: [
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: UserModel.firestore
                                    .collection('task')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final List<DocumentSnapshot> documents =
                                        snapshot.data.docs;
                                    return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.only(top: 8),
                                      itemCount: documents.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return buildPostSection(
                                          documents[index],
                                        );
                                      },
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget buildBuildBadgewidget() {
    return StreamBuilder<QuerySnapshot>(
        stream: UserModel.firestore
            .collection('users')
            .doc(UserModel.firebaseAuth.currentUser.uid)
            .collection('request')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int length = snapshot.data.docs.length;
            return Stack(
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      MyNavigator.goToPage(context, '/notification');
                    }),
                Positioned(
                  right: 11,
                  top: 11,
                  child: new Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '$length',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Container buildPostSection(DocumentSnapshot data) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPostPicture(data.data()['taskimage']),
          SizedBox(
            height: 25,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                data
                        .data()['groundHeroid']
                        .toString()
                        .contains(FirebaseAuth.instance.currentUser.uid)
                    ? buildPostFirstRow(
                        data.data()['groundHeroimage'],
                        UserModel.firebaseAuth.currentUser.displayName
                            .toString(),
                        "GroundHero")
                    : buildPostFirstRow(data.data()['profileimage'],
                        data.data()['Patronname'], "Patron"),
                SizedBox(
                  width: 15,
                ),
                data
                        .data()['groundHeroid']
                        .toString()
                        .contains(FirebaseAuth.instance.currentUser.uid)
                    ? buildPostFirstRow(data.data()['profileimage'],
                        data.data()['Patronname'], "Patron")
                    : buildPostFirstRow(data.data()['groundHeroimage'],
                        data.data()['groundHeroname'], "GroundHero"),
                SizedBox(
                  width: 15,
                ),
                builddataRow('Feeded', data.data()['animalfeeded'].toString()),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row builddataRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Overpass',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Row buildPostFirstRow(String urlProfilePhoto, String name, String type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProfilePage(url: urlProfilePhoto)));
              },
              child: CircleAvatar(
                radius: 10,
                backgroundImage: NetworkImage(urlProfilePhoto),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Overpass',
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  type,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Stack buildPostPicture(String urlPost) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width - 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(urlPost),
              )),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Icon(Icons.favorite,
              size: 35, color: Colors.white.withOpacity(0.7)),
        )
      ],
    );
  }

  Container buildStoryAvatar(String url) {
    return Container(
      margin: EdgeInsets.only(left: 18),
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.height * 0.07,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).primaryColor),
      child: CircleAvatar(
        radius: 18,
        backgroundImage: NetworkImage(url),
      ),
    );
  }

  Future<String> getUsername(String uid) async {
    DocumentSnapshot ds =
        await UserModel.firestore.collection('users').doc(uid).get();
    return ds.data()['username'].toString();
  }

  buildPostGroundRow(String uid) {
    FutureBuilder<DocumentSnapshot>(
        future: UserModel.firestore.collection('users').doc(uid).get(),
        builder: (BuildContext context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data.data()['username'],
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Overpass',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        snapshot.data.data()['roletype'],
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }
}
