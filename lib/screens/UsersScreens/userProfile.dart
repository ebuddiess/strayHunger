import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minor/Models/UserModel.dart';
import 'package:minor/widgets/customButton.dart';
import 'package:minor/widgets/header.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController adresscontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isSwitched = false;
  var textValue = 'Ground Buddy';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("userid" + UserModel.firebaseAuth.currentUser.uid);
    print(FirebaseAuth.instance.currentUser.uid);
    UserModel.firestore
        .collection("users")
        .doc(UserModel.firebaseAuth.currentUser.uid)
        .get()
        .then((value) {
      namecontroller.text = value.get(FieldPath(['username']));
      phonecontroller.text = value.get(FieldPath(['phone']));
      adresscontroller.text = value.get(FieldPath(['address']));
      citycontroller.text = value.get(FieldPath(['city']));
      pincontroller.text = value.get(FieldPath(['pin']));
    });
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Patron Buddy';
        UserModel.firestore
            .collection('users')
            .doc(UserModel.firebaseAuth.currentUser.uid)
            .update({'roletype': textValue});
      });
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Ground Buddy';
        UserModel.firestore
            .collection('users')
            .doc(UserModel.firebaseAuth.currentUser.uid)
            .update({'roletype': textValue});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Upload"),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(
                      hint: "Full Name",
                      icon: Icons.person,
                      controller: namecontroller,
                    ),
                    _textInput(
                        hint: "Phone Number",
                        icon: Icons.call,
                        controller: phonecontroller),
                    _textInput(
                        hint: "Address",
                        icon: Icons.add_road,
                        controller: adresscontroller),
                    _textInput(
                        hint: "City",
                        icon: Icons.location_city_sharp,
                        controller: citycontroller),
                    _textInput(
                        hint: "Pincode",
                        icon: Icons.pin_drop,
                        controller: pincontroller),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Switch(
                            onChanged: toggleSwitch,
                            value: isSwitched,
                            activeColor: Theme.of(context).primaryColor,
                            activeTrackColor: Theme.of(context).accentColor,
                            inactiveThumbColor: Colors.redAccent,
                            inactiveTrackColor: Colors.purple,
                          ),
                          Text(textValue),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          btnText: "SAVE",
                          onClick: () {
                            saveUserDetails(context);
                          },
                        ),
                      ),
                    ),
                    OutlineButton(
                      borderSide: BorderSide.none,
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'BACK',
                        style: TextStyle(color: Colors.pinkAccent),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textInput({controller, hint, icon, initialvalue}) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        initialValue: initialvalue,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Future<void> saveUserDetails(context) {
    setState(() {
      UserModel.firebaseAuth.currentUser
          .updateProfile(displayName: namecontroller.text)
          .whenComplete(() {
        UserModel.firestore
            .collection('users')
            .doc(UserModel.firebaseAuth.currentUser.uid)
            .update({
          'username': UserModel.firebaseAuth.currentUser.displayName.toString(),
          'phone': phonecontroller.text,
          'address': adresscontroller.text,
          'pin': pincontroller.text,
          'city': citycontroller.text,
        }).whenComplete(() => scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text('Saved'))));
      });
    });
  }
}
