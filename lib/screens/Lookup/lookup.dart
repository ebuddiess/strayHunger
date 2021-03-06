import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minor/Models/UserModel.dart';
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: medheight * 0, left: medheight * 0.010),
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
              height: MediaQuery.of(context).size.height * 0.78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: UserModel.firestore
                    .collection('users')
                    .where('userid',
                        isNotEqualTo:
                            UserModel.firebaseAuth.currentUser.uid.toString())
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents = snapshot.data.docs;
                    return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = documents[index];
                          print(data.data()['username']);

                          return _buildlookdata(
                              data.get(FieldPath(['username'])),
                              data.get(
                                FieldPath(['status']),
                              ),
                              data.get(
                                FieldPath(['city']),
                              ),
                              data.get(
                                FieldPath(['userid']),
                              ),
                              data);
                        });
                  } else if (snapshot.hasError) {
                    return ListTile(title: Text('No DATA CURRENTLY'));
                  } else if (!snapshot.hasData) {
                    return ListTile(title: Text('No DATA CURRENTLY'));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildlookdata(String name, String status, String city, String tag,
      DocumentSnapshot data) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              DocumentSnapshot userdata;
              UserModel.firestore
                  .collection('users')
                  .doc(UserModel.firebaseAuth.currentUser.uid)
                  .get()
                  .then((value) {
                userdata = value;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailsPage(
                          heroTag: data.get(FieldPath(['userid'])),
                          username: data.get(FieldPath(['username'])),
                          useraddress: data.get(FieldPath(['address'])),
                          usercity: data.get(FieldPath(['city'])),
                          useremail: data.get(FieldPath(['email'])),
                          userphone: data.get(FieldPath(['phone'])),
                          userpin: data.get(FieldPath(['pin'])),
                          data: data,
                          currentuserdata: userdata,
                        )));
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      Hero(
                          tag: tag,
                          child: ClipOval(
                            child: Image(
                                image: data.data()['profileimage'].toString() !=
                                        ''
                                    ? NetworkImage(
                                        data.data()['profileimage'].toString())
                                    : AssetImage('assets/plate3.png'),
                                fit: BoxFit.cover,
                                height: 75.0,
                                width: 75.0),
                          )),
                      SizedBox(width: 10.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                                style: TextStyle(
                                    fontFamily: 'Overpass',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 5,
                                ),
                                SizedBox(width: 5),
                                Text(status,
                                    style: TextStyle(
                                        fontFamily: 'Overpass',
                                        fontSize: 15.0,
                                        color: Colors.grey)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_city, size: 15),
                                SizedBox(width: 5),
                                Text(city,
                                    style: TextStyle(
                                        fontFamily: 'Overpass',
                                        fontSize: 15.0,
                                        color: Colors.grey)),
                              ],
                            )
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
