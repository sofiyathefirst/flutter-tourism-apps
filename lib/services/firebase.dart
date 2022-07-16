import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_project/services/user_model.dart';

Future userSetup(
    String name, String pnum, String email, String password) async {
  await FirebaseFirestore.instance.collection('users').add({
    'name': name,
    'phonenum': pnum,
    'email': email,
    'password': password,
  });
}
