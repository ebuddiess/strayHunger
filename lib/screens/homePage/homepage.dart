import 'package:flutter/material.dart';
import 'package:minor/screens/homePage/drawerScreen.dart';
import 'package:minor/screens/homePage/petLocatorstack.dart';

import 'homescreenstack.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreenStack(),
    );
  }
}
