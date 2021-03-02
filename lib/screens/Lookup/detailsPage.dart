import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minor/Models/UserModel.dart';

class DetailsPage extends StatefulWidget {
  String heroTag,
      username,
      useremail,
      usercity,
      userphone,
      userpin,
      useraddress;
  DocumentSnapshot data, currentuserdata;
  DetailsPage(
      {this.heroTag,
      this.username,
      this.useremail,
      this.usercity,
      this.userphone,
      this.userpin,
      this.useraddress,
      this.data,
      this.currentuserdata});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController taskedittext = new TextEditingController();
  var selectedCard = 'ANIMAL FEEDED';
  String requestStatus = 'Request';
  String uid = UserModel.firebaseAuth.currentUser.uid;
  @override
  void initState() {
    super.initState();
    UserModel.firestore
        .collection('users')
        .doc(widget.heroTag)
        .collection('request')
        .doc(uid)
        .snapshots()
        .listen((event) {
      if (event.exists) {
        setState(() {
          requestStatus = 'Cancel';
        });
      } else {
        setState(() {
          requestStatus = 'Request';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
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
        body: Container(
          child: Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.90,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent),
            Positioned(
                top: 15.0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width)),
            Positioned(
                top: 30.0,
                left: (MediaQuery.of(context).size.width / 2) - 100.0,
                child: Hero(
                    tag: widget.heroTag,
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/cat.png'),
                                fit: BoxFit.fill)),
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width * 0.4))),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.28,
                left: MediaQuery.of(context).size.height * 0.02,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.username,
                        style: TextStyle(
                            fontFamily: 'Overpass',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.useremail,
                            style: TextStyle(
                                fontFamily: 'Overpass',
                                fontSize: 15.0,
                                color: Colors.grey)),
                        Container(height: 25.0, color: Colors.grey, width: 1.0),
                        Container(
                          width: MediaQuery.of(context).size.height * 0.2,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.0),
                              color: Colors.purple),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                child: OutlineButton(
                                  borderSide: BorderSide.none,
                                  onPressed: () {
                                    print(widget.currentuserdata
                                        .get(FieldPath(['city'])));
                                    if (requestStatus.contains('Cancel')) {
                                      UserModel.firestore
                                          .collection('users')
                                          .doc(widget.heroTag)
                                          .collection('request')
                                          .doc(uid)
                                          .delete()
                                          .whenComplete(() {
                                        setState(() {
                                          requestStatus = 'Request';
                                        });
                                      });
                                    } else if (requestStatus
                                        .contains('Request')) {
                                      UserModel.firestore
                                          .collection('users')
                                          .doc(uid)
                                          .get()
                                          .then((value) {
                                        String currentuserprofileimage =
                                            value.data()['profileimage'];
                                        UserModel.firestore
                                            .collection('users')
                                            .doc(widget.heroTag)
                                            .collection('request')
                                            .doc(uid)
                                            .set({
                                              'patronimage':
                                                  currentuserprofileimage,
                                              'uid': uid,
                                              'request-type': 'Service',
                                              'username': widget.currentuserdata
                                                  .get(FieldPath(['username'])),
                                              'email': UserModel.firebaseAuth
                                                  .currentUser.email,
                                              'city': widget.currentuserdata
                                                  .get(FieldPath(['city'])),
                                              'pin': widget.currentuserdata
                                                  .get(FieldPath(['pin'])),
                                              'phone': widget.currentuserdata
                                                  .get(FieldPath(['phone'])),
                                              'task':
                                                  taskedittext.text.toString(),
                                              'date': DateTime.now()
                                                  .toIso8601String()
                                            })
                                            .catchError((error) =>
                                                {print(error.toString())})
                                            .whenComplete(() {
                                              setState(() {
                                                requestStatus = 'Cancel';
                                              });
                                            });
                                      });
                                    }
                                  },
                                  child: Text(requestStatus,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Overpass',
                                          fontSize: 15.0)),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.purple),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _buildInfoCard('Animal Feeded', '300'),
                            SizedBox(width: 5.0),
                            _buildInfoCard('CITY', widget.usercity),
                            SizedBox(width: 5.0),
                            _buildInfoCard('Pincode', widget.userpin),
                            SizedBox(width: 5.0),
                            _buildInfoCard('Address', widget.useraddress)
                          ],
                        )),
                    SizedBox(height: 20.0),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: taskedittext,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Assign a Task',
                          prefixIcon: Icon(Icons.ac_unit),
                        ),
                      ),
                    )
                  ],
                )),
          ]),
        ));
  }

  Widget _buildInfoCard(String cardTitle, String info) {
    return InkWell(
        onTap: () {
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: cardTitle == selectedCard ? Colors.purple : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75),
            ),
            height: MediaQuery.of(context).size.height * 0.10,
            width: 100.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontFamily: 'Overpass',
                          fontSize: 12.0,
                          color: cardTitle == selectedCard
                              ? Colors.white
                              : Colors.grey.withOpacity(0.9),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(info,
                            style: TextStyle(
                                fontFamily: 'Overpass',
                                fontSize: 14.0,
                                color: cardTitle == selectedCard
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ])));
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }
}
