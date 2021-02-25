import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minor/utility/assets_manager.dart';
import 'package:minor/utility/color_manager.dart';
import 'package:minor/utility/my_navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => MyNavigator.goToIntro(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                child: Image.asset(AssetsManager.applogopng),
                padding: EdgeInsets.all(30.0),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Feeding the hunger ...',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: ColorManager.textcolorblack),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
