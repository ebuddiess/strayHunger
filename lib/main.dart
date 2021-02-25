import 'package:flutter/material.dart';
import 'package:minor/screens/DemoScreen.dart';
import 'package:minor/screens/introscreen.dart';
import 'package:minor/screens/splash_screen.dart';

var routes = <String, WidgetBuilder>{
  "/intro": (BuildContext context) => IntroScreen(),
};

void main() => runApp(new MaterialApp(
    theme: ThemeData(
        primaryColor: Colors.pink[500], accentColor: Colors.pink[700]),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    //home: DemoScreen(),
    routes: routes));
