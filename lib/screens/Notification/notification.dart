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
                Text('Notification',
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
                            onDismissed: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                UserModel.firestore
                                    .collection('users')
                                    .doc(UserModel.firebaseAuth.currentUser.uid)
                                    .get()
                                    .then((value) {
                                  // acceptin the ask and increasing acceptcount
                                  int accepted =
                                      value.get(FieldPath(['acceptCount']));
                                  accepted = accepted + 1;
                                  UserModel.firestore
                                      .collection('users')
                                      .doc(UserModel
                                          .firebaseAuth.currentUser.uid)
                                      .update({
                                    'acceptCount': accepted
                                  }).whenComplete(() {
                                    // generatin a response to the donater who request the provider with status wthere provider accepted it or not
                                    UserModel.firestore
                                        .collection('users')
                                        .doc(data.get(FieldPath(['uid'])))
                                        .collection('response')
                                        .doc(UserModel
                                            .firebaseAuth.currentUser.uid)
                                        .set({
                                      'username':
                                          data.get(FieldPath(['username'])),
                                      'uid': data.get(FieldPath(['uid'])),
                                      'requestStatus': 'accept',
                                      'taskStatus': 'incomplete',
                                      'responseacceptetime':
                                          DateTime.now().toIso8601String(),
                                      'requesttime':
                                          data.get(FieldPath(['date'])),
                                    }).whenComplete(() {
                                      //deletin the request when user accept it and generating the task
                                      UserModel.firestore
                                          .collection('users')
                                          .doc(UserModel
                                              .firebaseAuth.currentUser.uid)
                                          .collection('task')
                                          .doc(data.get(FieldPath(['uid'])))
                                          .set({
                                            'groundHeroid': UserModel
                                                .firebaseAuth.currentUser.uid,
                                            'Patronid':
                                                data.get(FieldPath(['uid'])),
                                            'Patron Name': data
                                                .get(FieldPath(['username'])),
                                            'status': 'incomplete',
                                            'task': data
                                                .get(FieldPath(['username']))
                                          })
                                          .whenComplete(() => {
                                                //making a task collection sepearated
                                                UserModel.firestore
                                                    .collection('task')
                                                    .doc(data.get(
                                                        FieldPath(['uid'])))
                                                    .set({
                                                  'groundHeroid': UserModel
                                                      .firebaseAuth
                                                      .currentUser
                                                      .uid,
                                                  'Patronid': data
                                                      .get(FieldPath(['uid'])),
                                                  'Patron Name': data.get(
                                                      FieldPath(['username'])),
                                                  'status': 'incomplete',
                                                  'task': data.get(
                                                      FieldPath(['username']))
                                                })
                                              })
                                          .whenComplete(() {
                                            int totaltask = value
                                                .get(FieldPath(['totaltask']));
                                            totaltask = totaltask + 1;
                                            int totalrequest = value.get(
                                                FieldPath(['totalrequest']));
                                            totalrequest = totalrequest + 1;
                                            UserModel.firestore
                                                .collection('users')
                                                .doc(UserModel.firebaseAuth
                                                    .currentUser.uid)
                                                .update({
                                              'totaltask': totaltask,
                                              'totalrequest': totalrequest
                                            });
                                          });
                                      print(documents[index].id);

                                      UserModel.firestore
                                          .collection('users')
                                          .doc(UserModel
                                              .firebaseAuth.currentUser.uid)
                                          .collection('request')
                                          .doc(documents[index].id)
                                          .delete();
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(content: Text('Accepted')));
                                    });
                                  });
                                });
                              } else if (direction ==
                                  DismissDirection.endToStart) {
                                UserModel.firestore
                                    .collection('users')
                                    .doc(UserModel.firebaseAuth.currentUser.uid)
                                    .get()
                                    .then((value) {
                                  int rejectcount =
                                      value.get(FieldPath(['rejectCount']));
                                  rejectcount = rejectcount + 1;

                                  UserModel.firestore
                                      .collection('users')
                                      .doc(UserModel
                                          .firebaseAuth.currentUser.uid)
                                      .update({
                                    'rejectCount': rejectcount
                                  }).whenComplete(() {
                                    UserModel.firestore
                                        .collection('users')
                                        .doc(UserModel
                                            .firebaseAuth.currentUser.uid)
                                        .collection('request')
                                        .doc(documents[index].id)
                                        .delete();

                                    int totaltask =
                                        value.get(FieldPath(['totaltask']));
                                    totaltask = totaltask + 1;
                                    int totalrequest =
                                        value.get(FieldPath(['totalrequest']));
                                    totalrequest = totalrequest + 1;
                                    UserModel.firestore
                                        .collection('users')
                                        .doc(UserModel
                                            .firebaseAuth.currentUser.uid)
                                        .update({
                                      'totaltask': totaltask,
                                      'totalrequest': totalrequest
                                    });
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(content: Text('Rejected')));
                                  });
                                });
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(children: [
                                      Hero(
                                          tag: 1,
                                          child: Image(
                                              image:
                                                  AssetImage('assets/cat.png'),
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
                                                    Icons.verified_user_rounded,
                                                    size: 15),
                                                SizedBox(width: 5),
                                                Text(
                                                    data.get(FieldPath(
                                                        ['username'])),
                                                    style: TextStyle(
                                                        fontFamily: 'Overpass',
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
                                                    data.get(
                                                        FieldPath(['email'])),
                                                    style: TextStyle(
                                                        fontFamily: 'Overpass',
                                                        fontSize: 15.0,
                                                        color: Colors.grey)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.pin_drop, size: 15),
                                                SizedBox(width: 5),
                                                Text(
                                                    data.get(
                                                        FieldPath(['pin'])),
                                                    style: TextStyle(
                                                        fontFamily: 'Overpass',
                                                        fontSize: 15.0,
                                                        color: Colors.grey)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.work, size: 15),
                                                SizedBox(width: 5),
                                                Text(
                                                    data.get(
                                                        FieldPath(['task'])),
                                                    style: TextStyle(
                                                        fontFamily: 'Overpass',
                                                        fontSize: 15.0,
                                                        color: Colors.grey)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.location_city,
                                                    size: 15),
                                                SizedBox(width: 5),
                                                Text(
                                                    data.get(
                                                        FieldPath(['city'])),
                                                    style: TextStyle(
                                                        fontFamily: 'Overpass',
                                                        fontSize: 15.0,
                                                        color: Colors.grey)),
                                              ],
                                            )
                                          ])
                                    ])),
                              ],
                            ));
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
