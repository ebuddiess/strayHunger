import 'package:flutter/material.dart';

import 'drawerScreen.dart';
import 'petLocator.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //Here we have two screen Drawer and HomeScreen
        children: [DrawerScreen(), PetLocator()],
      ),
    );
  }
}
