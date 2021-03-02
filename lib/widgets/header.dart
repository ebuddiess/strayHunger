import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    PickedFile image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      uploadedimage = File(_image.path);
    });
  }

  _imgFromGallery() async {
    PickedFile image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      uploadedimage = File(_image.path);
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
                  _imgFromGallery();
                },
                child: Text(
                  widget.text,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )),
          Container(
            child: Center(
              child: CircleAvatar(
                radius: 80,
                child: ClipOval(
                  child: (uploadedimage != null)
                      ? Image.file(uploadedimage)
                      : Image.asset('assets/cat.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
