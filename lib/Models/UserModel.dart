import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class User {
  String name;
  String email;
  String password;
  String userid;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;
  static final currentuserid = FirebaseAuth.instance.currentUser.uid;
}
