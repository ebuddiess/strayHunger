import 'package:flutter/material.dart';
import 'package:minor/utility/my_navigator.dart';

import 'detailsPage.dart';

class Lookup extends StatefulWidget {
  @override
  _LookupState createState() => _LookupState();
}

class _LookupState extends State<Lookup> {
  @override
  Widget build(BuildContext context) {
    double medheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: medheight * 0.040, left: medheight * 0.010),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    MyNavigator.goToPage(context, '/homescreen');
                  },
                ),
                Container(
                    width: medheight * 0.125,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.filter_list),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Ground Hero',
                    style: TextStyle(
                        fontFamily: 'Overpass',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),
                Text('In New Delhi',
                    style: TextStyle(
                        fontFamily: 'Overpass',
                        color: Colors.white,
                        fontSize: 25.0))
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            height: MediaQuery.of(context).size.height - 158.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height - 300.0,
                        child: ListView(children: [
                          _buildlookdata(),
                        ]))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildlookdata() {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => DetailsPage(
              //         heroTag: null, foodName: 'Puneet', foodPrice: 'Online')));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: [
                  Hero(
                      tag: 1,
                      child: Image(
                          image: AssetImage('assets/cat.png'),
                          fit: BoxFit.cover,
                          height: 75.0,
                          width: 75.0)),
                  SizedBox(width: 10.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Puneet',
                            style: TextStyle(
                                fontFamily: 'Overpass',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                        Text('Online',
                            style: TextStyle(
                                fontFamily: 'Overpass',
                                fontSize: 15.0,
                                color: Colors.grey))
                      ])
                ])),
                IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.black,
                    onPressed: () {})
              ],
            )));
  }
}
