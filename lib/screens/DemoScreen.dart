import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SvgPicture.asset('assets/applogo.svg'),
    ));
  }
}
