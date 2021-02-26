import 'package:flutter/material.dart';

class MyNavigator {
  static void goToIntro(BuildContext context) {
    Navigator.pushNamed(context, "/intro");
  }

  static void goToSignIn(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }

  static void goToSignUP(BuildContext context) {
    Navigator.pushNamed(context, "/signup");
  }

  static void goToHomeScreen(BuildContext context) {
    Navigator.pushNamed(context, "/homescreen");
  }

  static void goToPetLocatorStack(BuildContext context) {
    Navigator.pushNamed(context, "/petlocator");
  }
}
