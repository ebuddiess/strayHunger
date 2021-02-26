import 'package:flutter/material.dart';
import 'package:minor/screens/DemoScreen.dart';
import 'package:minor/screens/UsersScreens/userProfile.dart';
import 'package:minor/screens/authScreens/loginScreen.dart';
import 'package:minor/screens/authScreens/signupScreen.dart';
import 'package:minor/screens/homePage/homeScreens/homepage.dart';
import 'package:minor/screens/homePage/petLocator/petLocatorstack.dart';
import 'package:minor/screens/initalScreens/introscreen.dart';
import 'package:minor/screens/initalScreens/splash_screen.dart';

var routes = <String, WidgetBuilder>{
  "/intro": (BuildContext context) => IntroScreen(),
  "/login": (BuildContext context) => Loginscreen(),
  "/signup": (BuildContext context) => SignUpScreen(),
  "/homescreen": (BuildContext context) => HomePage(),
  "/petlocator": (BuildContext context) => PetLocatorStack(),
  "/userProfile": (BuildContext context) => UserProfile(),
};

void main() => runApp(new MaterialApp(
    theme: ThemeData(
        primaryColor: Colors.pink[500], accentColor: Colors.pink[700]),
    debugShowCheckedModeBanner: false,
    //home: SplashScreen(),
    home: HomePage(),
    //home: DemoScreen(),
    routes: routes));
