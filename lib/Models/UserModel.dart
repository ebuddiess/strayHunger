import 'package:firebase_auth/firebase_auth.dart';

class User {
  String name;
  String email;
  String password;
  String userid;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
}
