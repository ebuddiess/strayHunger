import 'package:flutter/material.dart';

class MyNavigator {
  static void goToPage(BuildContext context, String url) {
    Navigator.pushNamed(context, url);
  }

  static void goToPageViaReplace(BuildContext context, String url) {
    Navigator.pushReplacementNamed(context, url);
  }
}
