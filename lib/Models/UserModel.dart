import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserModel {
  String name;
  String email;
  String password;
  String userid;
  String city;
  String pincode;
  String address;

  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;
}
