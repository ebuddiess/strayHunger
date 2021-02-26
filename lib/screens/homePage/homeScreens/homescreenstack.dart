import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              print("hi");
            },
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
            buildNavBarItem(Icons.notifications, 2),
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
                        Text('Delhi'),
                      ],
                    ),
                    CircleAvatar(radius: 30)
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
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(top: 8),
                              children: [
                                buildPostSection(
                                    "https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=200&w=640",
                                    "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=940"),
                                buildPostSection(
                                    "https://images.pexels.com/photos/206359/pexels-photo-206359.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=200&w=940",
                                    "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640"),
                                buildPostSection(
                                    "https://images.pexels.com/photos/1212600/pexels-photo-1212600.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=200&w=1260",
                                    "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640"),
                              ],
                            ),
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

  Container buildPostSection(String urlPost, String urlProfilePhoto) {
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
          buildPostFirstRow(urlProfilePhoto),
          SizedBox(
            height: 10,
          ),
          buildPostPicture(urlPost),
          SizedBox(
            height: 25,
          ),
          Text(
            "963 likes",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Row buildPostFirstRow(String urlProfilePhoto) {
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
              child: Hero(
                tag: urlProfilePhoto,
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(urlProfilePhoto),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tom Smith",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Iceland",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500]),
                ),
              ],
            )
          ],
        ),
        Icon(Icons.more_vert)
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
}
