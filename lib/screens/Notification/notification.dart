import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minor/Models/UserModel.dart';
import 'package:minor/utility/my_navigator.dart';

class BadgeNotification extends StatefulWidget {
  @override
  _BadgeNotificationState createState() => _BadgeNotificationState();
}

class _BadgeNotificationState extends State<BadgeNotification> {
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
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: UserModel.firestore
                  .collection('users')
                  .doc(UserModel.firebaseAuth.currentUser.uid)
                  .collection('request')
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = documents[index];
                        return Dismissible(
                          key: Key(documents[index]
                              .id
                              .toString()), // UniqueKey().toString()
                          onDismissed: (direction) {},
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20.0),
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: Card(
                            child: ListTile(
                              title: Text(data.get(FieldPath(['uid']))),
                            ),
                          ),
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
