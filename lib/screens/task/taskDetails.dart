import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minor/Models/UserModel.dart';

class TaskDetails extends StatefulWidget {
  DocumentSnapshot data, currentuserdata;
  TaskDetails({
    this.data,
  });

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  TextEditingController animalfeedcontroller = new TextEditingController();
  TextEditingController localitycontroller = new TextEditingController();
  TextEditingController foodprovidedcontroller = new TextEditingController();
  TextEditingController completedtimecontroller = new TextEditingController();

  var selectedCard = 'ANIMAL FEEDED';
  String requestStatus = 'Submit';
  String uid = UserModel.firebaseAuth.currentUser.uid;
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
            color: Colors.white,
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blueGrey[300],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          )),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  IconButton(icon: Icon(Icons.share), onPressed: () {})
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Hero(tag: 1, child: Image.asset('assets/pet-cat2.png')),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.verified_user_rounded, size: 15),
                          SizedBox(width: 5),
                          Text(widget.data.get(FieldPath(['Patron Name'])),
                              style: TextStyle(
                                  fontFamily: 'Overpass',
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(width: 5),
                      Row(
                        children: [
                          Icon(Icons.bar_chart, size: 15),
                          SizedBox(width: 5),
                          Text(widget.data.get(FieldPath(['status'])),
                              style: TextStyle(
                                  fontFamily: 'Overpass',
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.timelapse, size: 15),
                          SizedBox(width: 5),
                          Text(widget.data.get(FieldPath(['taskcreatedtime'])),
                              style: TextStyle(
                                  fontFamily: 'Overpass',
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.description, size: 15),
                          SizedBox(width: 5),
                          Text(widget.data.get(FieldPath(['task'])),
                              style: TextStyle(
                                  fontFamily: 'Overpass',
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: animalfeedcontroller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Animal Feeded',
                                  prefixIcon: Icon(Icons.donut_large),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: localitycontroller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Locality',
                                  prefixIcon: Icon(Icons.location_city),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: completedtimecontroller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Completed Date',
                                  prefixIcon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: foodprovidedcontroller,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Food Provided',
                                  prefixIcon: Icon(Icons.food_bank),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 30,
                        offset: Offset(0, 10))
                  ],
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 100,
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: OutlineButton(
                        borderSide: BorderSide.none,
                        onPressed: () {
                          UserModel.firestore
                              .collection('users')
                              .doc(uid)
                              .collection('task')
                              .doc(widget.data.id)
                              .update({
                            'status': 'complete',
                            'animalfeeded':
                                int.parse(animalfeedcontroller.value.text),
                            'locality': localitycontroller.value.text,
                            'completeddate': completedtimecontroller.value.text,
                            'foodprovided': foodprovidedcontroller.value.text
                          }).whenComplete(() => {
                                    UserModel.firestore
                                        .collection('task')
                                        .doc(widget.data.id)
                                        .update({
                                      'status': 'complete',
                                      'animalfeeded': int.parse(
                                          animalfeedcontroller.value.text),
                                      'locality': localitycontroller.value.text,
                                      'completeddate':
                                          completedtimecontroller.value.text,
                                      'foodprovided':
                                          foodprovidedcontroller.value.text
                                    })
                                  });
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      )),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
