import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minor/Models/UserModel.dart';

class HeaderContainer extends StatefulWidget {
  var text = "";

  HeaderContainer(this.text);

  @override
  _HeaderContainerState createState() => _HeaderContainerState();
}

class _HeaderContainerState extends State<HeaderContainer> {
  File uploadedimage;
  PickedFile _image;
  final ImagePicker _picker = ImagePicker();

  _imgFromCamera() async {
    _image = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );

    setState(() {
      uploadedimage = File(_image.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child("userprofile" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(uploadedimage);
      uploadTask.then((res) {
        res.ref.getDownloadURL().then((value) {
          UserModel.firestore
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .update({'profileimage': value});
        });
      });
    });
  }

  _imgFromGallery() async {
    _image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 10);

    setState(() {
      uploadedimage = File(_image.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child("userprofile" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(uploadedimage);
      uploadTask.then((res) {
        res.ref.getDownloadURL().then((value) {
          UserModel.firestore
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .update({'profileimage': value});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor
          ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 20,
              right: 20,
              child: FlatButton(
                color: Colors.purple,
                onPressed: () {
                  buildShowpicker();
                },
                child: Text(
                  widget.text,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )),
          Container(
            child: Center(
                child: StreamBuilder<DocumentSnapshot>(
                    stream: UserModel.firestore
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data.data()['profileimage'] != null) {
                        return CircleAvatar(
                          backgroundColor: Colors.pinkAccent,
                          radius: 100,
                          child: CircleAvatar(
                              radius: 98,
                              backgroundImage: Image.network(
                                snapshot.data.data()['profileimage'],
                                fit: BoxFit.cover,
                              ).image),
                        );
                      } else {
                        return CircleAvatar(
                          backgroundColor: Colors.pinkAccent,
                          radius: 100,
                          child: CircleAvatar(
                              radius: 98,
                              backgroundImage: Image.asset(
                                'assets/cat.png',
                                fit: BoxFit.cover,
                              ).image),
                        );
                      }
                    })),
          ),
        ],
      ),
    );
  }

  buildShowpicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
