import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {'name': 'Cats', 'iconPath': 'assets/cat.png'},
  {'name': 'Dogs', 'iconPath': 'assets/dog.png'},
  {'name': 'Bunnies', 'iconPath': 'assets/rabbit.png'},
  {'name': 'Parrots', 'iconPath': 'assets/parrot.png'},
  {'name': 'Horses', 'iconPath': 'assets/horse.png'}
];

List<Map> drawerItems = [
  {'icon': FontAwesomeIcons.userFriends, 'title': 'Profile'},
  {'icon': FontAwesomeIcons.donate, 'title': 'My Donation'},
  {'icon': FontAwesomeIcons.servicestack, 'title': 'My Services'},
  {'icon': Icons.favorite, 'title': 'Favorites'},
  {'icon': Icons.location_searching, 'title': 'Pet Locator'},
  {'icon': FontAwesomeIcons.facebookMessenger, 'title': 'Messages'},
];
