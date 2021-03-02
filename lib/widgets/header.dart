import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  var text = "";

  HeaderContainer(this.text);

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
                  print("ss");
                },
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )),
          Container(
            child: Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: ExactAssetImage('assets/userprofile.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
