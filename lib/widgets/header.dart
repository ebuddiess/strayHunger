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
    _image = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );

    setState(() {
      uploadedimage = File(_image.path);
    });
  }

  _imgFromGallery() async {
    _image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 10);

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
                  buildShowpicker();
                },
                child: Text(
                  widget.text,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )),
          Container(
            child: Center(
                child: CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              radius: 100,
              child: CircleAvatar(
                radius: 98,
                backgroundImage: Image.file(
                  uploadedimage,
                  fit: BoxFit.cover,
                ).image,
              ),
            )),
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
