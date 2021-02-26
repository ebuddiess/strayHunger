import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minor/screens/homePage/screen2.dart';

import 'configuration.dart';

class PetLocator extends StatefulWidget {
  @override
  _PetLocatorState createState() => _PetLocatorState();
}

class _PetLocatorState extends State<PetLocator> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    double medHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedContainer(
        curve: Curves.bounceOut,
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateZ(isDrawerOpen ? -0.1 : 0),
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
        child: Container(
          height: medHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: medHeight * 0.055,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
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
                                  scaleFactor = 0.6;
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.search),
                      Text('Search pet to adopt'),
                      Icon(Icons.settings)
                    ],
                  ),
                ),
                Container(
                  height: medHeight * 0.12,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset(
                                categories[index]['iconPath'],
                                height: 50,
                                width: 50,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(categories[index]['name'])
                          ],
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Screen2()));
                  },
                  child: Container(
                    height: medHeight * 0.24,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[300],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: shadowList,
                                ),
                                margin: EdgeInsets.only(top: 50),
                              ),
                              Align(
                                child: Hero(
                                    tag: 1,
                                    child: Image.asset('assets/pet-cat2.png')),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(top: 60, bottom: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadowList,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                        ))
                      ],
                    ),
                  ),
                ),
                Container(
                  height: medHeight * 0.24,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.orange[200],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: shadowList,
                              ),
                              margin: EdgeInsets.only(top: 50),
                            ),
                            Align(
                              child: Image.asset('assets/pet-cat1.png'),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(top: 60, bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowList,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                      ))
                    ],
                  ),
                ),
                Container(
                  height: medHeight * 0.24,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[300],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: shadowList,
                              ),
                              margin: EdgeInsets.only(top: 50),
                            ),
                            Align(
                              child: Hero(
                                  tag: 2,
                                  child: Image.asset('assets/pet-cat2.png')),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(top: 60, bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowList,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
