import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minor/Models/UserModel.dart';
import 'package:minor/utility/my_navigator.dart';

class BadgeResponse extends StatefulWidget {
  @override
  _BadgeResponseState createState() => _BadgeResponseState();
}

class _BadgeResponseState extends State<BadgeResponse> {
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
                Text('Response',
                    style: TextStyle(
                        fontFamily: 'Overpass',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: UserModel.firestore
                  .collection('users')
                  .doc(UserModel.firebaseAuth.currentUser.uid)
                  .collection('response')
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                String responsetype = 'responseacceptetime';
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = documents[index];
                        if (data.data()['responseacceptetime'] == null) {
                          print(responsetype);
                          responsetype = 'responserejectetime';
                        } else if (data.data()['responseacceptetime'] != null) {
                          responsetype = 'responseacceptetime';
                          print(responsetype);
                        }
                        return AbsorbPointer(
                          absorbing: (data.data()['taskStatus'] == 'complete' ||
                                  data.data()['requestStatus'] == 'reject')
                              ? false
                              : true,
                          child: Dismissible(
                              direction: DismissDirection.endToStart,
                              key: Key(documents[index]
                                  .id
                                  .toString()), // UniqueKey().toString()
                              onDismissed: (direction) {
                                if (direction == DismissDirection.endToStart) {
                                  UserModel.firestore
                                      .collection('users')
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .collection('response')
                                      .doc(data.get(FieldPath(['uid'])))
                                      .delete();
                                }
                              },
                              secondaryBackground: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20.0),
                                color: Colors.redAccent,
                              ),
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20.0),
                                color: Colors.green,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(children: [
                                        Hero(
                                            tag: 1,
                                            child: Image(
                                                image: NetworkImage(data.get(
                                                    FieldPath(
                                                        ['groundheroimage']))),
                                                fit: BoxFit.cover,
                                                height: 75.0,
                                                width: 75.0)),
                                        SizedBox(width: 10.0),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .verified_user_rounded,
                                                      size: 15),
                                                  SizedBox(width: 5),
                                                  Text(
                                                      data.get(FieldPath(
                                                          ['username'])),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Overpass',
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              SizedBox(width: 5),
                                              Row(
                                                children: [
                                                  Icon(Icons.email, size: 15),
                                                  SizedBox(width: 5),
                                                  Text(
                                                      data.get(FieldPath(
                                                          ['requestStatus'])),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Overpass',
                                                          fontSize: 15.0,
                                                          color: Colors.grey)),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.pin_drop,
                                                      size: 15),
                                                  SizedBox(width: 5),
                                                  Text(
                                                      data.get(FieldPath([
                                                        responsetype.toString()
                                                      ])),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Overpass',
                                                          fontSize: 15.0,
                                                          color: Colors.grey)),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.work, size: 15),
                                                  SizedBox(width: 5),
                                                  Text(
                                                      data.get(FieldPath(
                                                          ['taskStatus'])),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Overpass',
                                                          fontSize: 15.0,
                                                          color: Colors.grey)),
                                                ],
                                              ),
                                            ])
                                      ])),
                                ],
                              )),
                        );
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
    );
  }
}
